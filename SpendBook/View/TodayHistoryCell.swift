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
    
    func configureCell(type: String, transactionValue: Int, color: UIColor){
        
        if IconManager.instance.isIconEnable() {
            typeLbl.text = ""
            typeImg.isHidden = false
            typeImg.image = UIImage(named: type)
        } else {
            typeLbl.text = type
            typeImg.isHidden = true
        }
        self.transactionValueLbl.textColor = color
        self.transactionValueLbl.text = "$" + String(transactionValue)
    }

}
