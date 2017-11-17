//
//  TappableImageView.swift
//  GraphQL-Client
//
//  Created by Rumata on 11/17/17.
//  Copyright © 2017 Yalantis. All rights reserved.
//

import Foundation
import UIKit
import ActionKit

class TappableImageView: UIImageView, Editable {

  var tapHandler: (() -> Void)?
  var isEditable: Bool {
    get {
      return isUserInteractionEnabled
    }
    set {
      isUserInteractionEnabled = newValue
      updateHighlightState()
    }
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)

    let recognizer = UITapGestureRecognizer() { [weak self] in
      self?.tapHandler?()
    }
    addGestureRecognizer(recognizer)
  }

  func updateHighlightState() {
    layer.borderColor = UIColor.blue.cgColor
    layer.borderWidth = isUserInteractionEnabled ? 3 : 0
  }

}
