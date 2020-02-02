//
//  Blockscreen.swift
//  TestWebDe
//
//  Created by Pavle Mijatovic on 01/02/2020.
//  Copyright © 2020 Pavle Mijatovic. All rights reserved.
//

import UIKit

class BlockScreen: UIView {
    
    // MARK: - API
    func showBlocker(success: @escaping () -> Void) {
        guard let topVC = BlockScreen.topVC else { return }
        topVC.view.addSubview(self)
        alpha = 0
        
        UIView.animate(withDuration: animationDuration, animations: {
            self.alpha = 0.65
            success()
        })
    }
    
    static func hideBlocker() {
        guard let topVC = BlockScreen.topVC else { return }
        for view in topVC.view.subviews where view is BlockScreen {
            view.removeFromSuperview()
        }
    }
    
    // MARK: - Properties
    private let animationDuration = 0.5

    private static var topVC: UIViewController? {
        if var topController = UIApplication.shared.delegate?.window??.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        return nil
    }
    
    // MARK: - Inits
    convenience init(title: String?) {
        self.init(frame: UIScreen.main.bounds)

        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }
    
    // MARK: - Helper
    private func setupView() {
        backgroundColor = .black
        
        setActivityIndicator()
    }
    
    private func setActivityIndicator() {
        let activityView = UIActivityIndicatorView(style: .large)
        activityView.center = center
        addSubview(activityView)
        activityView.startAnimating()
    }
}
