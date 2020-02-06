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
    // MARK: Outlets
    @IBOutlet weak var cityNameTxtFld: UITextField!
    // MARK: Constants
    private let minCityCharLength = 3
    
    // MARK: - Actions
    @IBAction func fetchWeather(_ sender: UIButton) {
        
        guard cityNameTxtFld.text!.count > minCityCharLength else {
            AlertHelper.showAlert(txt: "City Name must have more than 3 characters") {}
            return
        }
        
        guard ReachabilityHelper.shared.reachability.connection != .none else {
            AlertHelper.showAlert(txt: "No Internet") {}
            return
        }
        
        let wListTVC = UIStoryboard.weatherListTVC
        wListTVC.cityName = cityNameTxtFld.text
        navigationController?.pushViewController(wListTVC, animated: true)
    }
}
