//
//  NetworkHelper.swift
//  ScanAndGo
//
//  Created by Pavle Mijatovic on 12/18/18.
//  Copyright © 2018 Dansk Supermarked Group. All rights reserved.
//

import Foundation

struct URLStrings {
    static let nemIdResetUrlString = "https://www.nemid.nu/dk-da/faa_hjaelp_til_dit_nemid/administrer_nemid/forny_nemid/"
}

struct ServiceAPI {

    
    // MARK: - Properties
    static var environmentPrefixHeimdal: String {
        
        return "d-"
    }
    
    static var environmentPrefixMee: String {
        return "s-"

       
    }
    
    static var environmentPrefixSGPayment: String {
        return "d-"

    }

    static var environmentPrefixEnrolment: String {
        return "t-"
    }

    static var validationHost: String {
        return environmentPrefixEnrolment + idp
    }
    
    static let protocolFormat = "https://"
    static let sgSheme = "https"

    static let prefixHeimdal = protocolFormat + environmentPrefixHeimdal
    static let prefixMee = protocolFormat + environmentPrefixMee
    static let prefixSGPayment = protocolFormat + environmentPrefixSGPayment

    static let idp = "idp.dsgapps.dk"
    
    static var heimdal = prefixHeimdal + "sgpayment.dsgapps.dk/api/"
    static var mee = prefixMee + "sgpayment.dsgapps.dk/api/"
    static var payment = prefixSGPayment + "sgpayment.dsgapps.dk/api/"
    
    static var termsAndCoditionsUrlString: String {
        return environmentPrefixEnrolment + idp + "/clients/scan-and-go/consent/appTerms-v1.html"
    }
    
    static var scanAndGoTermsAndConditionsURLString = "https://t-idp.dsgapps.dk/clients/scan-and-go/consent/appTerms-v1.html"
    static var scanAndGoPrivacyPolicyURLString = "https://sallinggroup.com/privatlivspolitik/"

    static var sseLib: String {
        return heimdal + "/events?cs=userDevice"
    }
}

struct ServiceQueryItems {
    struct Enrollment {
        struct Login {
            static let name = "type"
            static let value = "login"
        }
        struct ClientTraceId {
            static let name = "clientTraceId"
        }
        struct NemId {
            static let name = "type"
            static let value = "nemid"
        }
        struct LoginHint {
            static let name = "login_hint"
        }
    }
}

struct ServiceEndpoint {
    
    static let enrolment = "/scanAndGoApp"

    struct Payment {
        static let enrol = "device"
        static let userCheck = "user/check"
        static let cardSession = "card/session"
        static let addCard = "card"
        static let getCard = "card"
        static let deleteCard = "card"
        static let checkIn = "store"
        static let payment = "payment"
        static let paymentStatus = "payment"
    }
    
    struct Heimdal {
        static let news = "/news"
        static let basket = "/basket"
        static let devSupport = "/dev-support"
        static let featureToggle = "/settings/featureToggles"
        static let store = "/store"
        static let systemInfo = "/settings/data"
        static let receiptNumber = "/receipt-number"
        static let receipts = "/receipts"
        static let selectionalgorithm = "/selectionalgorithm"
        static let sseHistoricalEvent = "/historicalEvents"
        static let findByLocation = "/store/findByLocation"
    }
    
    struct Mee {
        //Enrol
        static let enrol = "user/enroll"
        static let login = "signIn/login"
        static let createPhone = "phone/createPhone"
        static let enrollKey = "phone/enrollKey"
        //Credit Card
        static let creditCardCreate = "creditCard/create"
        static let creditCardGetAll = "creditCard/getAll"
        static let creditCardGet = "creditCard/get"

        //General
        static let getShopInfoByTerminalBlePackage = "shop/getShopInfoByTerminalBlePackage"
        //PhonePaymentFlow
        static let phonePaymentFlowProcessPaymentWithoutPos = "phonePaymentFlow/processPaymentWithoutPos"
        static let phonePaymentFlowProcessPaymentWithTerminalBlePackage = "phonePaymentFlow/processPaymentWithTerminalBlePackage"
        static let phonePaymentFlowGetStatus = "phonePaymentFlow/getStatus"
    }
}



protocol PropertyReflectable { }

extension PropertyReflectable {
    subscript(key: String) -> Any? {
        let m = Mirror(reflecting: self)
        return m.children.first { $0.label == key }?.value
    }
}
