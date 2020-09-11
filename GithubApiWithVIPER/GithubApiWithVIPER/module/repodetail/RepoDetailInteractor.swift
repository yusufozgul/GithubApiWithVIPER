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
        do {
            let service = ApiService<Repo>()
            let request = try RepoDetailRequest(keyword: repoName)
            
            service.getData(request: request) { (result) in
                self.output?.handleResult(with: result)
            }
        } catch {
            self.output?.handleResult(with: .failure(.urlEncode))
        }
    }
    
    func loadMDFile(path: String) {
        do {
            let service = RawDataService()
            let request = try RepoMDFileRequest(keyword: path)
            service.getRawData(request: request) { (result) in
                self.output?.handleMarkdDownData(md: result)
            }
        } catch {
            self.output?.handleResult(with: .failure(.urlEncode))
        }
    }
}
