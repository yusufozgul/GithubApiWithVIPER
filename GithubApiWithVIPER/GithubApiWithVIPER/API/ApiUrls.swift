//
//  ApiUrls.swift
//  GithubApiWithVIPER
//
//  Created by Yusuf Özgül on 15.05.2020.
//  Copyright © 2020 Yusuf Özgül. All rights reserved.
//

import Foundation

struct Constant {
    static let baseUrl = "https://api.github.com/"
}

protocol ApiRequestProtocol {
    var method: HttpMethod { get }
    var url: URL { get }
    var body: Encodable? { get }
}

struct SearchRepoRequest: ApiRequestProtocol {
    var url: URL
    var method: HttpMethod = .GET
    var body: Encodable? = nil
    
    init(keyword: String) throws {
        if let searchUrl = URL(string:  Constant.baseUrl + "search/repositories?q=\(keyword)") {
            self.url = searchUrl
        } else {
            throw GithubApiError.urlEncode
        }
    }
}

struct RepoDetailRequest: ApiRequestProtocol {
    var method: HttpMethod = .GET
    var url: URL
    var body: Encodable? = nil
    
    init(keyword: String) throws {
        if let searchUrl = URL(string:  Constant.baseUrl + "repos/\(keyword)") {
            self.url = searchUrl
        } else {
            throw GithubApiError.urlEncode
        }
    }
}

struct RepoMDFileRequest: ApiRequestProtocol {
    var method: HttpMethod = .GET
    var url: URL
    var body: Encodable? = nil
    
    init(keyword: String) throws {
        if let searchUrl = URL(string:  "https://raw.githubusercontent.com/" + (keyword) + "/README.md") {
            self.url = searchUrl
        } else {
            throw GithubApiError.urlEncode
        }
    }
}
