//
//  HistoricalEventInput.swift
//  GraphQL-Client
//
//  Created by Rumata on 11/16/17.
//  Copyright © 2017 Yalantis. All rights reserved.
//

import Foundation

extension HistoricalEventInput {

  init() {
    graphQLMap = [:]
  }

  mutating func prefill(with briefEvent: BriefHistoricalEvent) {
    id = briefEvent.id
    name = briefEvent.name
    date = briefEvent.date
    type = briefEvent.type
  }

  mutating func update(with fullEvent: FullHistoricalEvent) {
    id = fullEvent.id
    name = fullEvent.name
    date = fullEvent.date
    description = fullEvent.description
    type = fullEvent.type
  }

}
