//
//  GFItemInfoVc.swift
//  GitFollowers
//
//  Created by Ahmed El Gndy on 03/04/2025.
//

import UIKit

class GFItemInfoVc: UIViewController {
    let stackView  = UIStackView()
    let itemInfoViewOne = GFItemInfoView()
    let itemInfoViewTwo = GFItemInfoView()
    let actionButon = GfButton()

    var user:User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configerControllerView()
        configureStackView()
        LayouUI()
   
    }
    
    init(user: User!) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configerControllerView() {
        view.layer.cornerRadius = 18
        view.layer.borderWidth = 5    
    }
    
    private func configureStackView() {
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.addArrangedSubview(itemInfoViewOne)
        stackView.addArrangedSubview(itemInfoViewTwo)
    }
    
    private func LayouUI() {
        let padding:CGFloat = 15
        view.addSubview(stackView)
        view.addSubview(actionButon)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate( [
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor , constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            
            
            actionButon.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: padding),
            actionButon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant : padding),
            actionButon.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:  -padding),
            actionButon.heightAnchor.constraint(equalToConstant: 44)
        ])
        
    }
}
