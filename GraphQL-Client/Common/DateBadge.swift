//
//  DateBadge.swift
//  GraphQL-Client
//
//  Created by Rumata on 11/13/17.
//  Copyright © 2017 Yalantis. All rights reserved.
//

import Foundation
import UIKit

class DateBadge: UIView, Editable {

  var editHandler: (() -> Void)?
  var isEditable: Bool = false {
    didSet {
      updateEditState()
    }
  }
  
  @IBOutlet fileprivate var dateLabel: UILabel!
  @IBOutlet fileprivate var editButton: UIButton!
  
  var date: String? {
    get {
      return dateLabel.text
    }
    set {
      dateLabel.text = newValue
      updateEditState()
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    let contentView = UINib(nibName: "DateBadge", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! UIView
    addSubview(contentView)
    contentView.topAnchor.constraint(equalTo: topAnchor).isActive = true
    contentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    contentView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    contentView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    layer.cornerRadius = 8
    layer.masksToBounds = true

    date = nil
  }

  @IBAction func didTapEdit() {
    editHandler?()
  }

  func updateEditState() {
    let isVisible = (dateLabel.text ?? "").isEmpty && isEditable
    editButton.setTitleColor(isVisible ? .white : .clear, for: .normal)
    editButton.isEnabled = isEditable
  }
  
}
