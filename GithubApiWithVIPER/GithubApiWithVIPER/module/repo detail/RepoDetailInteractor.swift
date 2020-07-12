//
//  RepoDetailInteractor.swift
//  GithubApiWithVIPER
//
//  Created by Yusuf Özgül on 12.07.2020.
//  Copyright © 2020 Yusuf Özgül. All rights reserved.
//

import Foundation

protocol RepoDetailInteractorInterface: class {
    func fetch(to repoName: String)
    func loadMDFile(path: String)
}

protocol RepoDetailInteractorOutput: class {
    func handleResult(with result: Result<Repo, GithubApiError>)
    func handleMarkdDownData(md: Result<Data, GithubApiError>)
}

class RepoDetailInteractor {
    weak var output: RepoDetailInteractorOutput?
}

extension RepoDetailInteractor: RepoDetailInteractorInterface {
    
    func fetch(to repoName: String) {
        let service = ApiService<Repo>()
        var request = RepoDetailRequest()
        request.generateUrl(keyword: repoName)
        
        service.getData(request: request) { (result) in
            self.output?.handleResult(with: result)
        }
    }
    
    func loadMDFile(path: String) {
        let service = RawDataService()
        var request = RepoMDFileRequest()
        request.generateUrl(keyword: path)
        service.getRawData(request: request) { (result) in
            self.output?.handleMarkdDownData(md: result)
        }
    }
}
