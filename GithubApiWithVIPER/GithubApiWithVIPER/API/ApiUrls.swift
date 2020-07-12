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
    var url: URL! { get }
    var body: Encodable? { get }
}

struct SearchRepoRequest: ApiRequestProtocol {
    
    var url: URL!
    var method: HttpMethod = .GET
    var body: Encodable? = nil
    
    mutating func generateUrl(keyword: String?) {
        if let searchUrl = URL(string:  Constant.baseUrl + "search/repositories?q=\(keyword ?? "")") {
            url = searchUrl
            return
        }
        fatalError("URL not encoded")
    }
}

struct RepoDetailRequest: ApiRequestProtocol {
    var method: HttpMethod = .GET
    var url: URL!
    var body: Encodable? = nil
    
    mutating func generateUrl(keyword: String?) {
        if let searchUrl = URL(string:  Constant.baseUrl + "repos/\(keyword ?? "")") {
            url = searchUrl
            return
        }
        fatalError("URL not encoded")
    }
}

struct RepoMDFileRequest: ApiRequestProtocol {
    var method: HttpMethod = .GET
    var url: URL!
    var body: Encodable? = nil
    
    mutating func generateUrl(keyword: String?) {
        if let searchUrl = URL(string:  "https://raw.githubusercontent.com/" + (keyword ?? "") + "/README.md") {
            url = searchUrl
            return
        }
        fatalError("URL not encoded")
    }
}
