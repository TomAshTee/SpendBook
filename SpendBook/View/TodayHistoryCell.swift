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
    
    func configureCell(type: TransactionType, transactionValue: Int){
        
        if UserSettings.instance.isHistoryIconEnable {
            typeLbl.text = ""
            typeImg.isHidden = false
            typeImg.image = UIImage(named: type.rawValue)
        } else {
            typeLbl.text = type.rawValue
            typeImg.isHidden = true
        }
        
        self.transactionValueLbl.text = "$" + String(transactionValue)
    }

}
