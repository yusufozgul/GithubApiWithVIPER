//
//  ApiExtensions.swift
//  GithubApiWithVIPER
//
//  Created by Yusuf Özgül on 15.05.2020.
//  Copyright © 2020 Yusuf Özgül. All rights reserved.
//

import Foundation

struct GithubApiError: Error {

    var errorDescription: String? { return _description }
    var failureReason: String? { return _description }

    private var _description: String

    init(description: String) {
        self._description = description
    }
}

enum HttpMethod: String {
    case GET
    case POST
}
