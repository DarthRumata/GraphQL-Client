//
//  BriefEventCell.swift
//  GraphQL-Client
//
//  Created by Rumata on 11/11/17.
//  Copyright © 2017 Yalantis. All rights reserved.
//

import Foundation
import UIKit

private let constHeight: CGFloat = 70

class BriefEventCell: UICollectionViewCell {

  static let id = String(describing: BriefEventCell.self)

  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var icon: UIImageView!
  @IBOutlet weak var dateContainer: DateBadge!

  override func awakeFromNib() {
    super.awakeFromNib()

    layer.cornerRadius = 5
    layer.masksToBounds = true
  }

  func configure(with event: BriefHistoricalEvent) {
    nameLabel.text = event.name
    dateContainer.date = event.date
    dateContainer.isEditable = false
    icon.image = event.type.iconImage
  }

  static func calculateHeight(for event: BriefHistoricalEvent, withWidth width: CGFloat) -> CGFloat {
    let iconHeight = ceil(width / 2)
    let attributes: [String: Any] = [NSFontAttributeName: UIFont(name: "AmericanTypewriter-Semibold", size: 17)!]
    let nameHeight = ceil(event.name.boundingRect(
      with: CGSize(width: width - 40, height: CGFloat.infinity),
      options: .usesLineFragmentOrigin,
      attributes: attributes,
      context: nil
      ).height)
    return constHeight + iconHeight + nameHeight
  }

}
