//
//  ViewController.swift
//  PizzaTime
//
//  Created by dw on 1/18/17.
//  Copyright © 2017 WilliamsAssociates. All rights reserved.
//

import UIKit

class OrderViewController: UITableViewController {
  
  var topList = [Order]()
  var listOfUniqueOrders = [Order]()
  static var topping = Topping()
  var topPizzas = 20
  var twenty = 20
  var topListedOrders = UserDefaults.standard.integer(forKey: "TopOrderListCount")
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    topListedOrders = UserDefaults.standard.integer(forKey: "TopOrderListCount")
    
    var arrToppings = [Set<String>]()
    
    var listOfOrders = [Order]()
    
    var cnt = 0
    
    var added = [Set<String>]()
    
    
    
    if let path = Bundle.main.path(forResource: "iOS Take Home Assignment", ofType: "json") {
      do {
        let jsonData = try NSData(contentsOfFile: path, options:NSData.ReadingOptions.mappedIfSafe)
        do {
          let jsonResult: NSArray = try JSONSerialization.jsonObject(with: jsonData as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray
          
          // traverse the array of dictionaries
          for item in jsonResult {
            if let ingredients = item as? NSDictionary {
              for (_, value) in ingredients {
  
                // traverse each Pizza Order
                if let top = value as? NSArray {
                  
                  // create an Pizza Order to hold the toppings
                  let currentOrder = Order()
                  currentOrder.toppings = Set()
                  // traverse each topping for the current Pizza Order
                  for i in top {
                    currentOrder.toppings.insert(i as! String)
                    if OrderViewController.topping.ingredients.contains(i as! String) {
                    } else {
                      OrderViewController.topping.ingredients.insert(i as! String)
                    }
                  }
                  
                  arrToppings.insert(currentOrder.toppings, at: cnt)
                  cnt = cnt + 1
                  listOfOrders.append(currentOrder)
                }
              }
            }
          }
//          print ("Here are the Unique \(OrderViewController.topping.ingredients.count) Toppings")
//          for t in OrderViewController.topping.ingredients {
//            print("\(t)")
//          }
          
          var newOrder = Order()
          for elem in arrToppings {
            if !added.contains(elem) {
              added.append(elem)
              newOrder = Order()
              newOrder.toppings = elem
              listOfUniqueOrders.append(newOrder)
            }
          }
          
          for uniquePizza in listOfUniqueOrders {
            for pizzaOrder in listOfOrders {
              if uniquePizza.toppings == pizzaOrder.toppings {
                uniquePizza.numberOfTimesOrdered = uniquePizza.numberOfTimesOrdered + 1
              }
            }
          }
          
          
          listOfUniqueOrders = listOfUniqueOrders.sorted(by: { $0.numberOfTimesOrdered > $1.numberOfTimesOrdered })
          
//          print ("Here are the Unique Orders")
//          for o in listOfUniqueOrders[0..<20] {
//            print ("\(o.toppings) and \(o.numberOfTimesOrdered)")
//          }
          
        } catch { print ("Could not read the JSON file")}
      } catch { print ("Could not create the Initial Array from the JSON file")}
    }
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    tableView.reloadData()   // ...and it is also visible here.
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
    
    let newTop = UserDefaults.standard.integer(forKey: "TopOrderListCount")
    
    if newTop != -1 {
      return newTop
    } else {
      return twenty
    }
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    
    let pizza = listOfUniqueOrders[indexPath.row]
    
    let label = cell.viewWithTag(1000) as! UILabel
    let labelAmount = cell.viewWithTag(2000) as! UILabel
    
    let stringValue = pizza.commaSeparatedListOfToppings
    
    label.text = stringValue
    labelAmount.text = String("\(pizza.numberOfTimesOrdered)")
    
    // Configure the cell...
    return cell
  }
  
}

