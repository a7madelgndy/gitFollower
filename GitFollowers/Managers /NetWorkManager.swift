//
//  NetWorkManager.swift
//  GitFollowers
//
//  Created by Ahmed El Gndy on 25/03/2025.
//

import UIKit

final class NetWorkManager {
    static let shared = NetWorkManager()
    let cache         = NSCache<NSString, UIImage>()
    private let baseUrl = "https://api.github.com/users/"
    private init() {}
    
    func getFollowers(for username: String , page: Int , completed: @escaping(Result<[Follower] , ErrorMessages>) -> Void) {
        let endpoint = baseUrl + "\(username)/followers?per_page=10&page=\(page)"
  
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUsername) )
            return
        }
        let task = URLSession.shared.dataTask(with: url){ data , response , error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse , response.statusCode == 200  else{
                completed(.failure(.invalidResponse))
                return
            }
            
            do {
               let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data!)
                completed(.success(followers) )
            }catch {
                completed(.failure(.invalidDate))
            }
            
        }
        task.resume()
        
    }
    
    func getUser(for username: String , completed: @escaping(Result<User , ErrorMessages>) -> Void) {
        let endpoint = baseUrl + "\(username)"
        print(endpoint)
  
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUsername) )
            return
        }
        let task = URLSession.shared.dataTask(with: url){ data , response , error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse , response.statusCode == 200  else{
                completed(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                     completed(.failure(.invalidDate))
                     return
                 }
            
            do {
               let decoder = JSONDecoder()
                let username = try decoder.decode(User.self, from: data)
                completed(.success(username) )
            }catch {
                completed(.failure(.invalidDate))
            }
            
        }
        task.resume()
        
    }
}
