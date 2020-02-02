//
//  WeatherFiveDaysReq.swift
//  TestWebDe
//
//  Created by Pavle Mijatovic on 02/02/2020.
//  Copyright © 2020 Pavle Mijatovic. All rights reserved.
//

import Foundation

struct WeatherFiveDaysReq {
    let cityName: String
    let appId = "b6907d289e10d714a6e88b30761fae22"
}

extension WeatherFiveDaysReq {
    var params: [String: Any] {
        return [
            "q": self.cityName,
            "appid": self.appId
        ]
    }
}
