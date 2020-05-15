//
//  ApiService.swift
//  GithubApiWithVIPER
//
//  Created by Yusuf Özgül on 15.05.2020.
//  Copyright © 2020 Yusuf Özgül. All rights reserved.
//

import Foundation

class ApiService<T: Codable> {
    
    func getData(url: ApiUrls, key: String, method: HttpMethod = .GET, completion: @escaping (Result<T, GithubApiError>) -> Void) {
        
        guard let url = URL(string: ApiUrls.baseUrl.rawValue + url.rawValue + key) else {
            completion(.failure(.init(description: "Url not encoded")))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard error == nil && data != nil else {

                completion(.failure(.init(description: error?.localizedDescription ?? "unexpected error")))
                return
            }
            
            completion(self.parseData(data: data!))
        }
    }
    
    private func parseData(data: Data) -> Result<T, GithubApiError> {
        
        do {
            let jsonDecoder = JSONDecoder()
            let result = try jsonDecoder.decode(T.self, from: data)
            return .success(result)
            
        } catch DecodingError.dataCorrupted(let context) {
            return .failure(.init(description: context.debugDescription))
            
        } catch DecodingError.keyNotFound(let key, let context) {
            
            return .failure(.init(description: "\(key.stringValue) was not found, \(context.debugDescription)"))
        } catch DecodingError.typeMismatch(let type, let context) {
            
            return .failure(.init(description: "\(type) was expected, \(context.debugDescription)"))
        } catch DecodingError.valueNotFound(let type, let context) {
            
            return .failure(.init(description: "no value was found for \(type), \(context.debugDescription)"))
        } catch {
            
            return .failure(.init(description: "unknown json parse error"))
        }
    }
}
