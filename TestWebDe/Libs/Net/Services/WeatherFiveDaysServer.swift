//
//  WeatherFiveDaysServer.swift
//  TestWebDe
//
//  Created by Pavle Mijatovic on 02/02/2020.
//  Copyright © 2020 Pavle Mijatovic. All rights reserved.
//

import Foundation

class WeatherFiveDaysServer: WeatherServer {
    
    func getFiveDayData(weatherFiveDaysReq: WeatherFiveDaysReq) -> URLSessionDataTask? {
        
        return client.load(path: ServiceEndpoint.fiveDayForecast, method: .get, params: weatherFiveDaysReq.params, headers: nil) { (jsonObject, data, serviceErr) in

            guard jsonObject != nil else {
//                completion(nil, serviceErr)
                return
            }

            do {
//                let paymentEnrolCheckUserResponse = try JSONDecoder().decode(PaymentEnrolCheckUserResponse.self, from: data!)
//                completion(paymentEnrolCheckUserResponse, serviceErr)
            } catch let jsonErr {
//                print("Error serializing json:", jsonErr)
//                completion(nil, serviceErr)
            }
        }
    }
}
