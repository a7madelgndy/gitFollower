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
    
    var isUserNameEntered: Bool {

        return  !(usernameTextFiled.text?.isEmpty ?? true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        view.backgroundColor = .systemBackground
        configureLogoImage()
        configureTextFiled()
        configerCallToActionButton()
        createDismiskeyboardTapGesture()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)

    }
    
    func createDismiskeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    @objc func pushFollowerListVC() {
        guard isUserNameEntered else {
            presentGFAlerONMainThread(title: "Emety UserName", message: "please enter a username . we need to know who to look for 😁 ", buttonTile: "ok")
        return
        }
        let followerListVC = FollowerListVC()
        followerListVC.username = usernameTextFiled.text
        followerListVC.title = usernameTextFiled.text
        navigationController?.pushViewController(followerListVC, animated: true)
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
        usernameTextFiled.delegate = self
        
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
        callToActionButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)
        NSLayoutConstraint.activate([
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
}

extension SearchVC:UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowerListVC()
        return true
    }
}
