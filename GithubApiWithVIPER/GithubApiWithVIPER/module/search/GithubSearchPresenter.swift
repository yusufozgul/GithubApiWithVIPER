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
}

class GithubSearchPresenter {
    weak var view: GithubSearchViewInterface?
    private let interactor: GithubSearchInteractorInterface
    private let router: GithubSearchRouterInterface
    
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
}

extension GithubSearchPresenter: GithubSearchInteractorOutput {
    func handleSearchResult(with result: SearchResult) {
        switch result {
        case .success(let response):
            //TODO: Gelen response işlendikten sonra UI'a gönderilecek
            break
        case .failure(_):
            break
        }
    }
}
