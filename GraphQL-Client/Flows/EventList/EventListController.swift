//
//  EventListController.swift
//  GraphQL-Client
//
//  Created by Rumata on 11/7/17.
//  Copyright © 2017 Yalantis. All rights reserved.
//

import UIKit
import CHTCollectionViewWaterfallLayout
import Apollo
import SwiftMessages

class EventListController: UIViewController {

  @IBOutlet fileprivate weak var refreshButton: UINavigationItem!
  @IBOutlet fileprivate weak var collectionView: UICollectionView!

  fileprivate var briefEvents: [BriefHistoricalEvent] = []
  fileprivate var cursor: String?
  fileprivate var fetchRequest: Cancellable?
  fileprivate let pageSize = 10
  fileprivate var isLoadingMoreData = false

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    configureCollection()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    updateEventList()
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "openDetails" {
      let destination = segue.destination as! HistoricalEventDetailsController
      destination.event = sender as? BriefHistoricalEvent
    } else {
      super.prepare(for: segue, sender: sender)
    }
  }

  @IBAction func refreshList(_ sender: Any) {
    updateEventList()
  }
  @IBAction func addEvent(_ sender: Any) {
    performSegue(withIdentifier: "openDetails", sender: nil)
  }

}

extension EventListController: UICollectionViewDataSource {

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return briefEvents.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let event = briefEvents[indexPath.item]
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BriefEventCell.id, for: indexPath) as! BriefEventCell
    cell.configure(with: event)

    return cell
  }

  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    let currentIndex = indexPath.item
    let pageCount = currentIndex / pageSize
    let indexOnLastPage = currentIndex - pageCount * pageSize
    let pageLeft = pageSize - indexOnLastPage

    if cursor != nil && currentIndex > 0 && pageLeft < 3 && !isLoadingMoreData {
      loadMoreData()
    }
  }

}

extension EventListController: CHTCollectionViewDelegateWaterfallLayout {

  func collectionView (_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
    let event = briefEvents[indexPath.item]
    let width = floor((collectionView.bounds.width - 35) / 2)
    return CGSize(width: width, height: BriefEventCell.calculateHeight(for: event, withWidth: width))
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let event = briefEvents[indexPath.item]
    performSegue(withIdentifier: "openDetails", sender: event)
  }
}

private extension EventListController {

  func configureCollection() {
    let layout = CHTCollectionViewWaterfallLayout()
    layout.columnCount = 2
    layout.itemRenderDirection = .chtCollectionViewWaterfallLayoutItemRenderDirectionLeftToRight
    layout.minimumColumnSpacing = 15
    layout.minimumInteritemSpacing = 15
    layout.sectionInset = UIEdgeInsets(top: 15, left: 10, bottom: 15, right: 10)
    collectionView.collectionViewLayout = layout
    let nib = UINib(nibName: BriefEventCell.id, bundle: nil)
    collectionView.register(nib, forCellWithReuseIdentifier: BriefEventCell.id)
    collectionView.dataSource = self
    collectionView.delegate = self
  }

  func updateEventList() {
    loadData { (events) in
      guard !events.isEmpty else {
        return
      }
      self.briefEvents = events
      self.collectionView.reloadData()
    }
  }

  func loadMoreData() {
    isLoadingMoreData = true
    loadData(cursor: cursor) { (events) in
      defer {
        self.isLoadingMoreData = false
      }
      guard !events.isEmpty else {
        return
      }

      self.briefEvents.append(contentsOf: events)
      self.collectionView.reloadData()
    }
  }

  func loadData(cursor: String? = nil, completion: @escaping ([BriefHistoricalEvent]) -> Void) {
    fetchRequest?.cancel()
    fetchRequest = apollo.fetch(query: GetEventsQuery(cursor: cursor), cachePolicy: .returnCacheDataAndFetch) { (result, error) in
      guard let result = result else {
        print(error ?? "unknown error")
        return
      }
      guard let data = result.data else {
        let errorMessage = result.errors?.first?.localizedDescription ?? "Internal server error"
        let errorView = MessageViewBuilder.makeError(with: errorMessage)
        SwiftMessages.show(view: errorView)
        return
      }
      let events = data.allEvents.items.map { BriefHistoricalEvent(snapshot: $0.snapshot) }
      if let cursor = data.allEvents.cursor {
        self.cursor = cursor
      }

      completion(events)
    }
  }
  
}

