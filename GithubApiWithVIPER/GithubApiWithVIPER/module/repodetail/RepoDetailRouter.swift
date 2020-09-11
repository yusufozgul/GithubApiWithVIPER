//
//  RepoDetailRouter.swift
//  GithubApiWithVIPER
//
//  Created by Yusuf Özgül on 12.07.2020.
//  Copyright © 2020 Yusuf Özgül. All rights reserved.
//

import UIKit

protocol RepoDetailRouterInterface: class { }

class RepoDetailRouter: RepoDetailRouterInterface {
    static func createModule(repoName: String) -> RepoDetailVC {
        let storyBoard = UIStoryboard.init(name: "RepoDetails", bundle: nil)
        let view = storyBoard.instantiateViewController(identifier: "RepoDetailVC") as! RepoDetailVC
        
        let interactor = RepoDetailInteractor()
        let router = RepoDetailRouter()
        let presenter = RepoDetailPresenter.init(view: view,
                                                 interactor: interactor,
                                                 router: router,
                                                 repoName: repoName)
        interactor.output = presenter
        view.presenter = presenter
        view.title = repoName
        return view
    }
}
