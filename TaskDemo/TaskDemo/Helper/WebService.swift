//
//  WebService.swift
//  TaskDemo
//
//  Created by raghavareddy.m on 22/10/22.
//

import Foundation

final class WebService: NSObject {
   static func getServerData(path:String,completion:@escaping (Swift.Result<Data,Error>) -> ()) {
        guard let url = URL.init(string: "\(kBaseURL)\(path)") else { return  }
        let task = URLSession.shared.dataTask(with: url) { (data, response,error ) in
            if error != nil {
                completion(.failure(error!))
            }
            guard let data = data else {return }
            completion(.success(data))
        }
       task.resume()
    }
}
