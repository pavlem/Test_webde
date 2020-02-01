//
//  StartVC.swift
//  TestWebDe
//
//  Created by Pavle Mijatovic on 01/02/2020.
//  Copyright © 2020 Pavle Mijatovic. All rights reserved.
//

import UIKit

class StartVC: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var cityNameTxtFld: UITextField!
    
    // MARK: - Actions
    @IBAction func fetchWeather(_ sender: UIButton) {
        guard cityNameTxtFld.text!.count > 2 else {
            
            AlertHelper.showAlert(txt: "City Name must have more than 3 characters") {
                print("sssss")
            }
            return
        }
        
        let wListTVC = UIStoryboard.weatherListTVC
        wListTVC.cityName = cityNameTxtFld.text
        navigationController?.pushViewController(wListTVC, animated: true)
    }
}
