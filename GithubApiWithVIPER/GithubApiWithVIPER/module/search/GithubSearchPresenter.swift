//
//  GithubSearchPresenter.swift
//  GithubApiWithVIPER
//
//  Created by Ahmet Keskin on 9.05.2020.
//  Copyright © 2020 Yusuf Özgül. All rights reserved.
//

import Foundation

protocol GithubSearchPresenterInterface: class {
    func viewDidLoad()
    func searchBarTextDidChange(text: String)
    func selectRepo(at indexPath: IndexPath)
}

class GithubSearchPresenter {
    weak var view: GithubSearchViewInterface?
    private let interactor: GithubSearchInteractorInterface
    private let router: GithubSearchRouterInterface
    private var searchRepoResult: [SearchResultData] = []
    
    init(view: GithubSearchViewInterface, interactor: GithubSearchInteractorInterface, router: GithubSearchRouterInterface) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
}

extension GithubSearchPresenter: GithubSearchPresenterInterface {
    func viewDidLoad() {
        view?.prepareUI()
    }
    
    func searchBarTextDidChange(text: String) {
        interactor.search(with: text)
    }
    
    func selectRepo(at indexPath: IndexPath) {
        let repo = searchRepoResult[indexPath.row]
        self.router.navigateToRepoDetail(to: repo.fullName)
    }
}

extension GithubSearchPresenter: GithubSearchInteractorOutput {
    func handleSearchResult(with result: Result<SearchApiResponse, GithubApiError>) {
        switch result {
        case .success(let response):
            searchRepoResult = response.items.map({ SearchResultDataBuilder.make(with: $0)})
            var snapshot = SearchRepoSnapshot()
            snapshot.appendSections([.repo])
            snapshot.appendItems(searchRepoResult, toSection: .repo)
            
            view?.showData(with: snapshot)
        case .failure(let error):
            view?.showError(with: error.localizedDescription)
        }
    }
}

class SearchResultDataBuilder {
    class func make(with repo: Repo) -> SearchResultData {
        return SearchResultData(id: UUID().uuidString,
                                name: repo.name,
                                starCount: repo.stargazersCount,
                                watchCount: repo.watchers,
                                language: repo.language,
                                ownerAvatarUrl: repo.owner.avatarUrl,
                                ownerUserName: repo.owner.login,
                                fullName: repo.fullName)
    }
}
