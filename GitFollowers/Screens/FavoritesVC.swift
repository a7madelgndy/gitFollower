//
//  FavoritesVC.swift
//  GitFollowers
//
//  Created by Ahmed El Gndy on 24/03/2025.
//

import UIKit

class FavoritesVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
       
        PresistenceManager.retriveFavorites { resulte in
            switch resulte {
                
            case .success(let follwers ):
                print(follwers)
            case .failure(_):
                break
            }
        }
    }
    


}
