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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        typePicker.dataSource = self
        typePicker.delegate = self
        
        //Set color and Text
        valueTextField.textColor = colorForTransaction
        dolarLbl.textColor = colorForTransaction
        dolarLbl.text = textForDolarLbl
        
        // Preselected type
        typePicker.selectRow(0, inComponent: 0, animated: true)
        valueTextField.placeholder = "Value of " + IconManager.instance.getIconList()[typePicker.selectedRow(inComponent: 0)]
        
        // Set up keyboar Btn
        setTransactionBtn.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 45)
        setTransactionBtn.setTitle("Set transaction", for: .normal)
        setTransactionBtn.setTitleColor(UIColor.white, for: .normal)
        setTransactionBtn.addTarget(self, action: #selector(AddTransactionVC.setTransaction), for: .touchUpInside)
        valueTextField.inputAccessoryView = setTransactionBtn
        
    }

    @objc func setTransaction(){
        dismissView()
    }
    
    // Actions
    @IBAction func backBtnPressed(_ sender: Any) {
        dismissView()
    }
    
    func dismissView() {
        view.endEditing(true)
        dismiss(animated: true, completion: nil)
    }
}

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
