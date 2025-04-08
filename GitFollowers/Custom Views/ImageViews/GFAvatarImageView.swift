//
//  GFAvatarImageView.swift
//  GitFollowers
//
//  Created by Ahmed El Gndy on 25/03/2025.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    var cache            = NetWorkManager.shared.cache
    var placeHolderImage = Images.placeHolderImage
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds      =  true
        image              = placeHolderImage
        translatesAutoresizingMaskIntoConstraints = false
    }

}
