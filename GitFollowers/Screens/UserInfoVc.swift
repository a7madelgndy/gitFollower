//
//  UserInfoVc.swift
//  GitFollowers
//
//  Created by Ahmed El Gndy on 02/04/2025.
//

import UIKit

class UserInfoVc: UIViewController {
    
    let headerView = UIView()
    
    var  username: String?
    var  user: User?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let button = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismisView))
        navigationItem.rightBarButtonItem = button
        
        NetWorkManager.shared.getUser(for: username ?? "caioiglesias") { [weak self] result in
            guard let self = self  else {return}
            switch result {
                
            case .success(let user):
                DispatchQueue.main.async{
                    self.add(childVc: GFUserInfoHeaderVcViewController(user: user), to: self.headerView)}
                
            case .failure(let error):
                self.presentGFAlerONMainThread(title: "something went wrong ", message: error.rawValue, buttonTile: "ok")
                print(error)
            }
        }
        layouUI()
    }
    
    func layouUI() {
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180)
        ])
        
    }
    
    func add(childVc : UIViewController , to containerView : UIView) {
     addChild(childVc)
     containerView.addSubview(childVc.view)
     childVc.view.frame = containerView.bounds
     childVc.didMove(toParent: self)
    }
    
    @objc func dismisView() {
        dismiss(animated: true)
    }


}
