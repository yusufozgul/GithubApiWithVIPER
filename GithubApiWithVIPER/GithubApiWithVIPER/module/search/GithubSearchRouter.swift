//
//  GithubSearchRouter.swift
//  GithubApiWithVIPER
//
//  Created by Ahmet Keskin on 9.05.2020.
//  Copyright © 2020 Yusuf Özgül. All rights reserved.
//

import UIKit

protocol GithubSearchRouterInterface: class {
    func navigateToRepoDetail(to repoName: String)
}

class GithubSearchRouter {
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    static func createModule(navigationController: UINavigationController) -> GithubSearchViewController {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let view = storyBoard.instantiateViewController(identifier: "GithubSearchViewController") as! GithubSearchViewController
        
        let interactor = GithubSearchInteractor()
        let router = GithubSearchRouter(navigationController: navigationController)
        let presenter = GithubSearchPresenter.init(view: view,
                                                   interactor: interactor,
                                                   router: router)
        interactor.output = presenter
        view.presenter = presenter
        
        view.title = "Search"
        
        return view
    }
    
}

extension GithubSearchRouter: GithubSearchRouterInterface {
    func navigateToRepoDetail(to repoName: String) {
        let repoDetailVC = RepoDetailRouter.createModule(repoName: repoName)
        self.navigationController?.pushViewController(repoDetailVC, animated: true)
    }
}
