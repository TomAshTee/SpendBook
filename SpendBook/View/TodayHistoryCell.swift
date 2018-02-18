 //
//  TodayHistoryCell.swift
//  SpendBook
//
//  Created by Tomasz Jaeschke on 11.02.2018.
//  Copyright © 2018 Tomasz Jaeschke. All rights reserved.
//

import UIKit

class TodayHistoryCell: UITableViewCell {

    // Otlets
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var transactionValueLbl: UILabel!
    @IBOutlet weak var typeImg: UIImageView!
    
    func configureCell(transaction: Transaction){
        
        var colorOfTransaction = UIColor.black
        if transaction.sign == "-"{
            colorOfTransaction = #colorLiteral(red: 0.9647058824, green: 0.4666666667, blue: 0.6901960784, alpha: 1)
            self.transactionValueLbl.text = "$-" + String(transaction.value)
        } else if transaction.sign == "+"{
            colorOfTransaction = #colorLiteral(red: 0.2673969567, green: 0.8492315412, blue: 0.8062124848, alpha: 1)
            self.transactionValueLbl.text = "$" + String(transaction.value)
        }
        
        if IconManager.instance.isIconEnable() {
            typeLbl.text = ""
            typeImg.isHidden = false
            typeImg.image = UIImage(named: transaction.type!)
        } else {
            typeLbl.text = transaction.type!
            typeImg.isHidden = true
        }
        self.transactionValueLbl.textColor = colorOfTransaction
    }

}
