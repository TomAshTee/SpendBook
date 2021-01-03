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
    @IBOutlet weak var historyTableView: UITableView!
    @IBOutlet weak var summaryLbl: UILabel!
    @IBOutlet weak var noTransactionLbl: UILabel!
    
    // Var for Date select
    private var datePicker: UIDatePicker!
    private let _date = Date()
    private let _curentCalenar = Calendar.current
    private let _dateFormatter = DateFormatter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.historyTableView.dataSource = self
        self.historyTableView.delegate = self
        self.historyTableView.isHidden = false
        
        //Setup date select and gesture
        _dateFormatter.dateFormat = "dd-MM-yyyy"
        
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        datePicker.addTarget(self, action: #selector(HistoryVC.dateChanged(_:)), for: .valueChanged)
        
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.sizeToFit()
        
        fromTextFiled.inputView = datePicker
        toTextFiled.inputView = datePicker
        setUpTodayDate(fromTextFiled)
        setUpTodayDate(toTextFiled)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(HistoryVC.viewTaped(_:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        historyTableView.reloadData()
        self.updateSummaryLbl()
    }

}

//MARK: - TableView Delegate & DataSource extension

extension HistoryVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRows = TransactionManager.instance.getTransaction(_dateFormatter.date(from: fromTextFiled.text!)!, _dateFormatter.date(from: toTextFiled.text!)!).count
        
        if numberOfRows == 0 {
            self.historyTableView.isHidden = true
            self.noTransactionLbl.isHidden = false
        } else {
            self.historyTableView.isHidden = false
            self.noTransactionLbl.isHidden = true
        }
        
        return numberOfRows
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = historyTableView.dequeueReusableCell(withIdentifier: "historyCell") as? HistoryCell else {
            return UITableViewCell()
        }
        cell.configureCell(TransactionManager.instance.getTransaction(_dateFormatter.date(from: fromTextFiled.text!)!, _dateFormatter.date(from: toTextFiled.text!)!)[indexPath.row])
        return cell
    }
}

//MARK: - Functions extension

extension HistoryVC {
    
    func updateSummaryLbl() {
        let transactionList = TransactionManager.instance.getTransaction(_dateFormatter.date(from: fromTextFiled.text!)!, _dateFormatter.date(from: toTextFiled.text!)!)
        var summaryValue: Int32 = 0
        
        for row in transactionList {
            if row.sign == "-"{
                summaryValue -= row.value
            }
            if row.sign == "+"{
                summaryValue += row.value
            }
        }
        
        if summaryValue >= 0 {
            summaryLbl.textColor = #colorLiteral(red: 0.2664798796, green: 0.8519781232, blue: 0.8082112074, alpha: 1)
        } else {
            summaryLbl.textColor = #colorLiteral(red: 0.9647058824, green: 0.4666666667, blue: 0.6901960784, alpha: 1)
        }
        
        summaryLbl.text = "$" + String(summaryValue)
    }
    
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
        self.historyTableView.reloadData()
        self.updateSummaryLbl()
    }
    
    @objc func viewTaped(_ gestureRecognizer: UITapGestureRecognizer){
        self.historyTableView.reloadData()
        self.updateSummaryLbl()
        view.endEditing(true)
    }
    
    func setUpTodayDate(_ textField: UITextField){
        textField.text = _dateFormatter.string(from: _date)
    }
}
