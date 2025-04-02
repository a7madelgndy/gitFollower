//
//  UserInfoVc.swift
//  GitFollowers
//
//  Created by Ahmed El Gndy on 02/04/2025.
//

import UIKit

class UserInfoVc: UIViewController {
     
    var username : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let button = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismisView))
        navigationItem.rightBarButtonItem = button

    }
    
    @objc func dismisView() {
        dismiss(animated: true)
    }


}
