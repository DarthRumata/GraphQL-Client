//
//  API+Extensions.swift
//  GraphQL-Client
//
//  Created by Rumata on 11/14/17.
//  Copyright © 2017 Yalantis. All rights reserved.
//

import Foundation
import UIKit

extension HistoricalEventType {
  
  var iconImage: UIImage {
    let image: UIImage
    switch self {
    case .battle:
      image = UIImage(named: "battle")!
      
    case .common:
      image = UIImage(named: "common")!
      
    case .greatPerson:
      image = UIImage(named: "great_person")!
      
    case .unknown(_):
      fatalError("unknown type")
    }
    
    return image
  }
  
}
