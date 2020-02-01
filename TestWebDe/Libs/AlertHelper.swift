//
//  AlertHelper.swift
//  TestWebDe
//
//  Created by Pavle Mijatovic on 01/02/2020.
//  Copyright © 2020 Pavle Mijatovic. All rights reserved.
//

import UIKit

struct AlertHelper {

    static var topVC: UIViewController? {
        return UIApplication.shared.windows.last?.rootViewController
    }
    
    static func showAlert(txt: String, success: @escaping ()->()) {
        let alertController = UIAlertController(title: nil, message: txt, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {  (_) in
            success()
        }))
        
        topVC?.present(alertController, animated: true)
    }
}
