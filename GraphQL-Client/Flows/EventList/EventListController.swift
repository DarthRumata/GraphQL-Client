//
//  EventListController.swift
//  GraphQL-Client
//
//  Created by Rumata on 11/7/17.
//  Copyright © 2017 Yalantis. All rights reserved.
//

import UIKit
import CHTCollectionViewWaterfallLayout

class EventListController: UIViewController {

  @IBOutlet fileprivate weak var refreshButton: UINavigationItem!
  @IBOutlet fileprivate weak var collectionView: UICollectionView!

  fileprivate var briefEvents: [BriefHistoricalEvent] = []

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
      self.briefEvents = events
      self.collectionView.reloadData()
    }
  }

  func loadData(completion: @escaping ([BriefHistoricalEvent]) -> Void) {
    apollo.fetch(query: GetAllEventsQuery(), cachePolicy: .returnCacheDataAndFetch) { (result, error) in
      guard let result = result else {
        print(error ?? "unknown error")
        return
      }
      let events = result.data!.allEvents.map { BriefHistoricalEvent(snapshot: $0.snapshot) }
      completion(events)
    }
  }
  
}

