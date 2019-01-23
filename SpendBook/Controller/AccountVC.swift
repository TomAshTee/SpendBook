//
//  AccountVC.swift
//  SpendBook
//
//  Created by Tomasz Jaeschke on 11.02.2018.
//  Copyright © 2018 Tomasz Jaeschke. All rights reserved.
//

import UIKit

class AccountVC: UIViewController {

    @IBOutlet weak var subtractionBtn: RoundedGradientButton!
    @IBOutlet weak var addBtn: RoundedGradientButton!
    @IBOutlet weak var accountPicker: UIPickerView!
    @IBOutlet weak var acountTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        accountPicker.dataSource = self
        accountPicker.delegate = self

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

}

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
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        <#code#>
//    }
    
}
