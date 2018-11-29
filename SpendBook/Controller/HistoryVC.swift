//
//  HistoryVC.swift
//  SpendBook
//
//  Created by Tomasz Jaeschke on 11.02.2018.
//  Copyright © 2018 Tomasz Jaeschke. All rights reserved.
//

import UIKit

class HistoryVC: UIViewController {

    @IBOutlet weak var fromTextFiled: UITextField!
    @IBOutlet weak var toTextFiled: UITextField!
    
    // Var for Date select
    private var datePicker: UIDatePicker!
    private let _date = Date()
    private let _curentCalenar = Calendar.current
    private let _dateFormatter = DateFormatter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setup date select and gesture
        _dateFormatter.dateFormat = "dd-MM-yyyy"
        
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        datePicker.addTarget(self, action: #selector(HistoryVC.dateChanged(_:)), for: .valueChanged)
        
        fromTextFiled.inputView = datePicker
        toTextFiled.inputView = datePicker
        setUpTodayDate(fromTextFiled)
        setUpTodayDate(toTextFiled)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(HistoryVC.viewTaped(_:)))
        view.addGestureRecognizer(tapGesture)
    }

}

extension HistoryVC {
    
    
    @objc func dateChanged(_ datePicker: UIDatePicker){
    
        
        if fromTextFiled.isEditing {
            fromTextFiled.text = _dateFormatter.string(from: datePicker.date)
        }
        if toTextFiled.isEditing {
            toTextFiled.text = _dateFormatter.string(from: datePicker.date)
        }
        
        // Check is there any value
        guard let dateFromTF = fromTextFiled.text else {
            print("Date in fromTextField is nil")
            return
        }
        guard let dateToTF = toTextFiled.text else {
            print("Date in toTextFiled is nil")
            return
        }
        
        // If date "to" is smaller then "from"
        guard _dateFormatter.date(from: dateToTF)! >= _dateFormatter.date(from: dateFromTF)! else {
            let alert = UIAlertController(title: "Hint", message: "\"To\" date cannot be smaller then \"From\"", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            datePicker.setDate(_dateFormatter.date(from: dateFromTF)!, animated: true)
            toTextFiled.text = fromTextFiled.text
            
            return
        }
        
        guard let listOfTransaction: [Transaction] = TransactionManager.instance.getTransaction(_dateFormatter.date(from: dateFromTF)!, _dateFormatter.date(from: dateToTF)!) else {
            print("Some error in TransactionManager...getTransaction.")
            return
        }
        
        print("List of transaction in period of time: \(listOfTransaction.count)")
    }
    
    @objc func viewTaped(_ gestureRecognizer: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    func setUpTodayDate(_ textField: UITextField){
        textField.text = _dateFormatter.string(from: _date)
    }
}
