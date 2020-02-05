//
//  WeatherImageService.swift
//  TestWebDe
//
//  Created by Pavle Mijatovic on 05/02/2020.
//  Copyright © 2020 Pavle Mijatovic. All rights reserved.
//

import UIKit

class WeatherImageService: WeatherImageServer {
    
    func getWeatherIcon(iconCode: String, completion: @escaping (UIImage?, ServiceError?) -> Void) -> URLSessionDataTask? {
        let fullPath = ServiceEndpoint.icon + "\(iconCode)@2x.png"
        
        return client.load(path: fullPath, method: .get, params: nil) { (_, data, serviceErr) in
            guard let data = data, serviceErr == nil, let image = UIImage(data: data) else {
                completion (nil, serviceErr)
                return
            }
            completion(image, nil)
        }
    }
}
