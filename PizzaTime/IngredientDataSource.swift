//
//  IngredientDataSource.swift
//  PizzaTime
//
//  Created by dw on 1/26/17.
//  Copyright © 2017 WilliamsAssociates. All rights reserved.
//

import UIKit
import CoreData

class IngredientDataSource: NSObject, UITableViewDataSource {
  
  var ingredients: [Ingredient] = []
  static var pizza : Pizza!
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return (IngredientDataSource.pizza.ingredients?.count)!
    
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
    //let ingredient = ingredients[indexPath.row]
    let ingredient = IngredientDataSource.pizza.ingredients?[indexPath.row] as! Ingredient
    cell.textLabel?.text = ingredient.name
    
    return cell
    
  }
}
