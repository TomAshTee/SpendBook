//
//  AccountVC.swift
//  SpendBook
//
//  Created by Tomasz Jaeschke on 11.02.2018.
//  Copyright © 2018 Tomasz Jaeschke. All rights reserved.
//

import UIKit

class AccountVC: UIViewController {

    @IBOutlet weak var accountPicker: UIPickerView!
    @IBOutlet weak var acountTableView: UITableView!
    @IBOutlet weak var balanceLbl: UILabel!
    
    var currentAccountSelect = Saving()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        accountPicker.dataSource = self
        accountPicker.delegate = self
        
        //accountPicker.selectRow(0, inComponent: 0, animated: true)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func backBtnWasPressed(_ sender: Any) {
        view.endEditing(true)
        dismiss(animated: true, completion: nil)
    }
    @IBAction func addAcctWasPressed(_ sender: Any) {
        let alertControler = UIAlertController(title: "Add new Account", message: "Please enter account name below", preferredStyle: .alert)
        alertControler.addTextField { (textField: UITextField!) in
            textField.placeholder = "Account name"
        }
        let saveAction = UIAlertAction(title: "Save", style: .default) { (alert) in
            let accountNameTextField = alertControler.textFields![0] as UITextField
            guard let accountName = accountNameTextField.text else { return }
            
            self.saveNewAccount(completion: { (complete) in
                if complete {
                    print("Successfull save new account")
                } else {
                    print ("Can not save new account")
                }
            }, accountName)
            
            SavingsManager.instance.fetchFromCoreData(completion: { (complete) in
                if complete {
                    self.accountPicker.reloadAllComponents()
                } else {
                    print("Can not fetch Savings")
                }
            })
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil )
        
        alertControler.addAction(saveAction)
        alertControler.addAction(cancelAction)
        
        self.present(alertControler, animated: true, completion: nil)
        
    }
    @IBAction func finishBtnWasPressed(_ sender: Any) {
    }

    @IBAction func addBtnWasPressed(_ sender: Any) {
        operationOnSavings(.Add)
    }
    @IBAction func subBtnWasPressed(_ sender: Any) {
        operationOnSavings(.Substract)
    }
}

//MARK: - CoreData extension

extension AccountVC {
    func saveNewAccount(completion: (_ finished: Bool)->() , _ name: String){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let saving = Saving(context: managedContext)
        
        
        saving.name = name
        saving.operations?.append(name)
        saving.value = 0
        SavingsManager.instance.todayDate(saving)
        
        do {
            try managedContext.save()
            completion(true)
        } catch {
            debugPrint("Colud not save: \(error.localizedDescription)")
            completion(false)
        }
        
    }
    
}

//MARK: - PickerView Delegate & DataSource extension

extension AccountVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return SavingsManager.instance.countAccount()
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return SavingsManager.instance.getAccountNameList()[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //Checking is there already any savings account
        guard SavingsManager.instance.isThereAnySavings() else {
            print("_savings.count = \(SavingsManager.instance.getAllSavings().count)")
            return
        }
        currentAccountSelect = SavingsManager.instance.getAccount(atRow: row)
        updateLabelInfo()
    }
}

//MARK: - Functions extension

extension AccountVC {
    func operationOnSavings(_ action: Operation) {

        let alert = UIAlertController(title: "Operation", message: "Enter the value of the operation", preferredStyle: .alert)
        alert.addTextField { (textField: UITextField!) in
            textField.placeholder = "Operation value"
            textField.keyboardType = .numberPad
        }
        
        var operationText: String = ""
        
        switch action {
        case .Add:
            operationText = "Add"
        case .Substract:
            operationText = "Substract"
        }
        let operationAction = UIAlertAction(title: operationText, style: .default) { (action) in
            print("Save Operation, value: \(alert.textFields![0].text!) ")
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(operationAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func updateLabelInfo() {
        
        if currentAccountSelect.value >= 0 {
            balanceLbl.textColor = #colorLiteral(red: 0.2664798796, green: 0.8519781232, blue: 0.8082112074, alpha: 1)
        } else {
            balanceLbl.textColor = #colorLiteral(red: 0.9647058824, green: 0.4666666667, blue: 0.6901960784, alpha: 1)
        }
        balanceLbl.text = "$" + String(currentAccountSelect.value)
        
        //For Debug
        print("Curent account: \(currentAccountSelect.name!)")
    }
}
