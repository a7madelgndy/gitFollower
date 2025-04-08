//
//  GFDataLoadingVc.swift
//  GitFollowers
//
//  Created by Ahmed El Gndy on 08/04/2025.
//

import UIKit

class GFDataLoadingVc: UIViewController {
    private var ContainerView : UIView!

    func showLoadingView() {

        ContainerView  = UIView(frame: view.bounds)
        view.addSubview(ContainerView)
        
        ContainerView.backgroundColor = .systemBackground
        ContainerView.alpha = 0
        UIView.animate(withDuration: 0.3) {self.ContainerView.alpha = 0.8  }
        
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
            self.ContainerView.removeFromSuperview()
            self.ContainerView = nil
        }
    }
    
    func showEmptyStateView(with massage: String , in view : UIView) {
        DispatchQueue.main.async {
            let emtyStateView = GFEmtyStateView(massage: massage)
            emtyStateView.frame = view.bounds
            view.addSubview(emtyStateView)
        }

    }

}
