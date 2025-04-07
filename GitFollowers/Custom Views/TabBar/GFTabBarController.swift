//
//  GFTabBarController.swift
//  GitFollowers
//
//  Created by Ahmed El Gndy on 07/04/2025.
//

import UIKit

class GFTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [searchNC() , createFavoritesNC()]
        UITabBar.appearance().tintColor = .systemGreen
    }
    
    func createFavoritesNC() -> UINavigationController {
        let favoritelistVC =  FavoritesVC()
        favoritelistVC.title = "Favorites"
        favoritelistVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        return UINavigationController(rootViewController: favoritelistVC)
    }
    
    func searchNC() ->UINavigationController {
        let searchVC = SearchVC()
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        return UINavigationController(rootViewController: searchVC)
    }
    

  
}
