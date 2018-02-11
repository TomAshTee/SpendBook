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
    @IBOutlet weak var categoryLbl: UILabel!
    @IBOutlet weak var transactionValueLbl: UILabel!
    
    func configureCell(category: String, transactionValue: Int){
        self.categoryLbl.text = category
        self.transactionValueLbl.text = "$" + String(transactionValue)
    }

}
