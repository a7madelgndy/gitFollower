//
//  FavoriteCellTableViewCell.swift
//  GitFollowers
//
//  Created by Ahmed El Gndy on 07/04/2025.
//

import UIKit

class FavoriteCellTableViewCell: UITableViewCell {
    static let reuseIdentifier = "favoriteCell"
    private let avaterImageView = GFAvatarImageView(frame: .zero)
    private let usernameLabel   = GFTitleLabel(textAlignment: .left, fontsize: 28)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(follower: Follower){
        usernameLabel.text = follower.login
        avaterImageView.downloadImage(from: follower.avatarUrl)
    }
    
    private func configure() {
        addSubview(avaterImageView)
        addSubview(usernameLabel)
        
        accessoryType = .disclosureIndicator
    
        let padding: CGFloat = 12
        
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            avaterImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avaterImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant:  padding),
            avaterImageView.widthAnchor.constraint(equalToConstant: 80),
            avaterImageView.widthAnchor.constraint(equalToConstant: 80),
            
            usernameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avaterImageView.leadingAnchor.constraint(equalTo: avaterImageView.leadingAnchor, constant: padding),
            avaterImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor , constant: -padding),
            avaterImageView.heightAnchor.constraint(equalToConstant: 40)
            
        ])
    }
}
