//
//  MessageViewFactory.swift
//  GraphQL-Client
//
//  Created by Rumata on 11/16/17.
//  Copyright © 2017 Yalantis. All rights reserved.
//

import Foundation
import SwiftMessages

enum MessageViewBuilder {

  static func makeError(with text: String) -> MessageView {
    let view = MessageView.viewFromNib(layout: .MessageView)
    view.configureTheme(.error)
    view.button?.isHidden = true
    view.configureContent(title: "Error", body: text)

    return view
  }

}
