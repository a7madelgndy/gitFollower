//
//  UIViewController+Ext.swift
//  GitFollowers
//
//  Created by Ahmed El Gndy on 25/03/2025.
//

import UIKit
fileprivate var ContainerView : UIView!
extension UIViewController {
    func presentGFAlerONMainThread(title: String, message: String , buttonTile : String) {
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(title: title , message: message , buttonTile: buttonTile)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC , animated: true)
        }
    }
    
    func showLoadingView() {
        ContainerView  = UIView(frame: view.bounds)
        view.addSubview(ContainerView)
        
        ContainerView.backgroundColor = .systemBackground
        ContainerView.alpha = 0
        UIView.animate(withDuration: 0.3) {ContainerView.alpha = 0.8  }

        let activiyIndicator = UIActivityIndicatorView(style: .large)
        ContainerView.addSubview(activiyIndicator)
        activiyIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activiyIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activiyIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        activiyIndicator.startAnimating()
    }
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            ContainerView.removeFromSuperview()
            ContainerView = nil
        }

    }
}
