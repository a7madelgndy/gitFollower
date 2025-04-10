//
//  FollowerCell.swift
//  GitFollowers
//
//  Created by Ahmed El Gndy on 25/03/2025.
//

import UIKit
import SwiftUI

class FollowerCell: UICollectionViewCell {
    
    static let id               = "FollowerCell"
    
    private var avaterImageView = GFAvatarImageView(frame: .zero)
    private let usernameLabel   = GFTitleLabel(textAlignment: .center, fontsize: 16)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        if #unavailable(iOS 16.0) {
            configure()
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(follower: Follower){
        if #available(iOS 16.0, *) {
            contentConfiguration = UIHostingConfiguration { FollowerView(follower: follower)}
        } else {
            usernameLabel.text = follower.login
            avaterImageView.downloadimage(fromUrl: follower.avatar_url)
            
        }
    }
    
    
    private func configure() {
        addSubViews(avaterImageView, usernameLabel)

        translatesAutoresizingMaskIntoConstraints = false
        let padding: CGFloat = 8
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
