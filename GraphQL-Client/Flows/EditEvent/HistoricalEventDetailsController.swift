//
//  HistoricalEventDetailsController.swift
//  GraphQL-Client
//
//  Created by Rumata on 11/11/17.
//  Copyright © 2017 Yalantis. All rights reserved.
//

import Foundation
import UIKit
import SwiftMessages
import SwiftyPickerPopover

private enum Mode {
  case edit, view
}

private enum ValidationError: String, LocalizedError {

  case name = "nameError"
  case description = "descriptionError"
  case date = "dateError"

  var errorDescription: String? {
    return self.rawValue
  }

}

class HistoricalEventDetailsController: UIViewController {

  var event: BriefHistoricalEvent? {
    get {
      fatalError()
    }
    set {
      if let newValue = newValue {
        mode = .view
        draftEvent.prefill(with: newValue)
        eventId = newValue.id
      }
    }
  }
  var draftEvent: HistoricalEventInput = {
    var draft = HistoricalEventInput()
    draft.type = .common

    return draft
  }()
  var eventId: String?

  @IBOutlet fileprivate weak var picture: TappableImageView!
  @IBOutlet fileprivate weak var typeIcon: TappableImageView!
  @IBOutlet fileprivate weak var dateBadge: DateBadge!
  @IBOutlet fileprivate weak var titleLabel: UITextView! {
    didSet {
      titleLabel.placeholder = "Add title"
    }
  }
  @IBOutlet fileprivate weak var descriptionLabel: UITextView! {
    didSet {
      descriptionLabel.placeholder = "Add description"
    }
  }
  fileprivate var actionButton: UIButton!

  fileprivate var mode: Mode = .edit
  fileprivate lazy var editableFields: [Editable] = [
    self.picture, self.typeIcon, self.dateBadge, self.titleLabel, self.descriptionLabel
  ]

  override func viewDidLoad() {
    super.viewDidLoad()

    setupViews()
    updateControllerMode()
    typeIcon.image = draftEvent.type.iconImage

    guard let eventId = eventId else {
      return
    }
    dateBadge.date = draftEvent.date
    titleLabel.observableText = draftEvent.name

    apollo.fetch(query: GetHistoricalEventQuery(id: eventId), cachePolicy: .returnCacheDataAndFetch) { (result, error) in
      guard let result = result else {
        print(error ?? "unknown error")
        return
      }

      let fullEvent = result.data!.historicalEvent
      self.draftEvent.description = fullEvent?.description ?? ""
      self.descriptionLabel.observableText = self.draftEvent.description ?? ""
    }
  }

  func setupViews() {
    actionButton = UIButton(type: .custom)
    actionButton.frame = CGRect(x: 0, y: 0, width: 55, height: 35)
    actionButton.setTitleColor(.blue, for: .normal)
    actionButton.addTarget(self, action: #selector(performAction), for: .touchUpInside)

    navigationItem.rightBarButtonItem = UIBarButtonItem(customView: actionButton)

    dateBadge.editHandler = {
      self.showDatePicker()
    }
    let typeMap = ["Common": "COMMON", "Great Person": "GREAT_PERSON", "Battle": "BATTLE"]
    typeIcon.tapHandler = {
      let sheet = UIAlertController(title: "Choose type", message: "", preferredStyle: .actionSheet)
      let handler: (UIAlertAction) -> Void = { action in
        let title = action.title!
        self.draftEvent.type = HistoricalEventType(rawValue: typeMap[title]!)!
        self.typeIcon.image = self.draftEvent.type.iconImage
      }
      let actions: [UIAlertAction] = typeMap.map({ (key, _) -> UIAlertAction in
        return UIAlertAction(title: key, style: .default, handler: handler)
      })
      actions.forEach { sheet.addAction($0) }
      self.present(sheet, animated: true, completion: nil)
    }
  }

}

private extension HistoricalEventDetailsController {

  func showDatePicker() {
    let months = (1...12).map { "\($0)" }
    let days = (1...30).map { "\($0)" }
    ColumnStringPickerPopover(
      title: "Choose date",
      choices: [["1989", "1544", "456", "23"], months, days, ["AD", "BC"]],
      selectedRows: [0, 0, 0, 0],
      columnPercents: [0.3, 0.25, 0.25, 0.2]
    ).setDoneButton { (_, selectedRows, selectedStrings) in
      let date = "\(selectedStrings[0])-\(selectedStrings[1])-\(selectedStrings[2]) \(selectedStrings[3])"
      self.dateBadge.date = date
      self.draftEvent.date = date
    }.setFontSize(14).appear(originView: dateBadge, baseViewController: self)
  }

  func updateControllerMode() {
    editableFields.forEach { field in
      var field = field
      field.isEditable = mode == .edit
    }
    actionButton.setTitle(mode == .view ? "Edit" : "Save", for: .normal)
    updatePicture()
  }

  func updatePicture() {
    picture.image = UIImage(named: "default_picture")
  }

  @objc func performAction() {
    if mode == .view {
      mode = .edit
      updateControllerMode()
    } else {
      if let error = validateEvent() {
        let errorView = MessageViewBuilder.makeError(with: error.localizedDescription)
        SwiftMessages.show(view: errorView)
      } else {
        createEvent()
      }
    }
  }

  func validateEvent() -> Error? {
    draftEvent.date = dateBadge.date ?? ""
    draftEvent.description = descriptionLabel.text
    draftEvent.name = titleLabel.text
    guard let name = draftEvent.graphQLMap["name"] as? String, !name.isEmpty else {
      return ValidationError.name
    }
    guard draftEvent.graphQLMap["date"] != nil else {
      return ValidationError.date
    }

    return nil
  }

  func createEvent() {
    apollo.perform(mutation: CreateHistoricalEventMutation(event: draftEvent), queue: .main) { (result, error) in
      guard let result = result else {
        let errorView = MessageViewBuilder.makeError(with: error?.localizedDescription ?? "Internal server error")
        SwiftMessages.show(view: errorView)
        return
      }
      guard let data = result.data else {
        let errorMessage = result.errors?.first?.localizedDescription ?? "Internal server error"
        let errorView = MessageViewBuilder.makeError(with: errorMessage)
        SwiftMessages.show(view: errorView)
        return
      }

      self.draftEvent = HistoricalEventInput(
        date: data.createEvent.date,
        description: data.createEvent.description,
        name: data.createEvent.name,
        type: data.createEvent.type
      )
      self.mode = .view
      self.updateControllerMode()
    }
  }

}
