//
//  FollowerListVC.swift
//  GitFollowers
//
//  Created by Ahmed El Gndy on 25/03/2025.
//

import UIKit

class FollowerListVC: UIViewController {
    
    
    enum Section {
        case main
    }
    
    var username: String!
    var followers: [Follower] = []
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configerControllerView()
        configureCollectionView()
        ConfigureDataSouce()
        getFollowers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createThreeColumnFlowLayout() )
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.id)
    }
    
    func createThreeColumnFlowLayout() -> UICollectionViewFlowLayout {
        let width  = view.bounds.width
        let padding: CGFloat = 12
        let minimumItemSpacing: CGFloat = 10
        let availbleWidth = width - ((padding*2) + (minimumItemSpacing*2))
        let itemWidth  = availbleWidth/3
        
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowlayout.itemSize  = CGSize(width: itemWidth, height: itemWidth+40 )
        
        return flowlayout
    }
    
    func configerControllerView() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    func getFollowers() {
        NetWorkManager.shared.getFollowers(for: username, page: 1, completed: { result in
            switch result {
                
            case .success(let followers):
                self.followers  = followers
                self.updataData()
                
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
    func updataData(){
      var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
      snapshot.appendSections([.main])
      snapshot.appendItems(followers)
      DispatchQueue.main.async {
          self.dataSource.apply(snapshot ,animatingDifferences: true)
        }
    }
}
