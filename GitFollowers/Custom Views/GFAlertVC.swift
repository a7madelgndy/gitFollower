//
//  GFAlertVC.swift
//  GitFollowers
//
//  Created by Ahmed El Gndy on 25/03/2025.
//

import UIKit

class GFAlertVC: UIViewController {
    let containerView = UIView()
    let titleLabel    = GFTitleLabel(textAlignment: .center, fontsize: 20)
    let messageLabel  = GFBodyLabel(textAlignment: .center)
    let actionButton  = GfButton(backgroundColor: .systemPink, title: "OK")
    
    var alerTitle : String?
    var message: String?
    var buttonTile : String?
    
    let padding : CGFloat = 20
    
    
    init(title: String? = nil, message: String? = nil, buttonTile: String? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.alerTitle = title
        self.message = message
        self.buttonTile = buttonTile
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        configerContainerView()
        configerTitleLable()
        configerActionButton()
        configerMessageLabel()
        
    }
    
    
    func configerContainerView(){
        view.addSubview(containerView)
        containerView.backgroundColor = .systemBackground
        containerView.layer.cornerRadius = 16
        containerView.layer.borderWidth = 2
        containerView.layer.borderColor = UIColor.white.cgColor
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 220)
        ])
    }
    
    func configerTitleLable() {
        containerView.addSubview(titleLabel)
        titleLabel.text = alerTitle ?? "someting Went Wrong"
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor , constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    func configerActionButton() {
        containerView.addSubview(actionButton)
        actionButton.setTitle(buttonTile ?? "ok", for: .normal)
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate(
        [
            actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor , constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 30)
        ]
        )
    }
    func configerMessageLabel() {
        containerView.addSubview(messageLabel)
        messageLabel.text = message ?? "unable to complete request"
        messageLabel.numberOfLines = 4
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 8),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor  , constant: padding),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor , constant : -padding)
        ])
    }
    @objc func dismissVC() {
        dismiss(animated: true )
    }
    

}

