//
//  ResourceLoader.swift
//  GithubApiWithVIPERTests
//
//  Created by Yusuf Özgül on 19.09.2020.
//  Copyright © 2020 Yusuf Özgül. All rights reserved.
//

import Foundation

class ResourceLoader {
    
    enum Search: String {
        case swift = "MockSearchResponse"
    }
    
    
    func loadSearch(resource: Search) throws -> SearchApiResponse {
        
        let bundle = Bundle.test
        if let path = bundle.path(forResource: resource.rawValue, ofType: "json")
        {
            let jsonData = NSData(contentsOfFile: path)
            let decoder = JSONDecoder()
            let result = try decoder.decode(SearchApiResponse.self, from: jsonData! as Data)
            return result
        }
        fatalError("File not loaded")
    }
}
private extension Bundle {
    class Dummy { }
    static let test = Bundle(for: Dummy.self)
}
