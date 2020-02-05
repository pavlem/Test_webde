//
//  TestWebDeTests.swift
//  TestWebDeTests
//
//  Created by Pavle Mijatovic on 01/02/2020.
//  Copyright © 2020 Pavle Mijatovic. All rights reserved.
//

import XCTest
@testable import TestWebDe

class TestWebDeTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testWeatherVM() {
        
        WeatherFiveDaysService().getMocFiveDayData { (weatherFiveDaysResponse) in
            let days = WeatherPerDay.handle(wList: weatherFiveDaysResponse.list)
            let day1 = days.first!
            let day2 = days[4]
            let day3 = days[5]

            let weatherListVM1 = WeatherListVM(weatherPerDay: day1)
            let weatherListVM2 = WeatherListVM(weatherPerDay: day2)
            let weatherListVM3 = WeatherListVM(weatherPerDay: day3)

            print("ssssss")
            
            XCTAssert(weatherListVM1.averageTemp == "Average temp: 283 K", "testWeatherVM not ok")
            XCTAssert(weatherListVM1.day == "Date: 2017-01-30", "testWeatherVM not ok")
            XCTAssert(weatherListVM1.startingTime == "Starting time: 18:00", "testWeatherVM not ok")

            XCTAssert(weatherListVM2.averageTemp == "Average temp: 285 K", "testWeatherVM not ok")
            XCTAssert(weatherListVM2.day == "Date: 2017-02-03", "testWeatherVM not ok")
            XCTAssert(weatherListVM2.startingTime == "Starting time: 00:00", "testWeatherVM not ok")
            
            XCTAssert(weatherListVM3.averageTemp == "Average temp: 284 K", "testWeatherVM not ok")
            XCTAssert(weatherListVM3.day == "Date: 2017-02-04", "testWeatherVM not ok")
            XCTAssert(weatherListVM3.startingTime == "Starting time: 00:00", "testWeatherVM not ok")
        }
    }
}
