//
//  UITableView+EXT.swift
//  GitFollowers
//
//  Created by Ahmed El Gndy on 08/04/2025.
//

import UIKit

extension UITableView {
    
    func reloadDataOnMainThread() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
    func removeExcessCells() {
        tableFooterView = UIView(frame: .zero)
        separatorStyle = .none
    }
}

