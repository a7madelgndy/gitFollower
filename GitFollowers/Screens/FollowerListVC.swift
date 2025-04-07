//
//  FollowerListVC.swift
//  GitFollowers
//
//  Created by Ahmed El Gndy on 25/03/2025.
//

import UIKit

protocol FollowerListDelegate: AnyObject {
    func didFollowertapped(with userusername : String)
}

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
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
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
                if followers.count < 10 {
                    hasMoreFollowers = false
                }
                self.followers += followers
                
                if followers.isEmpty {
                    hasMoreFollowers = false
                    let massage = "This user has no Followers , go follow them 😃"
                    DispatchQueue.main.async{
                        self.showEmptyStateView(with: massage, in: self.view)
                    }
                    return
                }
                self.updataData(on: self.followers)
                
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
  //MARK: Selectors
    @objc func addButtonTapped() {
        NetWorkManager.shared.getUser(for: username) { [weak self] result in
            guard let self = self else {return}
            
            switch result {
            case .success(let user):
                let follower = Follower(login: user.login, avatarUrl: user.avatar_url)
                
                PresistenceManager.updateWith(follower: follower, actionType: .add) { [weak self] error in
                    guard let self = self else {return}

                    guard let error = error else {
                        self.presentGFAlerONMainThread(title: "Success! ", message: "you have Successfuly add this user to the favoite list 😁", buttonTile: "Horray🎉")
                        return
                    }
                    self.presentGFAlerONMainThread(title:  "some thing Went Wrong", message: error.rawValue, buttonTile: "okay")
                }
                break
            case .failure(let error):
                self.presentGFAlerONMainThread(title: "some thing Went Wrong", message: error.rawValue, buttonTile: "ok")
                break
            }
        }
    }
}


//MARK: Extension
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
        userInfoVc.delegate = self 
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

extension FollowerListVC : FollowerListDelegate {
    
    func didFollowertapped(with username: String) {
        self.username = username
        self.title = username
        guard  hasMoreFollowers else  {return}
        page = 1
        followers.removeAll()
        filtedFollowers.removeAll()
        collectionView.setContentOffset(.zero, animated: true)
        getFollowers(username: username, page: page)
    }
    
    
}
