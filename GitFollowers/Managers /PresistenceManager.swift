//
//  PresistenceManager.swift
//  GitFollowers
//
//  Created by Ahmed El Gndy on 07/04/2025.
//

import Foundation

enum PresistenceActionType {
    case add, reomve
}

enum PresistenceManager {
    
    static private let defulats = UserDefaults.standard
    
    private enum keys {
        static let favorites = "favorites"
    }
    
    static func updateWith(follower: Follower ,actionType: PresistenceActionType, completed : @escaping(GFError) -> Void) {
        retriveFavorites { resulte in
            switch resulte {
            case .success(let favorites):
                var retrivedFavorites = favorites
                
                switch actionType {
                case .add:
                    guard  !retrivedFavorites.contains(follower) else {
                        completed(.alreadyInFavorite)
                        
                        return
                    }
                    retrivedFavorites.append(follower)
                    defulats.set(retrivedFavorites, forKey: keys.favorites)
                    
                case .reomve:
                    retrivedFavorites.removeAll { $0.login == follower.login}
                }
                break
            case .failure(let error ):
                completed(error)
            }
        }
        
      }
    
    static func retriveFavorites(completed : @escaping(Result<[Follower] , GFError>)-> Void ) {
        guard let favorites = defulats.object(forKey: keys.favorites) as? Data else {
            completed(.success([]))
            return
        }
        
        do {
           let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let favorites = try decoder.decode([Follower].self, from: favorites)
            completed(.success(favorites) )
        }catch {
            completed(.failure(.unabelToFavorie))
        }
    }
    
    
    static func save(favorites : [Follower]) -> GFError? {
        let encoder = JSONEncoder()
        do{
            let encodedFavorites =  try encoder.encode(favorites)
            defulats.set(encodedFavorites, forKey: keys.favorites)
            return nil
        }catch {
            return GFError.unabelToFavorie
        }
      
    }
}
