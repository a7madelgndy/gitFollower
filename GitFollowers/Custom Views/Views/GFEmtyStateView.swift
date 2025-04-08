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
    
    convenience init(massage: String) {
        self.init(frame: .zero)
        massageLabel.text = massage
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        configureMessageLabel()
        configureLogoImage()
    }
    
    private func configureMessageLabel() {
        
        addSubview(massageLabel)
        
        massageLabel.numberOfLines = 3
        massageLabel.textColor = .secondaryLabel
        
        let isSmallScreenDevice =  DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed || DeviceTypes.isiPhoneSE2ndAnd3rdGen
        let labelYOffset: CGFloat = isSmallScreenDevice ? -80 : -150
        
        NSLayoutConstraint.activate([
             massageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor ,constant: labelYOffset),
             massageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
             massageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
             massageLabel.heightAnchor.constraint(equalToConstant:  200),
        ])
    }
    
    private func configureLogoImage() {
        
        addSubview(logoImageView)

        logoImageView.image = Images.emptyStateLogo
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
 
        NSLayoutConstraint.activate(
            [
             logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier:   1.3),
             logoImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
             logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor , constant : 170),
             logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 120)
            
            ]
        )
    }
    
}
