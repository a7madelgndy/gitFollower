//
//  FavoriteCell.swift
//  GitFollowers
//
//  Created by Ahmed El Gndy on 07/04/2025.
//

import UIKit

class FavoriteCell: UITableViewCell {
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
    
    func set(favorite: Follower){
        usernameLabel.text = favorite.login
        downloadAvaterimage(form: favorite.avatarUrl)
    }
    
    
    private func downloadAvaterimage(form avatarURl : String) {
        NetWorkManager.shared.downloadImage(from: avatarURl) { [weak self] image in
            guard let image = image else {return}
            DispatchQueue.main.async{
                self?.avaterImageView.image = image
                
            }
        }
    }
    
    
    private func configure() {
        addSubViews(avaterImageView, usernameLabel)

        accessoryType = .disclosureIndicator
    
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            avaterImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avaterImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant:  padding),
            avaterImageView.widthAnchor.constraint(equalToConstant: 80),
            avaterImageView.heightAnchor.constraint(equalToConstant: 80),
            
            usernameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avaterImageView.trailingAnchor, constant: padding),
            usernameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor , constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
