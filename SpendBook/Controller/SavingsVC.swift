//
//  SavingsVC.swift
//  SpendBook
//
//  Created by Tomasz Jaeschke on 11.02.2018.
//  Copyright © 2018 Tomasz Jaeschke. All rights reserved.
//

import UIKit
import CoreData

class SavingsVC: UIViewController {

    @IBOutlet weak var manageBtn: RoundedGradientButton!
    @IBOutlet weak var savingsLbl: UILabel!
    @IBOutlet weak var savingsTableView: UITableView!
    @IBOutlet weak var noAccountsLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.fetchCoreDataObjects()
    }
    
}

extension SavingsVC{
    
    func fetchCoreDataObjects () {
        SavingsManager.instance.fetchFromCoreData { (complete) in
            if complete {
                if SavingsManager.instance.countAccount() > 0{
                    savingsTableView.isHidden = false
                    noAccountsLbl.isHidden = true
                } else {
                    savingsTableView.isHidden = true
                    noAccountsLbl.isHidden = false
                }
                //upDateLblInfo()
                //Debug
                print("All savings count: \(SavingsManager.instance.countAccount())")
            }
        }
    }
}
