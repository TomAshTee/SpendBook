//
//  MainVC.swift
//  SpendBook
//
//  Created by Tomasz Jaeschke on 09.02.2018.
//  Copyright © 2018 Tomasz Jaeschke. All rights reserved.
//

import UIKit
import CoreData

protocol UpdateViewProtocol {
    func updateView()
}

class MainVC: UIViewController{

    // Outlets
    @IBOutlet weak var historyTableView: UITableView!
    @IBOutlet weak var summaryLbl: UILabel!
    @IBOutlet weak var todayLbl: UILabel!
    @IBOutlet weak var mountLbl: UILabel!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var withdrawBtn: UIButton!
    @IBOutlet weak var noTransactionLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        historyTableView.delegate = self
        historyTableView.dataSource = self
        historyTableView.isHidden = false
    
    }
    override func viewWillAppear(_ animated: Bool) {
        fetchCoreDataObjects()
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
            viewController.delegate = self
        }
    }
}

//MARK: - TableView Delegate & DataSource extension

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TransactionManager.instance.countToday()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = historyTableView.dequeueReusableCell(withIdentifier: "todayHistoryCell") as? TodayHistoryCell else {
            return UITableViewCell()
        }
        let transaction = TransactionManager.instance.getToday((TransactionManager.instance.countToday() - 1) - indexPath.row)
        cell.configureCell(transaction: transaction)
        return cell
    }
    
    // Enable remove transaction from a tableView
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "DELETE") { (rowAction, view, boolValue) in
            // Do this when press button DELETE
        
            self.removeTransaction(atIndexPath: indexPath)
            self.fetchCoreDataObjects()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        let swipeAction = UISwipeActionsConfiguration(actions: [deleteAction])
        return swipeAction
    }
}

//MARK: - CoreData extension

extension MainVC {
    
    //  Reakcja UI na pobrane dane z CoreData
    func fetchCoreDataObjects () {
        self.fetch { (complete) in
            if complete {
                if TransactionManager.instance.countToday() > 0{
                    historyTableView.isHidden = false
                    noTransactionLbl.isHidden = true
                } else {
                    historyTableView.isHidden = true
                    noTransactionLbl.isHidden = false
                }
                upDateLblInfo()
                //Debug
                print("All transaction count: \(TransactionManager.instance.countAll())")
                print("Today transaction count: \(TransactionManager.instance.countToday())")
            }
        }
    }
    
    // Remove data form CoreData
    func removeTransaction(atIndexPath indexPath: IndexPath){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        // Transaction list is reverse by the way it's display
        managedContext.delete(TransactionManager.instance.getToday((TransactionManager.instance.countToday() - 1) - indexPath.row))
        
        do {
            try managedContext.save()
            print("Successfull remove transaction")
        } catch {
            debugPrint("Could not remove: \(error.localizedDescription)")
        }
    }
    
    // Load data from CoreData
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

//MARK: - Function

extension MainVC {
    func upDateLblInfo() {
        let monthly = TransactionManager.instance.getMonthlyValue()
        let today = TransactionManager.instance.getTodayValue()
        let summary = TransactionManager.instance.getSummaryValue()
        
        if today >= 0 {
            todayLbl.textColor = #colorLiteral(red: 0.2664798796, green: 0.8519781232, blue: 0.8082112074, alpha: 1)
        } else {
            todayLbl.textColor = #colorLiteral(red: 0.9647058824, green: 0.4666666667, blue: 0.6901960784, alpha: 1)
        }
        todayLbl.text = "$" + String(today)
        
        if monthly >= 0 {
            mountLbl.textColor = #colorLiteral(red: 0.2664798796, green: 0.8519781232, blue: 0.8082112074, alpha: 1)
        } else {
            mountLbl.textColor = #colorLiteral(red: 0.9647058824, green: 0.4666666667, blue: 0.6901960784, alpha: 1)
        }
        mountLbl.text = "$" + String(monthly)
        
        if summary >= 0 {
            summaryLbl.textColor = #colorLiteral(red: 0.2664798796, green: 0.8519781232, blue: 0.8082112074, alpha: 1)
        } else {
            summaryLbl.textColor = #colorLiteral(red: 0.9752412438, green: 0.447863102, blue: 0.6472212672, alpha: 1)
        }
        summaryLbl.text = "$" + String(summary)
    }
}

//MARK: - AupdateView Protocol Extension

extension MainVC: UpdateViewProtocol {
    func updateView() {
        fetchCoreDataObjects()
        historyTableView.reloadData()
    }
}














