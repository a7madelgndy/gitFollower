//
//  GFItemInfoView.swift
//  GitFollowers
//
//  Created by Ahmed El Gndy on 03/04/2025.
//

import UIKit

enum ItemInfoType {
    case repos , gists, followers, following
}


class GFItemInfoView: UIView {
    let symbolImageView = UIImageView()
    let titleLable = GFTitleLabel(textAlignment: .left, fontsize: 20)
    let countLabel = GFTitleLabel(textAlignment: .center, fontsize: 20)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configuer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configuer() {
        addSubview(symbolImageView)
        addSubview(titleLable)
        addSubview(countLabel)
        
        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        symbolImageView.tintColor = .secondaryLabel
        symbolImageView.contentMode = .scaleToFill
        NSLayoutConstraint.activate([
            symbolImageView.topAnchor.constraint(equalTo: self.topAnchor),
            symbolImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            symbolImageView.widthAnchor.constraint(equalToConstant: 20),
            symbolImageView.heightAnchor.constraint(equalToConstant: 20),
            
            titleLable.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor ,constant: 12),
            titleLable.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLable.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
            titleLable.heightAnchor.constraint(equalToConstant: 20),
            
            countLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 18)
            
        ])
    }
 
 
      func set(itemInfoType : ItemInfoType , withCount count: Int){
        countLabel.text = String(count)
        switch itemInfoType {
        case .repos:
            symbolImageView.image = SFSymbols.repos
            titleLable.text       = "Pulic Repos"
        case .gists:
            symbolImageView.image = SFSymbols.gists
            titleLable.text       = "Public Gits"

        case .followers:
            symbolImageView.image = SFSymbols.followers
            titleLable.text       = "Followers"

        case .following:
            symbolImageView.image =  SFSymbols.following
            titleLable.text       = "Following"
        }
    }
}
