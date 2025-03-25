//
//  FollowerCell.swift
//  GitFollowers
//
//  Created by Ahmed El Gndy on 25/03/2025.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    private let avaterImageView = GFAvatarImageView(frame: .zero)
    private let usernameLabel   = GFTitleLabel(textAlignment: .center, fontsize: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(follower: Follower){
        usernameLabel.text = follower.login
    }
    private func configure() {
        addSubview(avaterImageView)
        addSubview(usernameLabel)
        
        let padding: CGFloat = 8
        //all the cell have a contenView
        NSLayoutConstraint.activate([
            avaterImageView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: padding),
            avaterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            avaterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            avaterImageView.heightAnchor.constraint(equalTo: avaterImageView.widthAnchor),
            
            usernameLabel.topAnchor.constraint(equalTo: avaterImageView.bottomAnchor, constant: 12),
            usernameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor , constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 12)
        ])
    }

}
