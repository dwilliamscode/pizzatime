//
//  IngredientsViewController.swift
//  PizzaTime
//
//  Created by dw on 1/23/17.
//  Copyright © 2017 WilliamsAssociates. All rights reserved.
//

import UIKit
import CoreData

var coreDataStack1 = CoreDataStack(modelName: "PizzaTimeModel")

class IngredientViewController: UITableViewController {
  
  @IBAction func done(_ sender: UIBarButtonItem) {
    presentingViewController?.dismiss(animated: true, completion: nil)
  }
  
  @IBAction func addIngredient(_ sender: UIBarButtonItem) {
    let alertController = UIAlertController(title: "Add Ingredient", message: nil, preferredStyle:.alert)
    alertController.addTextField {
      (textField)-> Void in
      textField.placeholder = "ingredient name"
      textField.autocapitalizationType = .words
    }
    
    let okAction = UIAlertAction(title: "OK", style: .default) {
      (action)-> Void in
      
      if let ingredientName = alertController.textFields?.first?.text {
        let context = self.store.persistentContainer.viewContext
        let newIngredient = NSEntityDescription.insertNewObject(forEntityName: "Ingredient", into: context) as! Ingredient
    
        newIngredient.setValue(ingredientName, forKey: "name")
        //let ingredients = self.pizza.ingredients?.mutableSetValue(forKey: "ingredients")
        print(self.pizza.name)
        
        //ingredients?.add(newIngredient)
        newIngredient.pizza = self.pizza
        
        
//        let newIngredient = NSEntityDescription.insertNewObject(forEntityName: "Ingredient", into: context)
//        let someIngredient = Ingredient()
//        someIngredient.name = ingredientName
//        self.pizza.addToIngredients(someIngredient)
//        newIngredient.setValue(ingredientName, forKey: "name")

        
        do {
          try self.store.persistentContainer.viewContext.save()
          self.tableView.reloadData()
        } catch let error {
          print("Core Data save failed: \(error)")
        }
        self.updateIngredients()
      }
    }
    alertController.addAction(okAction)
    
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    alertController.addAction(cancelAction)
    
    present(alertController, animated: true, completion: nil)
  }
  
  
  var store: PizzaStore!
  var pizza: Pizza!
  
  var selectedIndexPaths = [IndexPath]()
  
  let ingredientDataSource = IngredientDataSource()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.dataSource = ingredientDataSource
    tableView.delegate = self
    
    print("Pizza name is \(pizza.name)")
    print("Made it here with no pizza")
    
    updateIngredients()
    
    self.updateDataSource()
    
    tableView.reloadData()
  }
  
  private func updateDataSource() {
    store.fetchAllIngredients {
      (ingredientsResult) in
      switch ingredientsResult {
      case let .success(ingredients):
        self.ingredientDataSource.ingredients = ingredients
      case let .failure(error):
        self.ingredientDataSource.ingredients.removeAll()
      }
      self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
      
    }
  }
  
  func updateIngredients() {
    store.fetchAllIngredients { (ingredientsResult) in
      
      switch ingredientsResult {
      case let .success(ingredients):
          self.ingredientDataSource.ingredients = ingredients
          guard let pizzaIngredients = self.pizza.ingredients as? Set<Ingredient> else
          {
            return
          }
          for ingredient in pizzaIngredients {
            if let index = self.ingredientDataSource.ingredients.index(of: ingredient) {
              let indexPath = IndexPath(row: index, section: 0)
              self.selectedIndexPaths.append(indexPath)
            }
          }
      case let .failure(error): print("Error fetching ingredients: \(error).")
      }
      
      self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
      
    }
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    let ingredient = ingredientDataSource.ingredients[indexPath.row]
    
    if let index = selectedIndexPaths.index(of: indexPath) {
      selectedIndexPaths.remove(at: index)
      pizza.removeFromIngredients(ingredient)
    } else {
      selectedIndexPaths.append(indexPath)
      pizza.addToIngredients(ingredient)
    }
    
    do {
      try store.persistentContainer.viewContext.save()
    } catch {
      print("Core Data save failed:  \(error).")
    }
    
    tableView.reloadRows(at: [indexPath], with: .automatic)
  }
  
  override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    if selectedIndexPaths.index(of: indexPath) != nil {
      cell.accessoryType = .checkmark
    } else {
      cell.accessoryType = .none
    }
  }
  
  
//  var currentPizza: Pizza?
//  var ingredients: [NSManagedObject] = []
//  
//    override func viewDidLoad() {
//      super.viewDidLoad()
//      
//      let pizzaName = "Pizza2"
//      let pizzaFetch: NSFetchRequest<Pizza> = Pizza.fetchRequest()
//      pizzaFetch.predicate = NSPredicate(format: "%K == %@", #keyPath(Pizza.name), pizzaName)
//      
//      do {
//        let results = try coreDataStack1.managedContext.fetch(pizzaFetch)
//        if results.count > 0 {
//          // Pizza found, use Pizza
//          currentPizza = results.first
//        } else {
//          // Pizza not found, create Pizza
//          currentPizza = Pizza(context: coreDataStack1.managedContext)
//          currentPizza?.name = pizzaName
//          try coreDataStack1.managedContext.save()
//        }
//      } catch let error as NSError {
//        print("Fetch error: \(error) description: \(error.userInfo)")
//      }
//
//        // Do any additional setup after loading the view.
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
  
//  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    guard let ingredients = currentPizza?.ingredients else {
//      return 1
//    }
//    return ingredients.count
//  }
//  
//  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    
//    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//    
//    guard let ingredient = currentPizza?.ingredients?[indexPath.row] as? Ingredient,
//      let ingredientName = ingredient.name else {
//        return cell
//    }
//    
//    cell.textLabel?.text = ingredientName
//    
//    return cell
//  }

}
