//
//  ColleaguesListVC.swift
//  TaskDemo
//
//  Created by raghavareddy.m on 22/10/22.
//

import UIKit

class ColleaguesListVC: UIViewController {
    // MARK: Outlets
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.backgroundImage = UIImage()
            searchBar.searchBarStyle = .default
            searchBar.placeholder = kPersonSearch
            
        }
    }
    @IBOutlet weak var collectioView: UICollectionView!{
        didSet {
            self.collectioView.register(UINib(nibName: "ColleaguesListCell", bundle: nil), forCellWithReuseIdentifier: "ColleaguesListCell")
            collectioView.collectionViewLayout = layout
        }
    }
    @IBOutlet weak var emptyView: UIView!
    
    @IBOutlet weak var mainView: UIView!
    var layout: UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        return layout
    }
    var viewModel = ColleaguesVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.reloadData = { [weak self] in
            self?.refreshUI()
        }
        viewModel.internetAlert = { [weak self] in
            self?.displayNoNetworkAlert()
        }
        Loader.sharedInstance.show(self)
        viewModel.loadInitialData()
        // Do any additional setup after loading the view.
    }
    
    func displayNoNetworkAlert() {
        Loader.sharedInstance.hide()
        UIAlertController.show(self, empty, kNo_network)
        DispatchQueue.main.async {
            if self.viewModel.getTotalItems() > 0 {
                self.mainView.alpha = 1
            } else {
                self.mainView.alpha = 0
                if self.view.viewWithTag(777) == nil {
                    let empty = EmptyView.instantiate(message: kNo_network, image: UIImage.init(named: kEmpty), frame: self.emptyView.bounds)
                    empty.backgroundColor = UIColor.lightGray.withAlphaComponent(0.35)
                    self.emptyView.insertSubview(empty, at: 0)
                }
            }
            self.collectioView.reloadData()
        }
    }
    func refreshUI() {
        DispatchQueue.main.async {
            if self.viewModel.getTotalItems() > 0 {
                self.mainView.alpha = 1
            } else {
                self.mainView.alpha = 0
                if self.view.viewWithTag(777) == nil {
                    let empty = EmptyView.instantiate(message: kNoData, image: UIImage.init(named: kEmpty), frame: self.emptyView.bounds)
                    empty.backgroundColor = UIColor.lightGray.withAlphaComponent(0.35)
                    self.emptyView.insertSubview(empty, at: 0)
                }
            }
            self.collectioView.reloadData()
            Loader.sharedInstance.hide()
        }
    }
    func showDetails() {
        viewModel.fetchSelectedItemDetails { status in
            let vc =  ColleaguesDetailsVC.getVC(model: self.viewModel)
            self.present(vc, animated: true)
        }
    }
}
extension ColleaguesListVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getTotalItems()
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColleaguesListCell.identifier, for: indexPath) as? ColleaguesListCell
        cell?.configData(data: viewModel.getItem(position: indexPath.item) ?? Person())
        cell?.layoutIfNeeded()
        return cell ?? UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.selectedPosition = indexPath.item
        showDetails()
    }
}

extension ColleaguesListVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = ISPHONE ? collectionView.bounds.width : collectionView.bounds.width/2.1
        return CGSize(width: collectionViewWidth, height: 100)
    }
}
// MARK:  SearchBar Delegate
extension ColleaguesListVC : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchQuery = searchText.isEmpty ? nil : searchText
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.viewModel.searchQuery = nil
        searchBar.resignFirstResponder()
        searchBar.text = empty
        self.collectioView.scrollsToTop = true
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchTxt = searchBar.text {
            viewModel.searchQuery = searchTxt
        }
        searchBar.resignFirstResponder()
    }
}
