//
//  UIView+EXT.swift
//  GitFollowers
//
//  Created by Ahmed El Gndy on 08/04/2025.
//

import UIKit


extension UIView {
    func addSubViews( _ Views :UIView...) {
        for view in Views {addSubview(view)}
    }
}

