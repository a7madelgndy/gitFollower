//
//  UserInfoVc.swift
//  GitFollowers
//
//  Created by Ahmed El Gndy on 02/04/2025.
//

import UIKit

class UserInfoVc: UIViewController {
    
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemviewTwo = UIView()
    var itemViews : [UIView] = [ ]
    
    var  username: String?
    var  user: User?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configerViewController()
        layouUI()
        getUserInfo()
        itemViewOne.backgroundColor = .secondaryLabel
        itemviewTwo.backgroundColor = .secondaryLabel
    }
    
    
    func getUserInfo() {
        NetWorkManager.shared.getUser(for: username ?? "caioiglesias") { [weak self] result in
            guard let self = self  else {return}
            switch result {
                
            case .success(let user):
                DispatchQueue.main.async{
                    self.add(childVc: GFUserInfoHeaderVC(user: user), to: self.headerView)
                    self.add(childVc: GFRepoItemVC(user: user), to: self.itemViewOne)
                    self.add(childVc: GFFollowerItemVC(user: user), to: self.itemviewTwo)
                 
                }
                
            case .failure(let error):
                self.presentGFAlerONMainThread(title: "something went wrong ", message: error.rawValue, buttonTile: "ok")
                print(error)
            }
        }
    }
    
    
    func configerViewController() {
        view.backgroundColor = .systemBackground
        let button = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismisView))
        navigationItem.rightBarButtonItem = button
    }
    
    
    func layouUI() {
        let padding:CGFloat = 20
        let itemHeight:CGFloat = 140
        itemViews = [headerView, itemViewOne, itemviewTwo]
        
        for itemView in itemViews {
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor ,constant: padding),
                itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -padding)
            ])
        }
        itemviewTwo.layer.cornerRadius = 20
        itemViewOne.layer.cornerRadius = 20
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor , constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemviewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor , constant: padding),
            itemviewTwo.heightAnchor.constraint(equalToConstant: itemHeight)
        ])
        
    }
    
    func add(childVc : UIViewController , to containerView : UIView) {
     addChild(childVc)
     containerView.addSubview(childVc.view)
     childVc.view.frame = containerView.bounds
     childVc.didMove(toParent: self)
    }
    
    @objc func dismisView() {
        dismiss(animated: true)
    }


}
