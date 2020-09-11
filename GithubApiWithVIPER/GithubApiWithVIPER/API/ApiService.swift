//
//  ApiService.swift
//  GithubApiWithVIPER
//
//  Created by Yusuf Özgül on 15.05.2020.
//  Copyright © 2020 Yusuf Özgül. All rights reserved.
//

import Foundation

class ApiService<T: Codable> {
    
    func getData(request: ApiRequestProtocol, completion: @escaping (Result<T, GithubApiError>) -> Void) {
        
        var urlRequest = URLRequest(url: request.url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.body?.toJSONData()
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else {
                completion(.failure(.network(errorMessage: error?.localizedDescription ?? "unexpected error")))
                return
            }
            if let data = data {
                completion(self.parseData(data: data))
            }
            
        }
        task.resume()
    }
    
    private func parseData(data: Data) -> Result<T, GithubApiError> {
        
        do {
            let jsonDecoder = JSONDecoder()
            let result = try jsonDecoder.decode(T.self, from: data)
            return .success(result)
            
        } catch DecodingError.dataCorrupted(let context) {
            return .failure(.decoding(errorMessage: context.debugDescription))
        } catch DecodingError.keyNotFound(let key, let context) {
            return .failure(.decoding(errorMessage: "\(key.stringValue) was not found, \(context.debugDescription)"))
        } catch DecodingError.typeMismatch(let type, let context) {
            return .failure(.decoding(errorMessage: "\(type) was expected, \(context.debugDescription)"))
        } catch DecodingError.valueNotFound(let type, let context) {
            return .failure(.decoding(errorMessage: "no value was found for \(type), \(context.debugDescription)"))
        } catch {
            return .failure(.decoding(errorMessage: "unknown json parse error"))
        }
    }
}

class RawDataService {
    
    func getRawData(request: ApiRequestProtocol, completion: @escaping (Result<Data, GithubApiError>) -> Void) {
        
        var urlRequest = URLRequest(url: request.url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.body?.toJSONData()
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil || data != nil else {
                completion(.failure(.network(errorMessage: error?.localizedDescription ?? "unexpected error")))
                return
            }
            
            completion(.success(data!))
        }
        task.resume()
    }
}
