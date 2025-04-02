//
//  GFEmtyStateView.swift
//  GitFollowers
//
//  Created by Ahmed El Gndy on 02/04/2025.
//

import UIKit

class GFEmtyStateView: UIView {
    private var massageLabel = GFTitleLabel(textAlignment: .center, fontsize: 28)
    private var logoImageView = UIImageView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    init(massage: String) {
        super.init(frame: .zero)
        massageLabel.text = massage
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(massageLabel)
        addSubview(logoImageView)
        
        massageLabel.numberOfLines = 3
        massageLabel.textColor = .secondaryLabel
        
        logoImageView.image = UIImage(named: "empty-state-logo")
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
 
        NSLayoutConstraint.activate(
            [massageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor ,constant: -144),
             massageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
             massageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
             massageLabel.heightAnchor.constraint(equalToConstant:  200),
             
             logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier:   1),
             logoImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1),
             logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor , constant : 130),
             logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 100)
            
            ]
        )
    }
}
