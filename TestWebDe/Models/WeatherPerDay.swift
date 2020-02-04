//
//  WeatherPerDay.swift
//  TestWebDe
//
//  Created by Pavle Mijatovic on 04/02/2020.
//  Copyright © 2020 Pavle Mijatovic. All rights reserved.
//

import Foundation

struct WeatherPerDay {
    let averageTemp: String
    let day: String
    let iconString: String
    let valuesPer3HourPeriod: [WeatherFiveDaysResponseList]
    let startingTime: String
}

extension WeatherPerDay {
    init(valuesPer3HourPeriod: [WeatherFiveDaysResponseList]) {
        let allTemperatures = valuesPer3HourPeriod.map({$0.main.temp})
        
        self.averageTemp = String(Int(allTemperatures.reduce(0, +)) / allTemperatures.count)
        self.iconString = valuesPer3HourPeriod.first!.weather.map({$0.icon}).first!
        self.startingTime = valuesPer3HourPeriod.first!.startingTime
        self.day = valuesPer3HourPeriod.first!.dt_txtShort
        self.valuesPer3HourPeriod = valuesPer3HourPeriod
    }
}

extension WeatherPerDay {
    
    static func handle(wList: [WeatherFiveDaysResponseList]) -> [WeatherPerDay] {
        let crossReference = Dictionary(grouping: wList, by: {$0.dt_txtShort})
        var days = [WeatherPerDay]()
        for key in crossReference.keys {
            guard let valuesPer3HourPeriod = crossReference[key] else {
                continue
            }
            days.append(WeatherPerDay(valuesPer3HourPeriod: valuesPer3HourPeriod))
        }
        days.sort { $0.day < $1.day }
        return days
    }
}
