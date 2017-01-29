//
//  PizzaDataSource.swift
//  PizzaTime
//
//  Created by dw on 1/26/17.
//  Copyright © 2017 WilliamsAssociates. All rights reserved.
//

import UIKit
import CoreData

class PizzaDataSource: NSObject, UITableViewDataSource {
  
  var pizzas = [Pizza]()
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return pizzas.count
    
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
    let pizza = pizzas[indexPath.row]
    cell.textLabel?.text = pizza.name
    
    return cell
    
  }
  
}
