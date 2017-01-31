//
//  PizzaServiceTests.swift
//  PizzaTime
//
//  Created by dw on 1/30/17.
//  Copyright © 2017 WilliamsAssociates. All rights reserved.
//

import UIKit
//import XCTest
//import PizzaManager
import CoreData

class PizzaServiceTests: XCTestCase {
  
  // MARK: Properties
  var pizzaService: PizzaService!
  var coreDataStack: CoreDataStack!
  
  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    coreDataStack = TestCoreDataStack()
    pizzaService = PizzaService(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
    
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
    
    pizzaService = nil
    coreDataStack = nil
  }
  
  func testAddPizza() {
    let pizza = pizzaService.addPizza("Pizza10", favorite: true)
    
    XCTAssertTrue(pizza.name == "Pizza10", "Pizza name should be Pizza10")
    XCTAssertTrue(pizza.isFavorite!.boolValue, "Pizza should be favorite")
  }
  
  func testRootContextIsSavedAfterAddingPizza() {
    let derivedContext = coreDataStack.newDerivedContext()
    
    pizzaService = PizzaService(managedObjectContext: coreDataStack.derivedContext, coreDataStack: coreDataStack)
    
    expecatation(forNotification: NSNotification.Name.NSManagedObjectContextDidSave.rawValue,
                 object: coreDataStack.mainContext) {
                  notification = nil
                  return true
    }
    
    let pizza = pizzaService.addPizza("Pizza10", favorite: true)
    XCTAssertNotNil(pizza)
    
    waitForExpectations(timeout: 2.0) { error in
      XCTAssertNil(error, "Save did not occur")
    }
  }
  
  func testExample() {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
  }
  
  func testPerformanceExample() {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }
  
}
