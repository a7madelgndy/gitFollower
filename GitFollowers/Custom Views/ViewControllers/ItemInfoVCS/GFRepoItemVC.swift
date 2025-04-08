//
//  GFRepoItemVC.swift
//  GitFollowers
//
//  Created by Ahmed El Gndy on 03/04/2025.
//

import UIKit

protocol GFRepoItemVCDelegete: AnyObject{
    func didTappedGitHubProfile(for user: User)
}

class GFRepoItemVC: GFItemInfoVc {
    
    weak var delegate: GFRepoItemVCDelegete?
    
    init(user : User, delegate: GFRepoItemVCDelegete? = nil ) {
        super.init(user: user)
        self.delegate = delegate
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems() 
    }
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .repos, withCount: user?.public_repos ?? 0 )
        itemInfoViewTwo.set(itemInfoType: .gists, withCount: user?.public_gists ?? 0)
        actionButon.set(backgroundColor: .systemPurple, title: "GitHub Profile")
    }
    
    override func actionButtonTapped() {
        delegate?.didTappedGitHubProfile(for: user )
    }
}
