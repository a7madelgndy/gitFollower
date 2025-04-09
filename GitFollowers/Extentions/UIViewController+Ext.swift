//
//  UIViewController+Ext.swift
//  GitFollowers
//
//  Created by Ahmed El Gndy on 25/03/2025.
//

import UIKit
import SafariServices

extension UIViewController {
    
    func presentGFAler(title: String, message: String , buttonTile : String) {
        let alertVC = GFAlertVC(title: title , message: message , buttonTile: buttonTile)
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve
        present(alertVC , animated: true)
    }
    
    func presentDefaultError() {
        let alertVC = GFAlertVC(title: "Something Went Wrong" ,
                                message: "we were Unable to Complete your task at this time , please try again" ,
                                buttonTile: "okay")
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve
        present(alertVC , animated: true)
    }
    
    
    func pressenSafrieVC(with url : URL){
        let safariVc = SFSafariViewController(url: url)
        safariVc.preferredControlTintColor = .systemGreen
        present(safariVc, animated: true)
    }
}
