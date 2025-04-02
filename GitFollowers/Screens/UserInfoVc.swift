//
//  UserInfoVc.swift
//  GitFollowers
//
//  Created by Ahmed El Gndy on 02/04/2025.
//

import UIKit

class UserInfoVc: UIViewController {
     
    var  username: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let button = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismisView))
        navigationItem.rightBarButtonItem = button
        
        NetWorkManager.shared.getUser(for: username ?? "caioiglesias") { [weak self] result in
            guard self != nil else {return}
            switch result {
                
            case .success(let user):
                print(user)
            case .failure(let error):
                self?.presentGFAlerONMainThread(title: "something went wrong ", message: error.rawValue, buttonTile: "ok")
                print(error)
            }
        }
    }
    
    @objc func dismisView() {
        dismiss(animated: true)
    }


}
