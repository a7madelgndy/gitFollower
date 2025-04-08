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
    
    func getFollowers(for username: String , page: Int , completed: @escaping(Result<[Follower] , GFError>) -> Void) {
        let endpoint = baseUrl + "\(username)/followers?per_page=\(Constants.numberOfUsersPerPage)&page=\(page)"
  
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
    
    
    func getUser(for username: String , completed: @escaping(Result<User , GFError>) -> Void) {
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
                decoder.dateDecodingStrategy = .iso8601
                let username = try decoder.decode(User.self, from: data)
                completed(.success(username) )
            }catch {
                completed(.failure(.invalidDate))
            }
            
        }
        task.resume()
        
    }
    
    func downloadImage(from urlString : String , completed: @escaping(UIImage?)-> Void) {
        let cacheKey =  NSString(string: urlString)
        if let image = self.cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        
        guard let url = URL(string: urlString) else { return }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self ,
                  error == nil,
                  let response = response as? HTTPURLResponse ,
                  response.statusCode == 200 ,
                  let data = data  ,
            let image = UIImage(data: data) else  {
                completed(nil)
                return
            }
            
            completed(image)
            self.cache.setObject(image, forKey: cacheKey)
        }
        task.resume()
    }
}
