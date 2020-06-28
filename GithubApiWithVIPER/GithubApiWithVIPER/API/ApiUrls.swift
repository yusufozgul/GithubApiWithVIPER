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

enum APIRouter {
    case searchRepository(keyword: String)
    
    var url: String {
        switch self {
        case .searchRepository(let keyword):
            return Constant.baseUrl + "search/repositories?q=\(keyword)"
        }
    }
    
    var method: HttpMethod {
        switch self {
        case .searchRepository:
            return .GET
        }
    }
    
}
