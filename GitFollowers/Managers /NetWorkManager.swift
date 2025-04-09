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
    private let decoder = JSONDecoder()
    
    
    private init() {
    
        decoder.dateDecodingStrategy = .iso8601
    }
    
    func getFollowers(for username: String , page: Int) async throws-> [Follower] {
        let endpoint = baseUrl + "\(username)/followers?per_page=\(Constants.numberOfUsersPerPage)&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            throw GFError.invalidUsername
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        
        guard let response = response as? HTTPURLResponse , response.statusCode == 200  else{
            throw GFError.invalidResponse
        }
        
        
        do {
            return try decoder.decode([Follower].self, from: data)
            
        }catch {
            throw GFError.invalidDate
        }
        
    }
    
    
    func getUser(for username: String ) async throws -> User {
        let endpoint = baseUrl + "\(username)"
        
        guard let url = URL(string: endpoint) else {throw GFError.invalidUsername}
        
        let (data , _ ) = try await URLSession.shared.data(from: url)
        
        do {
            let user = try decoder.decode(User.self, from: data)
            return user
        }catch {
            throw GFError.invalidDate
        }
        
    }

    
    func downloadImage(from urlString : String ) async  -> UIImage? {
        let cacheKey =  NSString(string: urlString)
        if let image = self.cache.object(forKey: cacheKey) { return  image }
        
        guard let  url = URL(string: urlString) else {return  nil }
        
        do {
            let (data , _ ) = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: data) else {return nil }
            self.cache.setObject(image, forKey: cacheKey)
            return image
        }
        catch {
            return nil
        }
    }
}



//MARK: Refrence to the old networking


/*
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
 
 */
