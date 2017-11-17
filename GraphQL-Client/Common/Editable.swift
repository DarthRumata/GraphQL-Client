//
//  Editable.swift
//  GraphQL-Client
//
//  Created by Rumata on 11/17/17.
//  Copyright © 2017 Yalantis. All rights reserved.
//

import Foundation
import UIKit

protocol Editable {
  var isEditable: Bool { get set }
}

extension UITextView: Editable {}
