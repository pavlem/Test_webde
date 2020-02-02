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
    private let minCityCharLength = 0 //3
    
    // MARK: - Actions
    @IBAction func fetchWeather(_ sender: UIButton) {

        let weatherFiveDaysReq = WeatherFiveDaysReq(cityName: "London")
        _ = WeatherFiveDaysServer().getFiveDayData(weatherFiveDaysReq: weatherFiveDaysReq, completion: { (weatherFiveDaysResponse, serErr) in
            
            
            print("=====")
        })
        
//        guard cityNameTxtFld.text!.count > minCityCharLength else {
//            AlertHelper.showAlert(txt: "City Name must have more than 3 characters") {}
//            return
//        }
//        
//        let wListTVC = UIStoryboard.weatherListTVC
//        wListTVC.cityName = cityNameTxtFld.text
//        navigationController?.pushViewController(wListTVC, animated: true)
    }
}


func logResponsePaja(data: Data?, httpResponse: URLResponse?, error: Error?) {
    print("⏪⏪⏪⏪⏪⏪⏪")
    print("data: \n\(String(describing: data))\n")
    print("response: \n\(String(describing: httpResponse))\n")
    print("error: \n\(String(describing: error))\n")
    
    guard let data = data else {
        print("⏪⏪⏪⏪⏪⏪⏪")
        return
    }
    
    print(data.prettyPrintedJSONString ?? "")
    print("⏪⏪⏪⏪⏪⏪⏪")
}
