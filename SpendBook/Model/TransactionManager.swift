//
//  TransactionManager.swift
//  SpendBook
//
//  Created by Tomasz Jaeschke on 15.02.2018.
//  Copyright © 2018 Tomasz Jaeschke. All rights reserved.
//

import UIKit
import CoreData

/// Management of transactions made by the user
class TransactionManager {
    
    /// Static field that allows to access singleton instance.
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
    
    /// Saving the list of transactions from Core Data to the manager.
    /// - Parameter ofTransaction: Array fo Transaction from CoreData to set.
    private func setList(_ ofTransaction:[Transaction]){
        _transactionList = ofTransaction
    }
    
    /// Retrieving transaction from specific period of time.
    /// - Parameters:
    ///   - fromDate: Transaction from this date.
    ///   - toDate: Transaction to this date.
    /// - Returns: Array of [Transaction] from period of time.
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
    
    /// Get todays transaction with specific index number.
    /// - Parameter transactionOfIndex: Index of transaction
    /// - Returns: Transaction with a specific index.
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
    
    /// Get transaction with specific index number form all transaction list.
    /// - Parameter trancsationOfIndex: Index of transaction.
    /// - Returns: Transaction with a specific index.
    public func getFromAll(_ trancsationOfIndex: Int) -> Transaction {
        return _transactionList[trancsationOfIndex]
    }
    
    /// Getting the sum of the values of all performed transactions.
    /// - Returns: Summary value of all transactions.
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
    
    /// Getting the sum of the values of all performed transactions from actual month.
    /// - Returns: Summary value of all transaction from actual month.
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
    
    /// Getting the sum of the transactions performed today.
    /// - Returns: Summary value of transaction perfromed today.
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
    
    /// Getting the number of transactions performed today.
    /// - Returns: Number of transactions performed today.
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
    
    /// Getting the number of all transactions
    /// - Returns: Number of all transactions
    public func countAll() -> Int {
        return _transactionList.count
    }
    
    /// Setting actual date for transaction.
    /// - Parameter forTransaction: The transaction for which the date is to be set.
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
    
    //MARK: - Fetch from core data
    
    /// Getting transactions from CoreData
    public func fetchFromCoreData(completion: (_ complete: Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Transaction")
        
        do {
            try TransactionManager.instance.setList(managedContext.fetch(fetchRequest) as! [Transaction])
            print("Successfull fetched data.")
            completion(true)
        } catch {
            debugPrint("Could not fetch: \(error.localizedDescription)")
            completion(false )
        }
    }
    
    /// Remove transaction in specific indexPath
    /// - Parameter indexPath: IndexPath of transaction to remove
    public func remove(transactionAt indexPath: IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        // Transaction list is reverse by the way it's display
        managedContext.delete(TransactionManager.instance.getToday((TransactionManager.instance.countToday() - 1) - indexPath.row))
        
        do {
            try managedContext.save()
            print("Successfull remove transaction")
        } catch {
            debugPrint("Could not remove: \(error.localizedDescription)")
        }
    }
}

