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
        
        savingsTableView.dataSource = self
        savingsTableView.delegate = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        updateView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? AccountVC {
            viewController.delegate = self
        }
    }
}

//MARK: - CoreData extension

extension SavingsVC{
    
    func removeSaving(atIndexPath indexPath: IndexPath){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        managedContext.delete(SavingsManager.instance.getAllSavings()[indexPath.row])
        do {
            try managedContext.save()
        } catch {
            debugPrint("Colud not remove: \(error.localizedDescription)")
        }
    }
    
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

//MARK: - TableView Delegate & DataSource extension

extension SavingsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SavingsManager.instance.countAccount()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = savingsTableView.dequeueReusableCell(withIdentifier: "savingsCell") as? SavingsCell else {
            return UITableViewCell()
        }
        let savingForCell = SavingsManager.instance.getAllSavings()[indexPath.row]
        cell.configureCell(savingForCell)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "DELETE") { (rowAction, view, boolValue) in
            // Do this when press button DELETE
            let alertControler = UIAlertController(title: "Delete", message: "Do you really want to delete account \"\(SavingsManager.instance.getAllSavings()[indexPath.row].name!)\" ?", preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "Yes", style: .destructive, handler: { (alert) in

                self.removeSaving(atIndexPath: indexPath)
                SavingsManager.instance.fetchFromCoreData(completion: { (complete) in
                })
                tableView.deleteRows(at: [indexPath], with: .automatic)
            })
            let cancelAction = UIAlertAction(title: "No", style: .cancel, handler: { (UIAlertAction) in

            })
            alertControler.addAction(confirmAction)
            alertControler.addAction(cancelAction)
            self.present(alertControler, animated: false, completion: nil)
        }
        let swipeAction = UISwipeActionsConfiguration(actions: [deleteAction])
        return swipeAction
    }
}

//MARK: - Function extension

extension SavingsVC {
    func updateLabelInfo(){
        let savingSummary = SavingsManager.instance.getSummaryOfSavings()
        if savingSummary >= 0 {
            savingsLbl.textColor = #colorLiteral(red: 0.2664798796, green: 0.8519781232, blue: 0.8082112074, alpha: 1)
        } else {
            savingsLbl.textColor = #colorLiteral(red: 0.9647058824, green: 0.4666666667, blue: 0.6901960784, alpha: 1)
        }
        savingsLbl.text = "$" + String(savingSummary)
    }
}

//MARK: - UpdateView Protocol extension

extension SavingsVC: UpdateViewProtocol {
    func updateView() {
        self.fetchCoreDataObjects()
        savingsTableView.reloadData()
        updateLabelInfo()
    }
}
