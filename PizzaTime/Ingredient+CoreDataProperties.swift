//
//  Ingredient+CoreDataProperties.swift
//  PizzaTime
//
//  Created by dw on 1/24/17.
//  Copyright © 2017 WilliamsAssociates. All rights reserved.
//

import Foundation
import CoreData


extension Ingredient {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ingredient> {
        return NSFetchRequest<Ingredient>(entityName: "Ingredient");
    }

    @NSManaged public var name: String?
    @NSManaged public var pizza: Pizza?

}
