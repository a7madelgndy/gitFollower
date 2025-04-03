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
    let SymbolImageView = UIImageView()
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
        addSubview(SymbolImageView)
        addSubview(titleLable)
        addSubview(countLabel)
        
        SymbolImageView.translatesAutoresizingMaskIntoConstraints = false
        SymbolImageView.tintColor = .secondaryLabel
        SymbolImageView.contentMode = .scaleAspectFit
        NSLayoutConstraint.activate([
            SymbolImageView.topAnchor.constraint(equalTo: topAnchor),
            SymbolImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            SymbolImageView.widthAnchor.constraint(equalToConstant: 20),
            SymbolImageView.heightAnchor.constraint(equalToConstant: 20),
            
            titleLable.leadingAnchor.constraint(equalTo: SymbolImageView.trailingAnchor ,constant: 12),
            titleLable.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLable.centerYAnchor.constraint(equalTo: SymbolImageView.centerYAnchor),
            titleLable.heightAnchor.constraint(equalToConstant: 80),
            
            countLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            countLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 18)
            
        ])
    }
 
 
    private func setSymbolImageView(itemInfoType : ItemInfoType , withCount count: Int){
        countLabel.text = String(count)
        switch itemInfoType {
        case .repos:
            SymbolImageView.image = UIImage(systemName: SFSymbols.repos)
            titleLable.text = "Pulic Repos"
        case .gists:
            SymbolImageView.image = UIImage(systemName: SFSymbols.gists)
            titleLable.text = "Public Gits"

        case .followers:
            SymbolImageView.image = UIImage(systemName: SFSymbols.followers)
            titleLable.text = "Followers"

        case .following:
            SymbolImageView.image = UIImage(systemName: SFSymbols.following)
            titleLable.text = "Following"
        }
    }
}
