//
//  EmptyView.swift
//  TaskDemo
//
//  Created by raghavareddy.m on 22/10/22.
//

import UIKit

class EmptyView: UIView {
    
    @IBOutlet weak var emptyImage: UIImageView!
    @IBOutlet weak var lblTextMessage: UILabel!
    
    
    static func instantiate(message: String, image: UIImage?, frame: CGRect) -> EmptyView {
        let view: EmptyView = initFromNib()
        view.backgroundColor = .white
        view.lblTextMessage.textColor = .darkGray
        view.lblTextMessage.text = message
        view.emptyImage.image = image
        view.emptyImage.tintColor = .lightGray.withAlphaComponent(0.45)
        view.frame = frame
        view.tag = 777
        return view
    }
    
}


extension UIView {
    class func initFromNib<T: UIView>() -> T {
        return Utilities.shared.getBundle().loadNibNamed(String(describing: self), owner: nil, options: nil)?[0] as! T
    }
}
