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
    
    init(weatherPerHour: WeatherFiveDaysResponseList) {
        self.averageTemp = "Average temp: \(weatherPerHour.main.temp) K"
        self.day = "Date: \(String(weatherPerHour.dt_txt.prefix(16)))"
        self.startingTime = ""
        self.iconString = weatherPerHour.weather.first!.icon
    }
}
