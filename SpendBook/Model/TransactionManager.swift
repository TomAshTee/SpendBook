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
    private func _isYoungerOrTheSame(_ comparisonResult: ComparisonResult) -> Bool {
        guard ComparisonResult.orderedDescending == comparisonResult || ComparisonResult.orderedSame == comparisonResult else {return false}
        return true
    }
    private func _isOlderOrTheSame(_ comparisonResult: ComparisonResult) -> Bool {
        guard ComparisonResult.orderedAscending == comparisonResult || ComparisonResult.orderedSame == comparisonResult else {return false}
        return true
    }
    
    // Public Func - przekazujemy wszystkie transakcje z CoreData
    public func setList(_ ofTransaction:[Transaction]){
        _transactionList = ofTransaction
    }
    
    //Pobranie transakcji z danego zakresu czasu
    public func getTransaction(_ fromDate: Date, _ toDate: Date) -> [Transaction] {
        var transactionFromDate = [Transaction]()
        let formater = DateFormatter()
        formater.dateFormat = "yyyy-MM-dd HH:mm"
        
        for transaction in _transactionList {
            guard let transactionDate = formater.date(from: transaction.date!) else {continue}
            
            var comparisonResult = _calendar.compare(transactionDate, to: fromDate, toGranularity: .year)
            guard _isYoungerOrTheSame(comparisonResult) else {continue}
            comparisonResult = _calendar.compare(transactionDate, to: fromDate, toGranularity: .month)
            guard _isYoungerOrTheSame(comparisonResult) else {continue}
            comparisonResult = _calendar.compare(transactionDate, to: fromDate, toGranularity: .day)
            guard _isYoungerOrTheSame(comparisonResult) else {continue}
            
            comparisonResult = _calendar.compare(transactionDate, to: toDate, toGranularity: .year)
            guard _isOlderOrTheSame(comparisonResult) else {continue}
            comparisonResult = _calendar.compare(transactionDate, to: toDate, toGranularity: .month)
            guard _isOlderOrTheSame(comparisonResult) else {continue}
            comparisonResult = _calendar.compare(transactionDate, to: toDate, toGranularity: .day)
            guard _isOlderOrTheSame(comparisonResult) else {continue}
            
            transactionFromDate.append(transaction)
        }
        
        return transactionFromDate
    }
    
    // Pokazanie konkretnej tranzakcji z danego dnia
    public func getToday(_ transactionOfIndex: Int) -> Transaction {
        var today = [Transaction]()
        _updateTodayDate()
        for transaction in _transactionList {
            guard transaction.year == Int32(_calendar.component(.year, from: _date)) else {continue}
            guard transaction.month == Int32(_calendar.component(.month, from: _date)) else {continue}
            guard transaction.day == Int32(_calendar.component(.day, from: _date)) else {continue}
            today.append(transaction)
        }
        return today[transactionOfIndex]
    }
    
    // Pobranie jednej transakcjie ze wszytkich dni
    public func getFromAll(_ trancsationOfIndex: Int) -> Transaction {
        return _transactionList[trancsationOfIndex]
    }
    
    //Wartość transakcji ze wszystkich dni
    public func getSummaryValue() -> Int {
        var valueOfTransaction: Int32 = 0
        for transaction in _transactionList {
            if transaction.sign == "+" {
                valueOfTransaction += transaction.value
            }
            if transaction.sign == "-" {
                valueOfTransaction -= transaction.value
            }
        }
        return Int(valueOfTransaction)
    }
    
    // Wartość tranzakcji z aktualnego miesiąca
    public func getMonthlyValue() -> Int {
        var valueOfTransaction: Int32 = 0
         for transaction in _transactionList {
            guard transaction.year == Int32(_calendar.component(.year, from: _date)) else {continue}
            guard transaction.month == Int32(_calendar.component(.month, from: _date)) else {continue}
            if transaction.sign == "+" {
                valueOfTransaction += transaction.value
            } else if transaction.sign == "-" {
                valueOfTransaction -= transaction.value
            }
        }
        return Int(valueOfTransaction)
    }
    
    // Wartość transakcji z danego dnia
    public func getTodayValue() -> Int{
        var valueOfTransaction: Int32 = 0
        for transaction in _transactionList {
            guard transaction.year == Int32(_calendar.component(.year, from: _date)) else {continue}
            guard transaction.month == Int32(_calendar.component(.month, from: _date)) else {continue}
            guard transaction.day == Int32(_calendar.component(.day, from: _date)) else {continue}
            if transaction.sign == "+" {
                valueOfTransaction += transaction.value
            } else if transaction.sign == "-" {
                valueOfTransaction -= transaction.value
            }
        }
        return Int(valueOfTransaction)
    }
    
    // Zwraca ilość tranzakcji z aktualnego dnia
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
        let formater = DateFormatter()
        
        forTransaction.day = Int16(calendar.component(.day, from: date))
        forTransaction.month = Int16(calendar.component(.month, from: date))
        forTransaction.year = Int16(calendar.component(.year, from: date))
        forTransaction.hour = Int16(calendar.component(.hour, from: date))
        forTransaction.minute = Int16(calendar.component(.minute, from: date))
        formater.dateFormat = "yyyy-MM-dd HH:mm"
        forTransaction.date = formater.string(from: date)
        
    }
    
}
