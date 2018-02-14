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
    @IBOutlet weak var pickLbl: UILabel!
    @IBOutlet weak var valueTextField: UITextField!
    @IBOutlet weak var typePicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        typePicker.dataSource = self
        typePicker.delegate = self
        
        // Preselected type
        typePicker.selectRow(0, inComponent: 0, animated: true)
        pickLbl.text = iconList[typePicker.selectedRow(inComponent: 0)].rawValue
        valueTextField.placeholder = "Value of " + iconList[typePicker.selectedRow(inComponent: 0)].rawValue
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Actions
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension AddTransactionVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return iconList.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return iconList[row].rawValue
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        valueTextField.placeholder = "Value of " + iconList[row].rawValue
        pickLbl.text = iconList[row].rawValue
    }
}
