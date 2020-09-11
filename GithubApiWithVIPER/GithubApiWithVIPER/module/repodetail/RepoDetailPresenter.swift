//
//  RepoDetailPresenter.swift
//  GithubApiWithVIPER
//
//  Created by Yusuf Özgül on 12.07.2020.
//  Copyright © 2020 Yusuf Özgül. All rights reserved.
//

import Foundation

protocol RepoDetailPresenterInterface: class {
    
    func viewDidLoad()
}

class RepoDetailPresenter {
    weak var view: RepoDetailViewInterface?
    private let interactor: RepoDetailInteractorInterface
    private let router: RepoDetailRouterInterface
    private let repoName: String
    
    init(view: RepoDetailViewInterface,
         interactor: RepoDetailInteractorInterface,
         router: RepoDetailRouterInterface,
         repoName: String) {
        
        self.view = view
        self.interactor = interactor
        self.router = router
        self.repoName = repoName
    }
}

extension RepoDetailPresenter: RepoDetailPresenterInterface {
    func viewDidLoad() {
        self.interactor.fetch(to: repoName)
        self.view?.setLoading(to: true)
    }
}

extension RepoDetailPresenter: RepoDetailInteractorOutput {
    func handleResult(with result: Result<Repo, GithubApiError>) {
        switch result {
        case .success(let repo):
            view?.showRepoDetail(with: repo)
            self.interactor.loadMDFile(path: repo.fullName + "/" + repo.defaultBranch)
        case .failure(let error):
            view?.showError(with: error.localizedDescription)
        }
    }
    
    func handleMarkdDownData(md: Result<Data, GithubApiError>) {
        self.view?.setLoading(to: false)
        switch md {
        case .success(let rawMD):
            view?.showMarkDown(md: String(data: rawMD, encoding: .utf8) ?? "")
        case .failure(let error):
            view?.showError(with: error.localizedDescription)
        }
    }
}
