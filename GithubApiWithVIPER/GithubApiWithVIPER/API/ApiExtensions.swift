//
//  ApiExtensions.swift
//  GithubApiWithVIPER
//
//  Created by Yusuf Özgül on 15.05.2020.
//  Copyright © 2020 Yusuf Özgül. All rights reserved.
//

import Foundation

enum GithubApiError: Error {
    case network(errorMessage: String)
    case decoding(errorMessage: String)
    
    var localizedDescription: String {
        switch self {
        case .network(let message):
            return message
        case .decoding(let message):
            return message
        }
    }
}

enum HttpMethod: String {
    case GET
    case POST
}
