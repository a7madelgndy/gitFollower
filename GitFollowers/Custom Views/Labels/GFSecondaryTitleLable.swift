//
//  GFSecondaryTitleLable.swift
//  GitFollowers
//
//  Created by Ahmed El Gndy on 03/04/2025.
//

import UIKit

class GFSecondaryTitleLable: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(fontSize : CGFloat ){
        self.init(frame: .zero)
        self.font = UIFont.systemFont(ofSize: fontSize)
    }
    
    private func configure() {
        textColor = .secondaryLabel
        font = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.75
        lineBreakMode    = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
    

}
