//
//  TransactionManager.swift
//  SpendBook
//
//  Created by Tomasz Jaeschke on 15.02.2018.
//  Copyright © 2018 Tomasz Jaeschke. All rights reserved.
//

import UIKit

class TransactionManager {
    
    static let instance = TransactionManager()
    
    // Private var
    private var _transactionList = [Transaction]()
    private var _date = Date()
    private var _calendar = Calendar.current
    
    
    // Private func
    private func _updateTodayDate() {
        _date = Date()
        _calendar = Calendar.current
    }
    
    // Public Func
    public func setList(_ ofTransaction:[Transaction]){
        _transactionList = ofTransaction
    }
    public func getToday(_ transactionOfIndex: Int) -> Transaction {
        var today = [Transaction]()
        _updateTodayDate()
        for row in _transactionList {
            guard row.year == Int32(_calendar.component(.year, from: _date)) else {continue}
            guard row.month == Int32(_calendar.component(.month, from: _date)) else {continue}
            guard row.day == Int32(_calendar.component(.day, from: _date)) else {continue}
            today.append(row)
        }
        return today[transactionOfIndex]
    }
    public func getAll(_ trancsationOfIndex: Int) -> Transaction {
        return _transactionList[trancsationOfIndex]
    }
    public func getMonthlyValue() -> Int {
        var valueOfTransaction: Int32 = 0
        for row in _transactionList {
            guard row.year == Int32(_calendar.component(.year, from: _date)) else {continue}
            guard row.month == Int32(_calendar.component(.month, from: _date)) else {continue}
            if row.sign == "+" {
                valueOfTransaction += row.value
            } else if row.sign == "-" {
                valueOfTransaction -= row.value
            }
        }
        return Int(valueOfTransaction)
    }
    public func getTodayValue() -> Int{
        var valueOfTransaction: Int32 = 0
        for row in _transactionList {
            guard row.year == Int32(_calendar.component(.year, from: _date)) else {continue}
            guard row.month == Int32(_calendar.component(.month, from: _date)) else {continue}
            guard row.day == Int32(_calendar.component(.day, from: _date)) else {continue}
            if row.sign == "+" {
                valueOfTransaction += row.value
            } else if row.sign == "-" {
                valueOfTransaction -= row.value
            }
        }
        return Int(valueOfTransaction)
    }
    public func countToday() -> Int {
        var amount: Int = 0
        
        _updateTodayDate()
        
        for row in _transactionList {
            guard row.year == Int32(_calendar.component(.year, from: _date)) else {continue}
            guard row.month == Int32(_calendar.component(.month, from: _date)) else {continue}
            guard row.day == Int32(_calendar.component(.day, from: _date)) else {continue}
            amount += 1
        }
        return amount
    }
    public func countAll() -> Int {
        return _transactionList.count
    }
    
    // Static func
    static func todayDate(_ forTransaction: Transaction){
        let date = Date()
        let calendar = Calendar.current
        let formatter = DateFormatter()
        
        forTransaction.day = Int16(calendar.component(.day, from: date))
        forTransaction.month = Int16(calendar.component(.month, from: date))
        forTransaction.year = Int16(calendar.component(.year, from: date))
        forTransaction.hour = Int16(calendar.component(.hour, from: date))
        forTransaction.minute = Int16(calendar.component(.minute, from: date))
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        forTransaction.date = formatter.string(from: date)
        
    }
    
}
