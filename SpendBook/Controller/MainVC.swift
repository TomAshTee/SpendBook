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
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return iconList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = historyTableView.dequeueReusableCell(withIdentifier: "todayHistoryCell") as? TodayHistoryCell else {
            return UITableViewCell()
        }
        cell.configureCell(type: iconList[indexPath.row], transactionValue: 69)
        return cell
    }
    
}










