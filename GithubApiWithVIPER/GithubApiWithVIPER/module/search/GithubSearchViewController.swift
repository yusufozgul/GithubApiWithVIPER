//
//  GithubSearchViewController.swift
//  GithubApiWithVIPER
//
//  Created by Ahmet Keskin on 9.05.2020.
//  Copyright © 2020 Yusuf Özgül. All rights reserved.
//

import UIKit

typealias SearchRepoSnapshot = NSDiffableDataSourceSnapshot<RepoListSection, SearchResultData>

protocol GithubSearchViewInterface: class {
    func prepareUI()
    func showData(with snapshot: SearchRepoSnapshot)
    func showError(with description: String)
}

enum RepoListSection {
    case repo
}

private typealias DataSource = UICollectionViewDiffableDataSource<RepoListSection, SearchResultData>

class GithubSearchViewController: UIViewController {
    @IBOutlet private weak var searchBar: UISearchBar!
    
    var presenter: GithubSearchPresenterInterface!
    var collectionView: UICollectionView!
    private var dataSource: DataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

extension GithubSearchViewController: GithubSearchViewInterface {
    func prepareUI() {
        searchBar.delegate = self
        collectionView = makeCollectionView()
        self.view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
                                     collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
                                     collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 0),
                                     collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
        
        dataSource = makeDatasource()
    }
    
    func showData(with snapshot: SearchRepoSnapshot) {
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func showError(with description: String) {
        let alert = UIAlertController(title: "Error", message: description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension GithubSearchViewController: UICollectionViewDelegate {
    func makeCollectionView() -> UICollectionView {
        let config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        
        let frame = CGRect(x: 0, y: searchBar.frame.maxY, width: view.frame.width, height: view.frame.height - searchBar.frame.maxY)
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.delegate = self
        return collectionView
    }
    
    func makeCell() -> UICollectionView.CellRegistration<UICollectionViewListCell, SearchResultData> {
            UICollectionView.CellRegistration { cell, indexPath, repo in
                var config = cell.defaultContentConfiguration()
                config.text = repo.name
                config.secondaryText = repo.ownerUserName
                cell.contentConfiguration = config

                cell.accessories = [.disclosureIndicator()]
            }
        }
    
    private func makeDatasource() -> DataSource {
        let cell = makeCell()
        return DataSource(collectionView: collectionView) { (collectionView, indexPath, repo) -> UICollectionViewCell? in
            collectionView.dequeueConfiguredReusableCell(using: cell, for: indexPath, item: repo)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        presenter.selectRepo(at: indexPath)
    }
}

extension GithubSearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.searchBarTextDidChange(text: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
}
