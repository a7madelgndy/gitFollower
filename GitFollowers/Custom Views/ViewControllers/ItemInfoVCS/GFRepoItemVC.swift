//
//  GFRepoItemVC.swift
//  GitFollowers
//
//  Created by Ahmed El Gndy on 03/04/2025.
//

import UIKit

class GFRepoItemVC: GFItemInfoVc {

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
