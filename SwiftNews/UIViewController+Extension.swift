//
//  UIViewController+Extension.swift
//  SwiftNews
//
//  Created by Mark Kim on 2020-03-23.
//  Copyright © 2020 Mark. All rights reserved.
//
import UIKit

var spinningView: UIView?

extension UIViewController {
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = .clear
        
        var indicatiorView = UIActivityIndicatorView.init()
        if #available(iOS 13.0, *) {
            indicatiorView = UIActivityIndicatorView.init(style: .large)
        } else {
            indicatiorView = UIActivityIndicatorView.init(style: .whiteLarge)
        }
        indicatiorView.startAnimating()
        indicatiorView.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(indicatiorView)
            onView.addSubview(spinnerView)
        }
        
        spinningView = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            spinningView?.removeFromSuperview()
            spinningView = nil
        }
    }
}
