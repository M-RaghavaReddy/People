//
//  Utilities.swift
//  TaskDemo
//
//  Created by raghavareddy.m on 22/10/22.
//

import Foundation
import UIKit


open class Utilities: NSObject {
    
    @objc public static let shared = Utilities()
    // MARK: -Get ViewController from storyboard
    public func createViewController<T>(storyboard:String, identifier:String, ofClass: T.Type, bundle: Bundle = Bundle(for: Utilities.self)) -> T{
        let controller = UIStoryboard(name: storyboard, bundle: bundle).instantiateViewController(withIdentifier: identifier) as? T
        return controller!
    }
    @objc public func getBundle() -> Bundle {
        return  Bundle.main
    }
}
public extension UIView {
    func addShadow() {
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.darkGray.withAlphaComponent(0.50).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 5
    }
}
extension UIImageView {
    func imageFromServerURL(urlString: String, PlaceHolderImage:UIImage) {
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                DispatchQueue.main.async(execute: { () -> Void in
                    self.image = PlaceHolderImage
                })
                print(error ?? "No Error")
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image == nil ? PlaceHolderImage : image
            })
            
        }).resume()
    }
    func makeRounded() {
        
        layer.borderWidth = 1
        layer.masksToBounds = false
        layer.borderColor = UIColor.black.cgColor
        layer.cornerRadius = self.frame.height / 2
        clipsToBounds = true
    }
}
