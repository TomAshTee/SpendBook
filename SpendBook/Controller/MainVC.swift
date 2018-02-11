//
//  MainVC.swift
//  SpendBook
//
//  Created by Tomasz Jaeschke on 09.02.2018.
//  Copyright © 2018 Tomasz Jaeschke. All rights reserved.
//

import UIKit
import Charts
import ChameleonFramework

class MainVC: UIViewController {

    // Outlets
    
    @IBOutlet weak var summaryLbl: UILabel!
    @IBOutlet weak var todayLbl: UILabel!
    @IBOutlet weak var mountLbl: UILabel!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var withdrawBtn: UIButton!
    // Test data
    let categories = ["Food", "Rent", "Health", "Clothing","Travels"]
    let valueOfCategories = [340.0, 204.0, 30.0, 122.0, 263.0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
    }
    
}










