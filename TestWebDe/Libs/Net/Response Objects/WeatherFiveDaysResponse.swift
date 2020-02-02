//
//  WeatherFiveDaysResponse.swift
//  TestWebDe
//
//  Created by Pavle Mijatovic on 02/02/2020.
//  Copyright © 2020 Pavle Mijatovic. All rights reserved.
//

import Foundation

struct WeatherFiveDaysResponse: Decodable {
    let cod: String
    let cnt: Int
    let list: [WeatherFiveDaysResponseList]
}

struct WeatherFiveDaysResponseList: Decodable {
    let dt: Date
    let main: WeatherFiveDaysResponseMain
    let weather: [WeatherFiveDaysResponseWeather]
    let clouds: WeatherFiveDaysResponseClouds
    let wind: WeatherFiveDaysResponseWind
    let dt_txt: String
}

struct WeatherFiveDaysResponseMain: Decodable {
    let temp: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Double
    let sea_level: Double
    let grnd_level: Double
    let humidity: Double
    let temp_kf: Double
}

struct WeatherFiveDaysResponseWeather: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct WeatherFiveDaysResponseClouds: Decodable {
    let all: Int
}

struct WeatherFiveDaysResponseWind: Decodable {
    let speed: Double
    let deg: Double
}
