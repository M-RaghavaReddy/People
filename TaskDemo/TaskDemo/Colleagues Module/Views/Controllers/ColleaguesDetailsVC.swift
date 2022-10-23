//
//  ColleaguesDetailsVC.swift
//  TaskDemo
//
//  Created by raghavareddy.m on 22/10/22.
//

import UIKit

class ColleaguesDetailsVC: UIViewController {
    // MARK:  Instant method
    @objc static func getVC(model:ColleaguesVM) -> ColleaguesDetailsVC {
        let vc = Utilities.shared.createViewController(storyboard: "Colleagues", identifier: "ColleaguesDetailsVC", ofClass: ColleaguesDetailsVC.self)
        vc.viewModel = model
        return vc
    }
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var isOccupiedStatus: UIButton!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var jobTitle: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var occupiedCount: UILabel!
    @IBOutlet weak var occupancyView: UIView!{
        didSet {
            occupancyView.layer.cornerRadius = 6
            occupancyView.addShadow()
            occupancyView.layer.masksToBounds    = true
            occupancyView.layer.shadowRadius = 4
        }
    }
    var viewModel : ColleaguesVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.reloadUI = { [weak self] in
            self?.updateOccupancy()
        }
        // Do any additional setup after loading the view.
    }
    func updateOccupancy() {
        DispatchQueue.main.async {
            self.occupiedCount.text = "\(self.viewModel.selectedPerson?.PersonOccupancy?.maxOccupancy ?? 0)"
            self.isOccupiedStatus.setImage(UIImage.init(named: self.viewModel.selectedPerson?.PersonOccupancy?.isOccupied ?? false ? "Occupied" : "NotOccupied" ), for: .normal)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        setupData()
    }
    func setupData() {
        DispatchQueue.main.async {
            self.userImage.makeRounded()
        }
        userImage.imageFromServerURL(urlString: viewModel.selectedPerson?.avatar ?? "", PlaceHolderImage: UIImage.init(named: "profile")!)
        userName.text = "\(viewModel.selectedPerson?.firstName ?? empty) \(viewModel.selectedPerson?.lastName ?? empty)"
        userEmail.text = viewModel.selectedPerson?.email ?? empty
        jobTitle.text = viewModel.selectedPerson?.jobtitle ?? empty
        occupiedCount.text = "\(viewModel.selectedPerson?.PersonOccupancy?.maxOccupancy ?? 0)"
        isOccupiedStatus.setImage(UIImage.init(named: viewModel.selectedPerson?.PersonOccupancy?.isOccupied ?? false ? "Occupied" : "NotOccupied" ), for: .normal)
        
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}
