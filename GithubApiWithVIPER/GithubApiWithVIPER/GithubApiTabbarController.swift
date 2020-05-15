//
//  GithubApiTabbarController.swift
//  GithubApiWithVIPER
//
//  Created by Yusuf Özgül on 15.05.2020.
//  Copyright © 2020 Yusuf Özgül. All rights reserved.
//

import UIKit

class GithubApiTabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        loadSearchPage()
    }
    
    private func loadSearchPage() {
        
        let navigationController = UINavigationController()
        let githubSearchViewController = GithubSearchRouter.createModule(navigationController: navigationController)
        navigationController.viewControllers = [githubSearchViewController]

        self.addChild(navigationController)
        
        navigationController.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        navigationController.tabBarItem.title = "Search"
        
    }

}
