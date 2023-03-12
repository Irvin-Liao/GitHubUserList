//
//  APIService.swift
//  GitHubUserList
//
//  Created by Irvin Liao on 2023/3/12.
//

import Foundation
import Moya

let API = APIService.shared

class APIService: NSObject {
    
    static let shared = APIService()
    
    let provider = MoyaProvider<GitHubAPI>()
    
    func request<T: Codable>(_ codable: T.Type, target: GitHubAPI, completion: @escaping ((T?, Error?) -> Void)) {
        provider.request(target) { result in
            switch result {
            case .success(let response):
                do {
                    let model = try JSONDecoder().decode(codable, from: response.data)
                    completion(model, nil)
                } catch let err {
                    completion(nil, err)
                }
                
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
