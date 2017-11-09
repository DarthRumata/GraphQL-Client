//
//  ViewController.swift
//  GraphQL-Client
//
//  Created by Rumata on 11/7/17.
//  Copyright © 2017 Yalantis. All rights reserved.
//

import UIKit
import Apollo

class ViewController: UIViewController {

  let apollo = ApolloClient(url: URL(string: "http://localhost:8181/graphql")!)

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    apollo.fetch(query: GetAllEventsQuery()) { (result, error) in
      guard let result = result else {
        print(error ?? "unknown error")
        return
      }

      print(result.data!.allEvents.map { $0.name })
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

