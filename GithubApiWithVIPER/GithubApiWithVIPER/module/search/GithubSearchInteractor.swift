//
//  GithubSearchInteractor.swift
//  GithubApiWithVIPER
//
//  Created by Ahmet Keskin on 9.05.2020.
//  Copyright © 2020 Yusuf Özgül. All rights reserved.
//

import Foundation

protocol GithubSearchInteractorInterface: class {
    func search(with text: String)
}

protocol GithubSearchInteractorOutput: class {
    func handleSearchResult(with result: Result<SearchApiResponse, GithubApiError>)
}

class GithubSearchInteractor {
    weak var output: GithubSearchInteractorOutput?
}

extension GithubSearchInteractor: GithubSearchInteractorInterface {
    func search(with text: String) {
        let service = ApiService<SearchApiResponse>()
        
        var request = SearchRepoRequest()
        request.generateUrl(keyword: text)
        
        service.getData(request: request) { (result) in
            switch result {
            case .success(let response):
                self.output?.handleSearchResult(with: .success(response))
            case .failure(let error):
                self.output?.handleSearchResult(with: .failure(error))
            }
        }
    }
}
