//
//  UIHelper.swift
//  GitFollowers
//
//  Created by Ahmed El Gndy on 27/03/2025.
//

import UIKit

struct UIHelper {
    static func createThreeColumnFlowLayout(in view : UIView) -> UICollectionViewFlowLayout {
        let width  = view.bounds.width
        let padding: CGFloat = 12
        let minimumItemSpacing: CGFloat = 10
        let availbleWidth = width - ((padding*2) + (minimumItemSpacing*2))
        let itemWidth  = availbleWidth/3
        
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowlayout.itemSize  = CGSize(width: itemWidth, height: itemWidth+40 )
        
        return flowlayout
    }
}
