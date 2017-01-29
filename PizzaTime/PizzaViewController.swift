//
//  PizzaViewController.swift
//  PizzaTime
//
//  Created by dw on 1/23/17.
//  Copyright © 2017 WilliamsAssociates. All rights reserved.
//

import UIKit
import CoreData

var coreDataStack = CoreDataStack(modelName: "PizzaTimeModel")

class PizzaViewController: UITableViewController {
  
  
  var store = PizzaStore()
  let pizzaDataSource = PizzaDataSource()
  
  var selectedIndexPaths = [IndexPath]()
  
  
  //@IBOutlet weak var tableView: UITableView!
  
  var pizzas: [NSManagedObject] = []
  
  @IBAction func done(_ sender: UIBarButtonItem) {
    presentingViewController?.dismiss(animated: true, completion: nil)
  }
  
  @IBAction func addPizza(_ sender: UIBarButtonItem) {
    let alertController = UIAlertController(title: "Add Pizza", message: nil, preferredStyle:.alert)
    alertController.addTextField {
      (textField)-> Void in
      textField.placeholder = "pizza name"
      textField.autocapitalizationType = .words
    }
    
    let okAction = UIAlertAction(title: "OK", style: .default) {
      (action)-> Void in
      
      if let pizzaName = alertController.textFields?.first?.text {
        let context = self.store.persistentContainer.viewContext
        let newPizza = NSEntityDescription.insertNewObject(forEntityName: "Pizza", into: context)
        newPizza.setValue(pizzaName, forKey: "name")
        
        do {
          try self.store.persistentContainer.viewContext.save()
        } catch let error {
          print("Core Data save failed: \(error)")
        }
        self.updatePizzas()
      }
    }
    alertController.addAction(okAction)
    
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    alertController.addAction(cancelAction)
    
    present(alertController, animated: true, completion: nil)
  }
  
  // Implement the addName IBAction
  @IBAction func addName(_ sender: UIBarButtonItem) {
    let alert = UIAlertController(title: "New Name", message: "Add a new Pizza", preferredStyle: .alert)
    let saveAction = UIAlertAction(title: "Save",
                                   style: .default) {
      [unowned self] action in
                                    
      guard let textField = alert.textFields?.first,
        let nameToSave = textField.text else {
          return
      }
      self.save(name: nameToSave)
      self.tableView.reloadData()
    }
    let cancelAction = UIAlertAction(title: "Cancel", style: .default)
    alert.addTextField()
    alert.addAction(saveAction)
    alert.addAction(cancelAction)
    present(alert, animated: true)
  
  }
  
  var managedContext: NSManagedObjectContext!
  
  var currentPizza: Pizza?
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      tableView.dataSource = pizzaDataSource
      tableView.delegate = self
      
      self.updateDataSource()

      
      title = "Pizza Configurations"
      tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

        // Do any additional setup after loading the view.
      
//      let pizzaName = "Pepperoni"
//      let pizzaFetch: NSFetchRequest<Pizza> = Pizza.fetchRequest()
//      pizzaFetch.predicate = NSPredicate(format: "%K == %@", keyPath(Pizza.name), pizzaName)
//      
//      do {
//        let results = try managedContext.fetch(pizzaFetch)
//        if results > 0 {
//          // Pepperoini found, use Pepperoni
//          currentPizza = results.first
//        } else {
//          currentPizza = Pizza(context: managedContext)
//          currentPizza?.name = pizzaName
//          try managedContext.save()
//        }
//      } catch let error as NSError {
//        print("Fetch error: \(error) description: \(error.userInfo)")
//      }
    }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    switch segue.identifier {
    case "showIngredients"?:
      let navController = segue.destination as! UINavigationController
      let ingredientController = navController.topViewController as! IngredientViewController
      ingredientController.store = store
      let selectedIndexPath = tableView.indexPathForSelectedRow
      currentPizza = pizzaDataSource.pizzas[(selectedIndexPath?.row)!]
      ingredientController.pizza = pizzaDataSource.pizzas[(selectedIndexPath?.row)!]
      IngredientDataSource.pizza = currentPizza
      for i in pizzaDataSource.pizzas[(selectedIndexPath?.row)!].ingredients! {
          print(i)
      }
      
    default:
      preconditionFailure("Unexpected segue identifier.")
    }
  }
  
  func createRecordForEntity(entity: String, inManagedObjectContext managedObjectContext: NSManagedObjectContext) -> NSManagedObject? {
    // Helpers
    var result: NSManagedObject? = nil
    
    // Create Entity Description
    let entityDescription = NSEntityDescription.entity(forEntityName: entity, in: managedObjectContext)
    
    if let entityDescription = entityDescription {
      // Create Managed Object
      result = NSManagedObject(entity: entityDescription, insertInto: managedObjectContext)
    }
    
    return result
  }
  
  func fetchRecordsForEntity(entity: String, inManagedObjectContext managedObjectContext: NSManagedObjectContext) -> [NSManagedObject] {
    // Create Fetch Request
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
    
    // Helpers
    var result = [NSManagedObject]()
    
    do {
      // Execute Fetch Request
      let records = try managedObjectContext.fetch(fetchRequest)
      
      if let records = records as? [NSManagedObject] {
        result = records
      }
      
    } catch {
      print("Unable to fetch managed objects for entity \(entity).")
    }
    
    return result
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    
//    guard let appDelegate =
//      UIApplication.shared.delegate as? AppDelegate else {
//        return
//    }
    
    let managedContext = coreDataStack.managedContext
    
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Pizza")
    
    do {
      pizzas = try managedContext.fetch(fetchRequest)
    } catch let error as NSError {
      print("Could not fetch. \(error), \(error.userInfo)")
    }
    
    
  }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

//
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
  
//  func prepareForSegue (segue: UIStoryboardSegue, sender: AnyObject?) {
//    if let identifier = segue.identifier {
//      switch identifier {
//      case "Show Ingredients" :
//        if let cell = sender as? MyTableViewCell,
//          let indexPath = tableView.indexPathForCell(cell),
//          let seguedToMVC = segue.destinationViewController as? MyVC {
//
//        }
//      default: break
//      }
//    }
//  }
  
  func save(name: String) {
//    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
//      return
//    }
    
    let managedContext = coreDataStack.managedContext
    
    let entity = NSEntityDescription.entity(forEntityName: "Pizza", in: managedContext)!
    
    let pizza = NSManagedObject(entity: entity, insertInto: managedContext)
    
    pizza.setValue(name, forKeyPath: "name")
    
    do {
      try managedContext.save()
      pizzas.append(pizza)
    } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
    }
  }
  
  private func updateDataSource() {
    store.fetchAllPizzas {
      (pizzasResult) in
      switch pizzasResult {
      case let .success(pizzas):
        self.pizzaDataSource.pizzas = pizzas
      case let .failure(error):
        self.pizzaDataSource.pizzas.removeAll()
      }
      self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
      
    }
  }
  
  func updatePizzas() {
    store.fetchAllPizzas { (pizzasResult) in
      
      switch pizzasResult {
      case let .success(pizzas):
        self.pizzaDataSource.pizzas = pizzas
       case let .failure(error): print("Error fetching pizzas: \(error).")
      }
      self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
      
    }
  }

  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return pizzas.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let pizza = pizzas[indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    cell.textLabel?.text = pizza.value(forKeyPath: "name") as? String
    
    return cell
  }

  
}

