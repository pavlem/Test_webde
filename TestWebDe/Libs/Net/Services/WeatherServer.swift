//
//  WeatherServer.swift
//  TestWebDe
//
//  Created by Pavle Mijatovic on 02/02/2020.
//  Copyright © 2020 Pavle Mijatovic. All rights reserved.
//

import Foundation

class WeatherServer {
    let client = WebClient(baseUrl: ServiceAPI.protocolFormat + ServiceAPI.weatherAPI)
}
