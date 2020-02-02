//
//  AppDelegate.swift
//  TestWebDe
//
//  Created by Pavle Mijatovic on 01/02/2020.
//  Copyright © 2020 Pavle Mijatovic. All rights reserved.
//

import Foundation

enum ServiceError: Error {
    case noInternetConnection
    case serverHostnameNotAvailable
    case osCausedConnectionAbort
    case custom(String)
    case unAvailable
    case other
    case bamboraErr(String)
    case meeErr(String)
}

extension ServiceError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .noInternetConnection:
            return "No Internet connection"
        case .serverHostnameNotAvailable:
            return "Server Not Available"
        case .osCausedConnectionAbort:
            return "Software caused connection abort"
        case .other:
            return "Something went wrong"
        case .unAvailable:
            return "Server NOT Available"
        case .custom(let message):
            return message
        case .bamboraErr(let msg):
            return msg
        case .meeErr(let msg):
            return msg
        }
    }
}

extension ServiceError {
    init(json: JSON) {
//        
//        if let paymentServerBamboraMsg = ServiceError.bamboraMsg(json: json) {
//            self = .custom(paymentServerBamboraMsg)
//            return
//        }
//        
//        if let errorName = ServiceError.errorName(json: json) {
//            self = .custom(errorName)
//            return
//        }
//        
//        if let message = ServiceError.errorMessage(json: json) {
//            self = .custom(message)
//            return
//        }
        
        self = .other
    }
}

extension Error {
    var code: Int { return (self as NSError).code }
    var domain: String { return (self as NSError).domain }
}
