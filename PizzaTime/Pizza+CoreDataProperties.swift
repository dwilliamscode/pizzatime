//
//  Pizza+CoreDataProperties.swift
//  PizzaTime
//
//  Created by dw on 1/24/17.
//  Copyright © 2017 WilliamsAssociates. All rights reserved.
//

import Foundation
import CoreData


extension Pizza {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pizza> {
        return NSFetchRequest<Pizza>(entityName: "Pizza");
    }

    @NSManaged public var isFavorite: Bool
    @NSManaged public var name: String?
    @NSManaged public var ingredients: NSOrderedSet?

}

// MARK: Generated accessors for ingredients
extension Pizza {

    @objc(insertObject:inIngredientsAtIndex:)
    @NSManaged public func insertIntoIngredients(_ value: Ingredient, at idx: Int)

    @objc(removeObjectFromIngredientsAtIndex:)
    @NSManaged public func removeFromIngredients(at idx: Int)

    @objc(insertIngredients:atIndexes:)
    @NSManaged public func insertIntoIngredients(_ values: [Ingredient], at indexes: NSIndexSet)

    @objc(removeIngredientsAtIndexes:)
    @NSManaged public func removeFromIngredients(at indexes: NSIndexSet)

    @objc(replaceObjectInIngredientsAtIndex:withObject:)
    @NSManaged public func replaceIngredients(at idx: Int, with value: Ingredient)

    @objc(replaceIngredientsAtIndexes:withIngredients:)
    @NSManaged public func replaceIngredients(at indexes: NSIndexSet, with values: [Ingredient])

    @objc(addIngredientsObject:)
    @NSManaged public func addToIngredients(_ value: Ingredient)

    @objc(removeIngredientsObject:)
    @NSManaged public func removeFromIngredients(_ value: Ingredient)

    @objc(addIngredients:)
    @NSManaged public func addToIngredients(_ values: NSOrderedSet)

    @objc(removeIngredients:)
    @NSManaged public func removeFromIngredients(_ values: NSOrderedSet)

}
