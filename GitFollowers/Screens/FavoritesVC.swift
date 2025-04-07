//
//  FavoritesVC.swift
//  GitFollowers
//
//  Created by Ahmed El Gndy on 24/03/2025.
//

import UIKit

class FavoritesVC: UIViewController {
    private var tableView = UITableView()
    private var favorits:[Follower] =  []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureControllerView ()
        configureTableView()
        tableView.backgroundColor = .systemPink
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorites()
    }
    
    private func configureControllerView () {
        view.backgroundColor = .systemBackground
        title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureTableView() {
        tableView.delegate  = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        tableView.rowHeight = 100
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
             tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
             tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
             tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
             tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
         ])

        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseIdentifier)
    }
    func getFavorites() {
        PresistenceManager.retriveFavorites { [weak self ] resulte in
            guard let self = self else {return}
            switch resulte {
            case .success(let favorites ):
                if favorites.isEmpty {
                    self.showEmptyStateView(with: "No Favorites?\n", in: self.view)
                } else {
                    self.favorits = favorites
                    DispatchQueue.main.async{
                        self.tableView.reloadData()
                    }
                }
               
            case .failure(let error):
                self.presentGFAlerONMainThread(title: "Somthing Went Wrong", message: error.rawValue, buttonTile: "ok")
            }
        }
    }

}

//MARK: Extentions

extension FavoritesVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let  favorite = favorits[indexPath.row]
        let  desVC = FollowerListVC()
        desVC.username = favorite.login
        desVC.title = favorite.login
        navigationController?.pushViewController(desVC, animated: true)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {return}
        let  favorite = favorits[indexPath.row]
        favorits.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
        
        PresistenceManager.updateWith(follower: favorite, actionType: .reomve) { [weak self] error in
            guard let self = self else {return}
            
            guard let error = error else {return}
            
            self.presentGFAlerONMainThread(title: "Unable to remove", message: error.rawValue , buttonTile: "ok")
        }
        
    }
}
extension FavoritesVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {return favorits.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseIdentifier, for: indexPath) as! FavoriteCell
        let favorite = self.favorits[indexPath.row]
        cell.set(favorite: favorite)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
