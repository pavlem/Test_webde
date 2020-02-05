//
//  WeatherImageServer.swift
//  TestWebDe
//
//  Created by Pavle Mijatovic on 05/02/2020.
//  Copyright © 2020 Pavle Mijatovic. All rights reserved.
//

import Foundation

class WeatherImageServer {
    let client = WebClient(baseUrl: ServiceAPI.secureProtocolFormat + ServiceAPI.weatherImageAPI)
}
