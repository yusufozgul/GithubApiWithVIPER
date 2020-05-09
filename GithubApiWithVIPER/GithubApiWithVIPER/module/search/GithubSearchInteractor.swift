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

typealias SearchResult = Result<Codable, Error>

protocol GithubSearchInteractorOutput: class {
    func handleSearchResult(with result: SearchResult)
}

class GithubSearchInteractor {
    weak var output: GithubSearchInteractorOutput?
}

extension GithubSearchInteractor: GithubSearchInteractorInterface {
    func search(with text: String) {
       //TODO: Network isteği atılıp gelen data handleSearchResult ile presenter'a paslanacak
    }
}
