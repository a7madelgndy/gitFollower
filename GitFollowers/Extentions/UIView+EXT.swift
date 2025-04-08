//
//  UIView+EXT.swift
//  GitFollowers
//
//  Created by Ahmed El Gndy on 08/04/2025.
//

import UIKit


extension UIView {
    func pinToEdges (of SuperView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: SuperView.topAnchor),
            leadingAnchor.constraint(equalTo: SuperView.leadingAnchor),
            trailingAnchor.constraint(equalTo: SuperView.trailingAnchor),
            bottomAnchor.constraint(equalTo: SuperView.bottomAnchor),])
    }
    func addSubViews( _ Views :UIView...) {
        for view in Views {addSubview(view)}
    }
}

