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
          print ("number of items in array \(jsonResult.count)")
          for item in jsonResult {
            if let ingredients = item as? NSDictionary {
              for (key, value) in ingredients {
                
                print ("\(key)")
                if let top = value as? NSArray {
                  print ("number of items in array of dictionary \(top.count)")
                  print("Set count \(OrderViewController.topping.ingredients.count)")
                  var currentOrder = Order()
                  currentOrder.toppings = Set()
                  for i in top {
                    print("\(i)")
                    currentOrder.toppings.insert(i as! String)
                    if OrderViewController.topping.ingredients.contains(i as! String) {
                      print("Already exists - not adding")
                    } else {
                      print("This is new: \(i) - adding this one")
                      OrderViewController.topping.ingredients.insert(i as! String)
                    }
                    print("Unique Toppings = \(OrderViewController.topping.ingredients.count)")
                  }
                  arrToppings.insert(currentOrder.toppings, at: cnt)
                  cnt = cnt + 1
                  listOfOrders.append(currentOrder)
                }
              }
            }
          }
          print ("Here are the Unique \(OrderViewController.topping.ingredients.count) Toppings")
          for t in OrderViewController.topping.ingredients {
            print("\(t)")
          }
          
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
          
          print ("Here are the Unique Orders")
          for o in listOfUniqueOrders[0..<20] {
            print ("\(o.toppings) and \(o.numberOfTimesOrdered)")
          }
          
          
          
          //          if let pizzas : [NSDictionary] = jsonResult[0] as? [NSDictionary] {
          //            for pizza: NSDictionary in pizzas {
          //              for (name, value) in pizza {
          //                print("\(name) , \(value)")
          //              }
          //            }
          //          }
          //          for pizza in jsonResult {
          //            if let onePizza = pizza as? [NSDictionary] {
          //              for ingredients in onePizza {
          //                for (key, value) in ingredients {
          //                 print("\(key), \(value)")
          //                }
          //              }
          //            }
          //          }
        } catch { print ("Could not read the JSON file")}
      } catch { print ("Could not create the Initial Array from the JSON file")}
    }
    
    //    if let path = Bundle.main.path(forResource: "test", ofType: "json") {
    //      do {
    //        let jsonData = try NSData(contentsOfFile: path, options:NSData.ReadingOptions.mappedIfSafe)
    //        do {
    //          let jsonResult: NSDictionary = try JSONSerialization.jsonObject(with: jsonData as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
    //          if let people : [NSDictionary] = jsonResult["person"] as? [NSDictionary] {
    //            for person: NSDictionary in people {
    //              for (name,value) in person {
    //                print("\(name) , \(value)")
    //              }
    //            }
    //          }
    //        } catch {}
    //      } catch {}
    //    }
    
    print("hello")
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    
    // Do any additional setup after loading the view, typically from a nib.
    
    //    // get the file path for the file "test.json" in the playground bundle
    //    let filePath = Bundle.main.path(forResource: "iOS Take Home Assignment", ofType: "json")
    //
    //    // get the contentData
    //    let contentData = FileManager.default.contents(atPath: filePath!)
    //
    //    // get the string
    //    let content = NSString(data: contentData!, encoding: String.Encoding.utf8.rawValue) as? String
    //
    //    // print
    //    print("filepath: \(filePath!)")
    //
    //    if let c = content {
    //      print("content: \n\(c)")
    //    }
    
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
  
  /*
    Override to support conditional editing of the table view.
   override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    Return false if you do not want the specified item to be editable.
   return true
   }
   */
  
  /*
   // Override to support editing the table view.
   override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
   if editingStyle == .delete {
   // Delete the row from the data source
   tableView.deleteRows(at: [indexPath], with: .fade)
   } else if editingStyle == .insert {
   // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
   }
   }
   */
  
  /*
   // Override to support rearranging the table view.
   override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
   
   }
   */
  
  /*
   // Override to support conditional rearranging of the table view.
   override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
   // Return false if you do not want the item to be re-orderable.
   return true
   }
   */
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  

}

