//
//  ToppingViewController.swift
//  PizzaTime
//
//  Created by dw on 1/22/17.
//  Copyright © 2017 WilliamsAssociates. All rights reserved.
//

import UIKit

class ToppingViewController: UITableViewController {
  
  var topping = Topping()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    topping.ingredients = OrderViewController.topping.ingredients
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return topping.ingredients.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    // Configure the cell...
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    
    let label = cell.viewWithTag(1000) as! UILabel
    
    label.text = topping.list[indexPath.row] as? String
    
    return cell
    
  }
  
}
