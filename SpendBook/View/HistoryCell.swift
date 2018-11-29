//
//  HistoryCell.swift
//  SpendBook
//
//  Created by Tomasz Jaeschke on 29/11/2018.
//  Copyright © 2018 Tomasz Jaeschke. All rights reserved.
//

import UIKit

class HistoryCell: UITableViewCell {

    //Outlets
    @IBOutlet weak var transactionValueLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var imageLbl: UIImageView!
    
    func configureCell(_ transaction: Transaction) {
        
        var colorOfTransaction = UIColor.black
        if transaction.sign == "-"{
            colorOfTransaction = #colorLiteral(red: 0.9647058824, green: 0.4666666667, blue: 0.6901960784, alpha: 1)
            self.transactionValueLbl.text = "$-" + String(transaction.value)
        }
        if transaction.sign == "+" {
            colorOfTransaction = #colorLiteral(red: 0.2673969567, green: 0.8492315412, blue: 0.8062124848, alpha: 1)
            self.transactionValueLbl.text = "$" + String(transaction.value)
        }
        self.transactionValueLbl.textColor = colorOfTransaction
        
        if IconManager.instance.isIconEnable() {
            typeLbl.text = ""
            imageLbl.isHidden = false
            imageLbl.image = UIImage(named: transaction.type!)
        } else {
            typeLbl.text = transaction.type!
            imageLbl.isHidden = true
        }
        
        dateLbl.text = transaction.date!
    }
}
