//
//  GfButton.swift
//  GitFollowers
//
//  Created by Ahmed El Gndy on 24/03/2025.
//

import UIKit

final class GfButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(color : UIColor, title: String,  systemNameImage: String){
        self.init(frame: .zero)
        self.set(color: color, title: title,  systemNameImage: systemNameImage )
    }
    
    
    private func configure() {
        configuration =  .tinted()
        configuration?.cornerStyle = .capsule
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func set(color : UIColor , title: String, systemNameImage: String) {
        configuration?.baseBackgroundColor = color
        configuration?.baseForegroundColor = color
        configuration?.title = title
        
        configuration?.image = UIImage(systemName: systemNameImage)
        configuration?.imagePadding = 6
        configuration?.imagePlacement = .leading
        
    }
}

#Preview {
    let but = GfButton(color: .systemBlue, title: "hi", systemNameImage: "person")
    return but
}
