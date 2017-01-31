//
//  IngredientStore.swift
//  PizzaTime
//
//  Created by dw on 1/26/17.
//  Copyright © 2017 WilliamsAssociates. All rights reserved.
//

import Foundation
import CoreData

class IngredientStore {
  
  let persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "PizzaTimeModel")
    container.loadPersistentStores {(description, error) in
      if let error = error {
        print("Error setting up Core Data (\(error)).")
      }
    }
    return container
  }()
  
}
