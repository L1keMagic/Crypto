//
//  SettingsViewController.swift
//  Crypto
//
//  Created by Артур Карачев on 22.09.2021.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Settings"
        view.backgroundColor = .lightGray
    }
    
}
