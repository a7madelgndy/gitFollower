//
//  ViewController.swift
//  GitFollowers
//
//  Created by Ahmed El Gndy on 23/03/2025.
//

import UIKit

class SearchVC: UIViewController {
    let logoImageView      = UIImageView()
    let usernameTextFiled  = GFTextField()
    let callToActionButton = GfButton(backgroundColor: .systemGreen, title: "Get Followers")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        view.backgroundColor = .systemBackground
        configureLogoImage()
        configureTextFiled()
        configerCallToActionButton()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    func configureLogoImage() {
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "gh-logo")
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configureTextFiled() {
        view.addSubview(usernameTextFiled)
        
        NSLayoutConstraint.activate([
            usernameTextFiled.topAnchor.constraint(equalTo: logoImageView.bottomAnchor ,constant:  80),
            usernameTextFiled.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            usernameTextFiled.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -40),
            usernameTextFiled.heightAnchor.constraint(equalToConstant: 50 )
        ]
        
        )
    }
    
    func configerCallToActionButton(){
        view.addSubview(callToActionButton)
        NSLayoutConstraint.activate([
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
}

