//
//  HistoryVC.swift
//  SpendBook
//
//  Created by Tomasz Jaeschke on 11.02.2018.
//  Copyright © 2018 Tomasz Jaeschke. All rights reserved.
//

import UIKit

class HistoryVC: UIViewController {

    @IBOutlet weak var inputTextFiled: UITextField!
    
    private var datePicker: UIDatePicker!
    private let _date = Date()
    private let _curentCalenar = Calendar.current
    private let _dateFormatter = DateFormatter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _dateFormatter.dateFormat = "dd-MM-yyyy"
        
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        datePicker.addTarget(self, action: #selector(HistoryVC.dateChanged(_:)), for: .valueChanged)
        
        inputTextFiled.inputView = datePicker
        setUpTodayDate(inputTextFiled)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(HistoryVC.viewTaped(_:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dateChanged(_ datePicker: UIDatePicker){
        
        inputTextFiled.text = _dateFormatter.string(from: datePicker.date)
    }
    
    @objc func viewTaped(_ gestureRecognizer: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    func setUpTodayDate(_ textField: UITextField){
        textField.text = _dateFormatter.string(from: _date)
    }

}
