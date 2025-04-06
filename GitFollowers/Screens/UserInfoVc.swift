//
//  UserInfoVc.swift
//  GitFollowers
//
//  Created by Ahmed El Gndy on 02/04/2025.
//

import UIKit
import SafariServices

protocol ActionButtonDelegete: AnyObject{
    func didTappedGitHubProfile(for user: User)
    func DidTappedGetFollowers(for user: User)
}


class UserInfoVc: UIViewController {
    
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemviewTwo = UIView()
    var itemViews : [UIView] = [ ]
    var dataLable = GFBodyLabel(textAlignment: .center)
    
    var  username: String?
    var  user: User?
    var UserCreatedAt = String()
    
    
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
                DispatchQueue.main.async{self.configureUIElemtets(user: user)}
                
            case .failure(let error):
                self.presentGFAlerONMainThread(title: "something went wrong ", message: error.rawValue, buttonTile: "ok")
                print(error)
            }
        }
    }
    
    
    private func configureUIElemtets(user : User) {
        let userInfoHeader = GFUserInfoHeaderVC(user: user)
        
        let repoItemVc = GFRepoItemVC(user: user)
        repoItemVc.delegate = self
        
        let followerItemVC = GFFollowerItemVC(user: user)
        followerItemVC.delegate = self
        
        
        self.add(childVc: userInfoHeader, to: self.headerView)
        self.add(childVc: repoItemVc , to: self.itemViewOne)
        self.add(childVc: followerItemVC ,to: self.itemviewTwo)
        
        self.UserCreatedAt =  user.created_at.convertToDisplayFormat()
        self.dataLable.text = self.UserCreatedAt
    }
    
    
    private func configerViewController() {
        view.backgroundColor = .systemBackground
        let button = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismisView))
        navigationItem.rightBarButtonItem = button
    }
    
    
    private func layouUI() {
        let padding:CGFloat = 20
        let itemHeight:CGFloat = 140
        itemViews = [headerView, itemViewOne, itemviewTwo ,dataLable]
        
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
            itemviewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dataLable.topAnchor.constraint(equalTo: itemviewTwo.bottomAnchor, constant: padding),
            dataLable.heightAnchor.constraint(equalToConstant: 23)
        ])
        
    }
    
    private func add(childVc : UIViewController , to containerView : UIView) {
     addChild(childVc)
     containerView.addSubview(childVc.view)
     childVc.view.frame = containerView.bounds
     childVc.didMove(toParent: self)
    }
    
    @objc func dismisView() {
        dismiss(animated: true)
    }


}

extension UserInfoVc: ActionButtonDelegete {
    func didTappedGitHubProfile(for user: User) {
        guard let url = URL(string: user.html_url) else {
            presentGFAlerONMainThread(
                title: "Invalid URL", message: "The url attaced to This user is invalid", buttonTile: "ok")
            return
        }
        pressenSafrieVC(with: url)
    }
    
    func DidTappedGetFollowers(for user: User) {
        print("follower button tapped")
    }

}
    
    

