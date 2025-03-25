//
//  NetWorkManager.swift
//  GitFollowers
//
//  Created by Ahmed El Gndy on 25/03/2025.
//

import Foundation

class NetWorkManager {
    static let shared = NetWorkManager()
    private let baseUrl = "https://api.github.com/users/"
    private init() {}
    
    func getFollowers(for username: String , page: Int , completed: @escaping([Follower]?, String?)->Void) {
        let endpoint = baseUrl + "\(username)/followers?per_page=100&page=\(page)"
  
        guard let url = URL(string: endpoint) else {
            completed(nil , "this username created an invalid request , please try again")
            return
        }
        let task = URLSession.shared.dataTask(with: url){ data , response , error in
            if let _ = error {
                completed(nil , "unable to complete network , please check internet connection")
                return
            }
            guard let response = response as? HTTPURLResponse , response.statusCode == 200 else {
                completed(nil , "invalid response form the swrver. please try again.")
                return
            }
            
            do {
               let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data!)
                completed(followers , nil)
            }catch {
                completed(nil , "the data received from the server was invalid , try againni")
            }
            
        }
        task.resume()
        
    }
}
