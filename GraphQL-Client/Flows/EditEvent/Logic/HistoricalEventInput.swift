//
//  HistoricalEventInput.swift
//  GraphQL-Client
//
//  Created by Rumata on 11/16/17.
//  Copyright © 2017 Yalantis. All rights reserved.
//

import Foundation

extension HistoricalEventInput {

  mutating func prefill(with briefEvent: BriefHistoricalEvent) {
    name = briefEvent.name
    date = briefEvent.date
    type = briefEvent.type
  }

  init() {
    graphQLMap = [:]
  }

}
