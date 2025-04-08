//
//  UserInfoVc.swift
//  GitFollowers
//
//  Created by Ahmed El Gndy on 02/04/2025.
//

import UIKit
import SafariServices

protocol FollowerUserInfoVc: AnyObject {
    func didFollowertapped(with userusername : String)
}

final class UserInfoVc: GFDataLoadingVc {
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let headerView = UIView()
    private let itemViewOne = UIView()
    private let itemviewTwo = UIView()
    private var itemViews : [UIView] = [ ]
    private var dataLable = GFBodyLabel(textAlignment: .center)
    
    var  username: String?
    var  user: User?
    private var UserCreatedAt = String()
    
    weak var delegate: FollowerUserInfoVc!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configerViewController()
        configureScollView()
        layouUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getUserInfo()
    }
    
    func configureScollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        scrollView.pinToEdges(of: view)
        contentView.pinToEdges(of: scrollView)
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 600)
        ])
    }
    
    private func getUserInfo() {
        showLoadingView()
        NetWorkManager.shared.getUser(for: username ?? "caioiglesias") { [weak self] result in
            guard let self = self  else {return}
            self.dismissLoadingView()
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
        
        itemViewOne.backgroundColor = .secondarySystemBackground
        itemviewTwo.backgroundColor = .secondarySystemBackground
        
        self.add(childVc: GFUserInfoHeaderVC(user: user), to: self.headerView)
        self.add(childVc: GFRepoItemVC(user: user, delegate: self) , to: self.itemViewOne)
        self.add(childVc: GFFollowerItemVC(user: user, delegate:self) ,to: self.itemviewTwo)
        
        self.UserCreatedAt =  "Git hub Since \(user.created_at.convertToMonthYearFormat())"
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
            contentView.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor ,constant: padding),
                itemView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -padding)
            ])
        }
        
        itemViewOne.layer.cornerRadius = 20
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor , constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemviewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor , constant: padding),
            itemviewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dataLable.topAnchor.constraint(equalTo: itemviewTwo.bottomAnchor, constant: padding),
            dataLable.heightAnchor.constraint(equalToConstant: 40)
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
//MARK: Extension
extension UserInfoVc : GFRepoItemVCDelegete {
     func didTappedGitHubProfile(for user: User) {
        guard let url = URL(string: user.html_url) else {
            presentGFAlerONMainThread(
                title: "Invalid URL", message: "The url attaced to This user is invalid", buttonTile: "ok")
            return
        }
        pressenSafrieVC(with: url)
    }
}
extension UserInfoVc : GFFollowerItemVCDelegete {
     func didTappedGetFollowers(for user: User) {
        guard user.followers != 0 else {
            presentGFAlerONMainThread(title: "No Followers", message: "This user have no Follower , what a shame go follow them 😞", buttonTile: "ok")
            return
        }
        dismiss(animated: true)
        delegate.didFollowertapped(with: user.login)
    }
    
    
}

    
    

