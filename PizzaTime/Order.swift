//
//  Order.swift
//  PizzaTime
//
//  Created by dw on 1/20/17.
//  Copyright © 2017 WilliamsAssociates. All rights reserved.
//

import Foundation
import UIKit

class Order {
  // class definition goes here
  var toppings = Set<String>()
  var numberOfTimesOrdered = 0
  
  var commaSeparatedListOfToppings: String {
    get {
      return (Array(toppings.map { $0 })).joined(separator: ", ")
    }
  }
}
