//
//  FollowerListVC.swift
//  GitFollowers
//
//  Created by Ahmed El Gndy on 25/03/2025.
//

import UIKit

class FollowerListVC: UIViewController {
    
    
    enum Section {case main}
    
    var username: String!
    var followers: [Follower] = []
    var filtedFollowers :[Follower] = []
    var page : Int = 1
    var hasMoreFollowers = true
    var isSearching = false
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configerControllerView()
        configerSearchController()
        configureCollectionView()
        ConfigureDataSouce()
        getFollowers(username: username, page: page)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    func configerControllerView() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configerSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate   = self
        searchController.searchBar.placeholder = "Search For a username"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view) )
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.id)
    }
    


    func getFollowers(username : String , page: Int) {
        showLoadingView()
        NetWorkManager.shared.getFollowers(for: self.username, page: self.page, completed: { [weak self] result in
            guard let self = self else {return}
            self.dismissLoadingView()
            switch result {
            case .success(let followers):
                if followers.count > 50 {
                    hasMoreFollowers = false
                }
                self.followers.append(contentsOf: followers)
                if followers.isEmpty {
                    let massage = "This user has no Followers , go follow them 😃"
                    DispatchQueue.main.async{
                        self.showEmptyStateView(with: massage, in: self.view)
                    }
                    return
                }
                self.updataData(on: followers)
                
            case .failure(let error):
                self.presentGFAlerONMainThread(title: "Bad stuff happend", message: error.rawValue, buttonTile: "ok")
                
            }
            
        })
    }
    
    func ConfigureDataSouce() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower> (collectionView: collectionView) { collectionView, indexPath, follower in
            let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.id, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        }
    }
    func updataData(on followers:[Follower]){
      var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
      snapshot.appendSections([.main])
      snapshot.appendItems(followers)
      DispatchQueue.main.async {
          self.dataSource.apply(snapshot ,animatingDifferences: true)
        }
    }
}

extension FollowerListVC: UICollectionViewDelegate{
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
     
        if offsetY > contentHight - height {
            guard  hasMoreFollowers else  {return}
            page += 1
            getFollowers(username: username, page: page)
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activArray = isSearching ? filtedFollowers : followers
        let follower = activArray[indexPath.item]
        let userInfoVc = UserInfoVc()
        userInfoVc.username = follower.login
        let navController = UINavigationController(rootViewController: userInfoVc)
        present(navController, animated: true)
    }
}

extension FollowerListVC : UISearchResultsUpdating , UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text ,  !filter.isEmpty else {return}
        isSearching.toggle()
        filtedFollowers = followers.filter{$0.login.lowercased().contains(filter.lowercased())}
        updataData(on: filtedFollowers)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching.toggle()
        updataData(on: followers)
    }
    
}
