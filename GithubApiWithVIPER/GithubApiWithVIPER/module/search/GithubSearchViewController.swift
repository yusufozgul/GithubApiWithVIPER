//
//  GithubSearchViewController.swift
//  GithubApiWithVIPER
//
//  Created by Ahmet Keskin on 9.05.2020.
//  Copyright © 2020 Yusuf Özgül. All rights reserved.
//

import UIKit

protocol GithubSearchViewInterface: class {
    func prepareUI()
}

class GithubSearchViewController: UIViewController {
    
    @IBOutlet private weak var searchBar: UISearchBar!
    
    var presenter: GithubSearchPresenterInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

extension GithubSearchViewController: GithubSearchViewInterface {
    func prepareUI() {
        searchBar.delegate = self
    }
}

extension GithubSearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.searchBarTextDidChange(text: searchText)
    }
}
