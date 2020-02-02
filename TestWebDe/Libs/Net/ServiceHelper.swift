//
//  NetworkHelper.swift
//  ScanAndGo
//
//  Created by Pavle Mijatovic on 12/18/18.
//  Copyright © 2018 Dansk Supermarked Group. All rights reserved.
//

import Foundation

struct ServiceAPI {
    // MARK: - Properties
    static let protocolFormat = "https://"
    static let weatherAPI = "samples.openweathermap.org"
}

struct ServiceEndpoint {
    static let fiveDayForecast = "/data/2.5/forecast"
}

protocol PropertyReflectable { }

extension PropertyReflectable {
    subscript(key: String) -> Any? {
        let m = Mirror(reflecting: self)
        return m.children.first { $0.label == key }?.value
    }
}
