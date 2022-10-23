//
//  Alert.swift
//  TaskDemo
//
//  Created by raghavareddy.m on 22/10/22.
//

import Foundation
import UIKit

public extension UIAlertController {
    
    //MARK:  Show Message & title
    static func show(_ viewController: UIViewController, _ title: String?, _ message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        DispatchQueue.main.async {  
            viewController.present(alert, animated: true, completion: nil)
        }
    }
}
