//
//  AddTransactionVC.swift
//  SpendBook
//
//  Created by Tomasz Jaeschke on 14.02.2018.
//  Copyright © 2018 Tomasz Jaeschke. All rights reserved.
//

import UIKit

class AddTransactionVC: UIViewController{

    // Outlets
    @IBOutlet weak var valueTextField: UITextField!
    @IBOutlet weak var typePicker: UIPickerView!
    @IBOutlet weak var dolarLbl: UILabel!
    
    var setTransactionBtn = UIButton()
    var textForDolarLbl = String()
    var colorForTransaction = UIColor()
    var signOfTransaction = String()
    var delegate: AddTransactionProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        typePicker.dataSource = self
        typePicker.delegate = self
        
        updateView()
        
        // Set up keyboard Btn
        setTransactionBtn.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 45)
        setTransactionBtn.setTitle("Set transaction", for: .normal)
        setTransactionBtn.setTitleColor(UIColor.white, for: .normal)
        setTransactionBtn.addTarget(self, action: #selector(AddTransactionVC.setTransaction), for: .touchUpInside)
        valueTextField.inputAccessoryView = setTransactionBtn
        
    }
    
    // Actions
    @IBAction func backBtnPressed(_ sender: Any) {
        dismissView()
    }
}

//MARK: - Functions extension

extension AddTransactionVC {
    @objc func setTransaction(){
        
        if valueTextField.text != "" {
            self.save(completion: { (complete) in
                if complete {
                    dismissView()
                }
            })
        }
    }
    
    func updateView() {
        //Set color and Text
        valueTextField.textColor = colorForTransaction
        dolarLbl.textColor = colorForTransaction
        dolarLbl.text = textForDolarLbl
        // Preselected type
        typePicker.selectRow(0, inComponent: 0, animated: true)
        valueTextField.placeholder = "Value of " + IconManager.instance.getIconList()[typePicker.selectedRow(inComponent: 0)]
    }
    
    func dismissView() {
        view.endEditing(true)
        dismiss(animated: true, completion: nil)
        delegate?.addTransaction()
    }
}

//MARK: - PickerView Delegate & DataSource extension

extension AddTransactionVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return IconManager.instance.countIcon()
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return IconManager.instance.getIconList()[row]
    }
 
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        valueTextField.placeholder = "Value of " + IconManager.instance.getIconList()[row]
    }
}

//MARK: - CoreData extension

extension AddTransactionVC {
    func save(completion: (_ finished: Bool)->()){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        var value: Int32 = 0
        
        //Remove ',' from textFiled. Detect 0 and 00 000 etc.
        if let index = valueTextField.text?.range(of: ",")?.lowerBound {
            if let string  = valueTextField.text?.prefix(upTo: index){
                value = Int32(string)!
            }
        } else {
            value = Int32((valueTextField.text)!)!
        }
        guard value != 0 else{
            let alert = UIAlertController(title: "Hint", message: "The transaction value can not be 0.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            return
        }
        
        let transaction = Transaction(context: managedContext)
        
        // Feel Entity
        transaction.type = IconManager.instance.getIconList()[typePicker.selectedRow(inComponent: 0)]
        transaction.value = value
        transaction.sign = signOfTransaction
        
        TransactionManager.todayDate(transaction)
        
        // Save
        do {
            try managedContext.save()
            completion(true)
        } catch {
            debugPrint("Could not save: \(error.localizedDescription)")
            completion(false)
        }
    }
}
