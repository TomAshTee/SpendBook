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
        self.fetch { (complete) in
            //If it's ok or not ??
        }
        historyTableView.reloadData() 
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // What kind of transaction it is ?
        if let viewController = segue.destination as? AddTransactionVC, let sender = sender as? UIButton {
            viewController.setTransactionBtn.backgroundColor = sender.backgroundColor
            viewController.colorForTransaction = sender.backgroundColor!
            if sender.restorationIdentifier == "addBtn"{
                viewController.textForDolarLbl = "$"
                viewController.signOfTransaction = "+"
            } else if sender.restorationIdentifier == "subBtn" {
                viewController.textForDolarLbl = "$-"
                viewController.signOfTransaction = "-"
            }
        }
    }
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TransactionManager.instance.count()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = historyTableView.dequeueReusableCell(withIdentifier: "todayHistoryCell") as? TodayHistoryCell else {
            return UITableViewCell()
        }
        let value = TransactionManager.instance.get((TransactionManager.instance.count() - 1) - indexPath.row)
        // Color define by sign 
        var colorOfTransaction = UIColor.black
        if value.sign == "-"{
            colorOfTransaction = #colorLiteral(red: 0.9647058824, green: 0.4666666667, blue: 0.6901960784, alpha: 1)
        } else if value.sign == "+"{
            colorOfTransaction = #colorLiteral(red: 0.2673969567, green: 0.8492315412, blue: 0.8062124848, alpha: 1)
        }
        cell.configureCell(type: value.type!, transactionValue: Int(value.value), color: colorOfTransaction)
        return cell
    }
}

// Load data from CoreData
extension MainVC {
    func fetch(completion: (_ complete: Bool) -> ()){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Transaction")
        
        do {
            try TransactionManager.instance.setList(managedContext.fetch(fetchRequest) as! [Transaction])
            print("Successfull fetched data.")
            completion(true)
        } catch {
            debugPrint("Could not fetch: \(error.localizedDescription)")
            completion(false )
        }
    }
}
















