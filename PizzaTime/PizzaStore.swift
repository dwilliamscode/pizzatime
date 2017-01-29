//
//  PizzaStore.swift
//  PizzaTime
//
//  Created by dw on 1/26/17.
//  Copyright © 2017 WilliamsAssociates. All rights reserved.
//

import UIKit
import CoreData

enum PizzasResult {
  case success([Pizza])
  case failure(Error)
}

enum IngredientsResult {
  case success([Ingredient])
  case failure(Error)
}

class PizzaStore {
  
  let persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "PizzaTimeModel")
    container.loadPersistentStores {(description, error) in
      if let error = error {
        print("Error setting up Core Data (\(error)).")
      }
    }
    return container
  }()
  
  func fetchAllPizzas(completion: @escaping (PizzasResult)-> Void) {
    let fetchRequest: NSFetchRequest<Pizza> = Pizza.fetchRequest()
    let sortByName = NSSortDescriptor(key: #keyPath(Pizza.name), ascending: true)
    fetchRequest.sortDescriptors = [sortByName]
    
    let viewContext = persistentContainer.viewContext
    viewContext.perform {
      do {
        let allPizzas = try fetchRequest.execute()
        completion(.success(allPizzas))
      } catch {
        completion(.failure(error))
      }
    }
  }
  
  func fetchIngredientsForPizza(completion: @escaping (IngredientsResult)-> Void) {
    let fetchRequest: NSFetchRequest<Ingredient> = Ingredient.fetchRequest()
    //let predicate: NSPredicate = NSPredicate(format: "(ingredient.name > pizza.name) AND (firstName = %@)", "Quentin")
    let sortByName = NSSortDescriptor(key: #keyPath(Ingredient.name), ascending: true)
    fetchRequest.sortDescriptors = [sortByName]
    
    let viewContext = persistentContainer.viewContext
    viewContext.perform {
      do {
        let allIngredients = try fetchRequest.execute()
        completion(.success(allIngredients))
      } catch {
        completion(.failure(error))
      }
    }
  }
  
  func fetchAllIngredients(completion: @escaping (IngredientsResult)-> Void) {
    let fetchRequest: NSFetchRequest<Ingredient> = Ingredient.fetchRequest()
    let sortByName = NSSortDescriptor(key: #keyPath(Ingredient.name), ascending: true)
    fetchRequest.sortDescriptors = [sortByName]
    
    let viewContext = persistentContainer.viewContext
    viewContext.perform {
      do {
        let allIngredients = try fetchRequest.execute()
        completion(.success(allIngredients))
      } catch {
        completion(.failure(error))
      }
    }
  }
  
}
