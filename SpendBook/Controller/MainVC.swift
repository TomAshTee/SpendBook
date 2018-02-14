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
import CoreData
import Hero

class MainVC: UIViewController, HeroViewControllerDelegate {

    // Outlets
    
    @IBOutlet weak var historyTableView: UITableView!
    @IBOutlet weak var summaryLbl: UILabel!
    @IBOutlet weak var todayLbl: UILabel!
    @IBOutlet weak var mountLbl: UILabel!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var withdrawBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        historyTableView.delegate = self
        historyTableView.dataSource = self
        historyTableView.isHidden = false
    
    }
    override func viewWillAppear(_ animated: Bool) {
        historyTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? AddTransactionVC, let sender = sender as? UIButton {
            viewController.setTransactionBtn.backgroundColor = sender.backgroundColor
            viewController.colorForTransaction = sender.backgroundColor!
            
            if sender.currentImage == #imageLiteral(resourceName: "Icon-plus"){
                viewController.textForDolarLbl = "$"
            } else if sender.currentImage == #imageLiteral(resourceName: "Icon-minus") {
                viewController.textForDolarLbl = "$-"
            }
        }
    }
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return IconManager.instance.countIcon()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = historyTableView.dequeueReusableCell(withIdentifier: "todayHistoryCell") as? TodayHistoryCell else {
            return UITableViewCell()
        }
        cell.configureCell(type: IconManager.instance.getIconList()[indexPath.row], transactionValue: 69)
        return cell
    }
    
}










