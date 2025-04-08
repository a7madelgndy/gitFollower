//
//  GFFollowerItemVC.swift
//  GitFollowers
//
//  Created by Ahmed El Gndy on 03/04/2025.
//

import UIKit

protocol GFFollowerItemVCDelegete: AnyObject{
    func didTappedGetFollowers(for user: User)
}

class GFFollowerItemVC: GFItemInfoVc {
    
    weak var delegate: GFFollowerItemVCDelegete?
  
    
    init(user : User, delegate: GFFollowerItemVCDelegete? = nil ){
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
        itemInfoViewOne.set(itemInfoType: .followers, withCount: user?.public_repos ?? 0 )
        itemInfoViewTwo.set(itemInfoType: .following, withCount: user?.public_gists ?? 0)
        actionButon.set(backgroundColor: .systemGreen , title: "Show Followers")
    }
    
    
    override func actionButtonTapped() {
        delegate?.didTappedGetFollowers(for: user)
    }


}
