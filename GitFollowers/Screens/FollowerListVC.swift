//
//  FollowerListVC.swift
//  GitFollowers
//
//  Created by Ahmed El Gndy on 25/03/2025.
//

import UIKit

class FollowerListVC: UIViewController {
    
    var username: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        NetWorkManager.shared.getFollowers(for: username, page: 1, completed: { result in
            switch result {
                
            case .success(let followers):
                print(followers)
                
            case .failure(let error):
                self.presentGFAlerONMainThread(title: "Bad stuff happend", message: error.rawValue, buttonTile: "ok")
                   
            }

        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //navigationController?.isNavigationBarHidden = false
        navigationController?.setNavigationBarHidden(false, animated: true)


        }
 

}
