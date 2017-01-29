//
//  Topping.swift
//  PizzaTime
//
//  Created by dw on 1/22/17.
//  Copyright © 2017 WilliamsAssociates. All rights reserved.
//

import Foundation

class Topping {
  // class definition goes here
  var ingredients = Set<String>()
  
  var commaSeparatedList: String {
    get {
      return (Array(ingredients.map { $0 })).joined(separator: ", ")
    }
  }
  
  var list: NSArray {
    get {
      return Array(ingredients.map { $0 }) as NSArray
    }
  }
  
}

