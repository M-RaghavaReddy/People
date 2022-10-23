//
//  ColleaguesVM.swift
//  TaskDemo
//
//  Created by raghavareddy.m on 22/10/22.
//

import Foundation
public typealias VoidHandler = () -> Void

class ColleaguesVM : NSObject {
    var personList = [Person]()
    var filterPersonList = [Person]()
    var selectedPosition = 0
    var selectedPerson : Person?
    var reloadData  : VoidHandler?
    var internetAlert  : VoidHandler?
    var searchQuery : String?{
        didSet {
            searchByText()
        }
    }
    var reloadUI  : VoidHandler?
    
    override init() {
        super.init()
        //self.loadInitialData()
    }
    func searchByText() {
        if searchQuery?.count ?? 0 > 0 {
            self.filterPersonList.removeAll()
            self.filterPersonList = self.personList.filter {
                $0.firstName?.range(of: searchQuery ?? empty, options: .caseInsensitive) != nil || $0.lastName?.range(of: searchQuery ?? empty, options: .caseInsensitive) != nil || $0.email?.range(of: searchQuery ?? empty, options: .caseInsensitive) != nil            }
        }
        else {
            self.filterPersonList = self.personList
        }
        self.reloadData?()
    }
    func getItem(position:Int) -> Person? {
        if filterPersonList.indices.contains(position) {
            return filterPersonList[position]
        }
        return nil
    }
    func fetchSelectedItemDetails(_ completionHandler: @escaping (_ status: Bool) -> Void) {
        selectedPerson = self.filterPersonList[self.selectedPosition]
        if self.filterPersonList[self.selectedPosition].PersonOccupancy == nil {
            loadRoomData(roomId:self.filterPersonList[self.selectedPosition].id ?? empty)
        }
        completionHandler(true)
    }
    func getTotalItems() -> Int {
        return filterPersonList.count
    }
    
}
// MARK:  Service Call
extension ColleaguesVM {
    func loadInitialData() {
        if !Reachability.isConnectedToNetwork() {
            internetAlert?()
            return
        }
        WebService.getServerData(path: "/people/") { data in
            switch data {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let data):
                let decoder = JSONDecoder()
                let jsonPetitions = try? decoder.decode([Person].self, from: data)
                self.personList = jsonPetitions ?? [Person]()
                self.filterPersonList = self.personList
                self.reloadData?()
            }
        }
    }
    func loadRoomData(roomId:String) {
        if !Reachability.isConnectedToNetwork() {
            internetAlert?()
            return
        }
        WebService.getServerData(path: "/rooms/\(roomId)/") { data in
            switch data {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let data):
                let decoder = JSONDecoder()
                let jsonPetitions = try? decoder.decode(PersonOccupancy.self, from: data)
                self.filterPersonList[self.selectedPosition].PersonOccupancy = jsonPetitions
                self.selectedPerson = self.filterPersonList[self.selectedPosition]
                self.reloadUI?()
            }
        }
    }
    
}
