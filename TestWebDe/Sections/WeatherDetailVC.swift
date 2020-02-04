//
//  WeatherDetailVC.swift
//  TestWebDe
//
//  Created by Pavle Mijatovic on 01/02/2020.
//  Copyright © 2020 Pavle Mijatovic. All rights reserved.
//

import UIKit

class WeatherDetailVC: UIViewController {
    
    // MARK: - API
    var weatherPerDay: WeatherPerDay?
    
    // MARK: - Properties
    @IBOutlet weak var weatherInfo: UITextView!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myClass = weatherPerDay!
        var myClassDumped = String()
        dump(myClass, to: &myClassDumped)
        self.weatherInfo.text = myClassDumped
    }
}
