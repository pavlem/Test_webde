//
//  WeatherFiveDaysServer.swift
//  TestWebDe
//
//  Created by Pavle Mijatovic on 02/02/2020.
//  Copyright © 2020 Pavle Mijatovic. All rights reserved.
//

import Foundation

class WeatherFiveDaysService: WeatherServer {
    
    func getFiveDayData(weatherFiveDaysReq: WeatherFiveDaysReq, completion: @escaping (WeatherFiveDaysResponse?, ServiceError?) -> Void) -> URLSessionDataTask? {
        
        return client.load(path: ServiceEndpoint.fiveDayForecast, method: .get, params: weatherFiveDaysReq.params, headers: nil) { (jsonObject, data, serviceErr) in

            guard jsonObject != nil else {
                completion(nil, serviceErr)
                return
            }

            do {
                let weatherFiveDaysResponse = try JSONDecoder().decode(WeatherFiveDaysResponse.self, from: data!)
                completion(weatherFiveDaysResponse, serviceErr)
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
                completion(nil, serviceErr)
            }
        }
    }
    
    func getMocFiveDayData(completion: (WeatherFiveDaysResponse) -> Void) {
        let path = Bundle.main.path(forResource: "weatherMOC", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        let weatherFiveDaysResponse = try! JSONDecoder().decode(WeatherFiveDaysResponse.self, from: data)
        completion(weatherFiveDaysResponse)
    }
}
