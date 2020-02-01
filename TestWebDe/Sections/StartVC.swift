//
//  StartVC.swift
//  TestWebDe
//
//  Created by Pavle Mijatovic on 01/02/2020.
//  Copyright © 2020 Pavle Mijatovic. All rights reserved.
//

import UIKit

class StartVC: UIViewController {
    @IBOutlet weak var cityNameTxtFld: UITextField!
    
    @IBAction func fetchWeather(_ sender: UIButton) {
        guard cityNameTxtFld.text!.count > 0 else {
            return
        }
        print("fetching........")
    }
}
