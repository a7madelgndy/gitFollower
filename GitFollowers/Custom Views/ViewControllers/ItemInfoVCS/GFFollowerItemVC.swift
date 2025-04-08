//
//  GFFollowerItemVC.swift
//  GitFollowers
//
//  Created by Ahmed El Gndy on 03/04/2025.
//

import UIKit

class GFFollowerItemVC: GFItemInfoVc {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .followers, withCount: user?.public_repos ?? 0 )
        itemInfoViewTwo.set(itemInfoType: .following, withCount: user?.public_gists ?? 0)
        actionButon.set(backgroundColor: .systemGreen , title: "Show Followers")
    }
    
    override func actionButtonTapped() {
        delegate?.DidTappedGetFollowers(for: user)
    }


}
