//
//  SettingsVC.swift
//  SpendBook
//
//  Created by Tomasz Jaeschke on 11.02.2018.
//  Copyright © 2018 Tomasz Jaeschke. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {

    // Outlets
    @IBOutlet weak var historyIconSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        historyIconSwitch.isOn = UserSettings.instance.isHistoryIconEnable
    }
    
    // Actions
    @IBAction func backBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func isHistoryIconEnableChange(_ sender: Any) {
        UserSettings.instance.isHistoryIconEnable = historyIconSwitch.isOn
    }
}
