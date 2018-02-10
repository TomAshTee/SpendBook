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
    
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var withdrawBtn: UIButton!
    // Test data
    let categories = ["Food", "Rent", "Health", "Clothing","Travels"]
    let valueOfCategories = [340.0, 204.0, 30.0, 122.0, 263.0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        addBtn.layer.cornerRadius = addBtn.frame.size.height / 2
        addBtn.layer.masksToBounds = true
        addBtn.setGradientBackground(colorOne: #colorLiteral(red: 0.09411764706, green: 0.4412631798, blue: 0.9411764706, alpha: 1), colorTwo: #colorLiteral(red: 0.4274509804, green: 0.9210339206, blue: 0.9529411765, alpha: 1))
        
        withdrawBtn.layer.cornerRadius = addBtn.frame.size.height / 2
        withdrawBtn.layer.masksToBounds = true
        withdrawBtn.setGradientBackground(colorOne: #colorLiteral(red: 0.9450980392, green: 0.2372768683, blue: 0.7148683176, alpha: 1), colorTwo: #colorLiteral(red: 1, green: 0.6078431373, blue: 0.7843137255, alpha: 1))
        */

        // Do any additional setup after loading the view.
    }
    
}










