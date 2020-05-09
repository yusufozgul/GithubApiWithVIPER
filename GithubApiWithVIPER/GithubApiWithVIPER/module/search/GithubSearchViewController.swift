//
//  GithubSearchViewController.swift
//  GithubApiWithVIPER
//
//  Created by Ahmet Keskin on 9.05.2020.
//  Copyright © 2020 Yusuf Özgül. All rights reserved.
//

import UIKit

protocol GithubSearchViewInterface: class {
    
}

class GithubSearchViewController: UIViewController {

    var presenter: GithubSearchPresenterInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
  
}

extension GithubSearchViewController: GithubSearchViewInterface {
    
}
