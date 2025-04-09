//
//  FollowerListVC.swift
//  GitFollowers
//
//  Created by Ahmed El Gndy on 25/03/2025.
//

import UIKit



final class FollowerListVC: GFDataLoadingVc {
    
    enum Section {case main}
    
    private var username: String!
    private var followers: [Follower]       = []
    private var filtedFollowers :[Follower] = []
    private var page : Int                  = 1
    private var hasMoreFollowers            = true
    private var isSearching                 = false
    private var isLoadMoreFollowers         = false
    
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    
    init(username : String){
        super.init(nibName: nil, bundle: nil)
        self.username = username
        title = username
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
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
    
    
    func getFollowers(username : String , page: Int)  {
        showLoadingView()
        isLoadMoreFollowers = true
        Task{
            do {
                let followers = try await NetWorkManager.shared.getFollowers(for: username, page: page)
                udateUI(with: followers)
    
                
            }catch {
                if let gferro = error as? GFError {
                    presentGFAler(title: "Bad stuff happend", message: gferro.rawValue, buttonTile: "ok")
                } else  {
                    presentDefaultError()
                }
            }
        dismissLoadingView()
        isLoadMoreFollowers = false
        }
    }

    func udateUI(with followers: [Follower]){
        if followers.count < Constants.numberOfUsersPerPage {
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
        Task {
            do {
                let user = try await  NetWorkManager.shared.getUser(for:self.username)
                addUserToFavorites(with: user)
            }catch {
                if let error = error as? GFError{
                    presentGFAler(title: "some thing Went Wrong", message: error.rawValue, buttonTile: "ok")
                }else {
                    presentDefaultError()
                }
            }
        }
    }
    
    private func  addUserToFavorites(with user : User) {
        let favorite = Follower(login: user.login, avatar_url: user.avatar_url)
        
        PersistenceManager.updateWith(follower: favorite, actionType: .add) { [weak self] error in
            guard let self = self else {return}

            guard let error = error else {
                self.presentGFAler(title: "Success! ", message: "you have Successfuly add this user to the favoite list 😁", buttonTile: "Horray🎉")
                return
            }
            DispatchQueue.main.async {
                self.presentGFAler(title:  "some thing Went Wrong", message: error.rawValue, buttonTile: "okay")
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
            guard  hasMoreFollowers , !isLoadMoreFollowers else  {return}
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


extension FollowerListVC : UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text ,  !filter.isEmpty else {
            filtedFollowers.removeAll()
            updataData(on: followers)
            isSearching.toggle()
            return}
        
        isSearching.toggle()
        filtedFollowers = followers.filter{$0.login.lowercased().contains(filter.lowercased())}
        updataData(on: filtedFollowers)
    }
    
    

    
}

extension FollowerListVC : FollowerUserInfoVc {
    
    func didFollowertapped(with username: String) {
        self.username = username
        self.title    = username
        page          = 1
        
        guard  hasMoreFollowers else  {return}
        followers.removeAll()
        filtedFollowers.removeAll()
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        getFollowers(username: username, page: page)
    }
    
    
}
