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
        self.averageTemp = "Average temp is: \(weatherPerDay.averageTemp) K"
        self.day = "Day is: \(weatherPerDay.day)"
        self.startingTime = "Starting time is: \(weatherPerDay.startingTime)"
        self.iconString = weatherPerDay.iconString
    }
}
