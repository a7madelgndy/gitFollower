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
        NetWorkManager.shared.getFollowers(for: username, page: 1, completed: { (followers , errormassage) in
            guard let followers else {
                self.presentGFAlerONMainThread(title: "Bad stuff happend", message: errormassage ?? "no thing", buttonTile: "done")
                return
            }
            print(followers)
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //navigationController?.isNavigationBarHidden = false
        navigationController?.setNavigationBarHidden(false, animated: true)


        }
 

}
