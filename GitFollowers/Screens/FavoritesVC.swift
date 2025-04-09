//
//  FavoritesVC.swift
//  GitFollowers
//
//  Created by Ahmed El Gndy on 24/03/2025.
//

import UIKit

class FavoritesVC: GFDataLoadingVc {
    
    private var tableView           = UITableView()
    private var favorits:[Follower] =  []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureControllerView ()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureTableView()
        getFavorites()
    }
    
    
    override func updateContentUnavailableConfiguration(using state: UIContentUnavailableConfigurationState) {
        if favorits.isEmpty {
            var config = UIContentUnavailableConfiguration.empty()
            config.image = .init(systemName: "heart.fill")
            config.imageProperties.tintColor = .systemRed
            
            config.text = "No Favorites"
            config.secondaryText = "Go Add Some Favorites on The  Follower List Screen"
            config.textProperties.color = .systemRed
            contentUnavailableConfiguration = config
        }else {
            contentUnavailableConfiguration = nil
        }
    }
    
    
    private func configureControllerView () {
        view.backgroundColor = .systemBackground
        title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    private func configureTableView() {
        view.addSubview(tableView)
        
        tableView.frame = view.bounds
        
        tableView.removeExcessCells()
        
        tableView.delegate  = self
        tableView.dataSource = self
        
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseIdentifier)
    }
    
    
    func getFavorites() {
        PersistenceManager.retriveFavorites { [weak self ] resulte in
            guard let self else {return}
            switch resulte {
            case .success(let favorites ):
                self.udateUI(with: favorites)
            case .failure(let error):
                DispatchQueue.main.async{
                    self.presentGFAler(title: "Somthing Went Wrong", message: error.rawValue, buttonTile: "ok")
                }
            }
        }
    }
    
    
    private func udateUI(with favorites : [Follower]){
            self.favorits = favorites
            setNeedsUpdateContentUnavailableConfiguration()
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
        }
       
    }




//MARK: Extentions
extension FavoritesVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let  favorite = favorits[indexPath.row]
        let  desVC = FollowerListVC(username: favorite.login)
        navigationController?.pushViewController(desVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {return}
        
        
        PersistenceManager.updateWith(follower: favorits[indexPath.row], actionType: .reomve) { [weak self] error in
            guard let self else {return}
            guard let error else {
                self.favorits.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
                setNeedsUpdateContentUnavailableConfiguration()
                return
            }
            DispatchQueue.main.async  {
                self.presentGFAler(title: "Unable to remove", message: error.rawValue , buttonTile: "ok")
            }
        }
        
       

        
    }
}
extension FavoritesVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {return favorits.count}
    
    
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


#Preview {
    return FavoritesVC()
}
