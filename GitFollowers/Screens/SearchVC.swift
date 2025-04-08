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
    
    var logoImageTopConstrians: NSLayoutConstraint!
    
    var isUserNameEntered: Bool {

        return  !(usernameTextFiled.text?.isEmpty ?? true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubViews(logoImageView, usernameTextFiled, callToActionButton)
        configureLogoImage()
        configureTextFiled()
        configerCallToActionButton()
        createDismiskeyboardTapGesture()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        #warning("add this line")
        //usernameTextFiled.text = ""
        navigationController?.setNavigationBarHidden(true, animated: true)

    }
    
    func createDismiskeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(){
            view.endEditing(true)
    }
    
    
    @objc func pushFollowerListVC() {
        guard isUserNameEntered else {
            presentGFAlerONMainThread(title: "Emety UserName", message: "please enter a username . we need to know who to look for 😁 ", buttonTile: "ok")
        return
        }
        usernameTextFiled.resignFirstResponder()
        guard let username =  usernameTextFiled.text else { return  }
        let followerListVC = FollowerListVC(username: username)
 
        navigationController?.pushViewController(followerListVC, animated: true)
    }
    
    
    func configureLogoImage() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = Images.ghLogo
        
        let isSmallScreenDevice =  DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed || DeviceTypes.isiPhoneSE2ndAnd3rdGen
        
        let TopConstrianConstant: CGFloat = isSmallScreenDevice ? 20 : 80
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor , constant: TopConstrianConstant),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
        print(DeviceTypes.isiPhoneSE)
    }
    
    func configureTextFiled() {
        usernameTextFiled.delegate = self
        #warning("debging")
        usernameTextFiled.text = "sallen0400"
        
        NSLayoutConstraint.activate([
            usernameTextFiled.topAnchor.constraint(equalTo: logoImageView.bottomAnchor ,constant:  80),
            usernameTextFiled.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            usernameTextFiled.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -40),
            usernameTextFiled.heightAnchor.constraint(equalToConstant: 50 )
        ]
        
        )
    }
    
    func configerCallToActionButton(){
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
