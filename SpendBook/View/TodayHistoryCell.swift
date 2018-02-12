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
    
    func configureCell(type: TransactionType, transactionValue: Int){
        self.typeLbl.text = type.rawValue
        self.transactionValueLbl.text = "$" + String(transactionValue)
    }

}
