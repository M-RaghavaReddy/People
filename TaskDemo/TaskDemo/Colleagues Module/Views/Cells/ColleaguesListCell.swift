//
//  ColleaguesListCell.swift
//  TaskDemo
//
//  Created by raghavareddy.m on 22/10/22.
//

import UIKit

class ColleaguesListCell: UICollectionViewCell {
    @IBOutlet weak var personImage       : UIImageView!
    @IBOutlet weak var personNameLabel   : UILabel!
    @IBOutlet weak var personEmailLabel : UILabel!
    @IBOutlet weak var cardView           : UIView! {
        didSet {
            cardView.layer.cornerRadius = 6
            cardView.addShadow()
            self.layer.masksToBounds    = true
            cardView.layer.shadowRadius = 4
        }
    }
    // MARK:  Identifier
    static var identifier: String {
        return String(describing: self)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK:  Data Binding
    func configData(data:Person) {
        DispatchQueue.main.async {
            self.personImage.makeRounded()
            self.personImage.imageFromServerURL(urlString:  data.avatar ?? "", PlaceHolderImage: UIImage.init(named: "profile")!)
            self.personNameLabel.text = "\(data.firstName ?? empty) \(data.lastName ?? empty)"
            self.personEmailLabel.text = data.email
        }
        
    }
}
