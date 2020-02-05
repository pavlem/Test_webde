//
//  WeatherListVM.swift
//  TestWebDe
//
//  Created by Pavle Mijatovic on 04/02/2020.
//  Copyright © 2020 Pavle Mijatovic. All rights reserved.
//

import Foundation

struct WeatherListVM {
    let averageTemp: String
    let day: String
    let startingTime: String
    let iconString: String?
}

extension WeatherListVM {
    init(weatherPerDay: WeatherPerDay) {
        self.averageTemp = "Average temp: \(weatherPerDay.averageTemp) K"
        self.day = "Date: \(weatherPerDay.day)"
        self.startingTime = "Starting time: \(String(weatherPerDay.startingTime.prefix(5)))"
        self.iconString = weatherPerDay.iconString
    }
    
    init(weatherPerDay: WeatherFiveDaysResponseList) {
        self.averageTemp = "Average temp: \(weatherPerDay.main.temp) K"
        self.day = "Date: \(String(weatherPerDay.dt_txt.prefix(16)))"
        self.startingTime = ""
        self.iconString = weatherPerDay.weather.first!.icon
    }
}
