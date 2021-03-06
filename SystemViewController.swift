//
//  SystemViewController.swift
//  PizzaTime
//
//  Created by dw on 1/23/17.
//  Copyright © 2017 WilliamsAssociates. All rights reserved.
//

import UIKit

class SystemViewController: UIViewController {
  
  
  @IBOutlet weak var topListingTextbox: UITextField!
  @IBOutlet weak var topListingStepper: UIStepper!
  
  @IBAction func changeValue(_ sender: UIStepper) {
    
    topListingTextbox.text = String("\(Int(topListingStepper.value))")
    UserDefaults.standard.set(Int(topListingStepper.value), forKey: "TopOrderListCount")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    topListingTextbox.text = String(UserDefaults.standard.integer(forKey: "TopOrderListCount"))
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    UserDefaults.standard.set(Int(topListingStepper.value), forKey: "TopOrderListCount")
  }
  
}
