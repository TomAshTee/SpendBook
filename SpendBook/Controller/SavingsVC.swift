//
//  SavingsVC.swift
//  SpendBook
//
//  Created by Tomasz Jaeschke on 11.02.2018.
//  Copyright © 2018 Tomasz Jaeschke. All rights reserved.
//

import UIKit

class SavingsVC: UIViewController {

    @IBOutlet weak var manageBtn: RoundedGradientButton!
    @IBOutlet weak var savingsLbl: UILabel!
    @IBOutlet weak var savingsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //gradientBtnSetup()
    }
}

extension SavingsVC{
    private func gradientBtnSetup() {
        //manageBtn.setGradientBackground(colorOne: #colorLiteral(red: 0.3182222843, green: 0.9124733806, blue: 0.8605867624, alpha: 1), colorTwo: #colorLiteral(red: 0.9648357034, green: 0.4654114842, blue: 0.6891641021, alpha: 1))
        //manageBtn.co
    }
}
