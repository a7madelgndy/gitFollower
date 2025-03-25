//
//  UIViewController+Ext.swift
//  GitFollowers
//
//  Created by Ahmed El Gndy on 25/03/2025.
//

import UIKit

extension UIViewController {
    func presentGFAlerONMainThread(title: String, message: String , buttonTile : String) {
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(title: title , message: message , buttonTile: buttonTile)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC , animated: true)
        }
        
    }
}
