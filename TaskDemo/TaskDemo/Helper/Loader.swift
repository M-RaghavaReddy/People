//
//  Loader.swift
//  TaskDemo
//
//  Created by raghavareddy.m on 22/10/22.
//

import Foundation
import UIKit
class Loader: NSObject {
    
    static let sharedInstance = Loader()
    
    let indicator = UIActivityIndicatorView(style: .gray)    
    var rootController:UIViewController?
    func show(_ baseView:UIViewController) {
        rootController = baseView
        indicator.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0)
        indicator.frame.origin.x = (baseView.view.bounds.width/2 - 20)
        indicator.frame.origin.y = (baseView.view.bounds.height/2 - 20)
        rootController?.view.addSubview(indicator)
        indicator.startAnimating()
    }
    
    func hide() {
        DispatchQueue.main.async {
            self.indicator.stopAnimating()
            self.indicator.removeFromSuperview()
        }
    }
    
}
