//
//  UIStoryboard+Extension.swift
//  TestWebDe
//
//  Created by Pavle Mijatovic on 01/02/2020.
//  Copyright © 2020 Pavle Mijatovic. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard {
    static var mainSB: UIStoryboard { return UIStoryboard(name: "Main", bundle: nil) }
    
    static var startVC: StartVC { return mainSB.instantiateViewController(identifier: "StartVC_ID") as! StartVC }
    static var weatherListTVC: WeatherListTVC { return mainSB.instantiateViewController(identifier: "WeatherListTVC_ID") as! WeatherListTVC }
    static var weatherDetailVC: WeatherDetailVC { return mainSB.instantiateViewController(identifier: "WeatherDetailVC_ID") as! WeatherDetailVC }
}
