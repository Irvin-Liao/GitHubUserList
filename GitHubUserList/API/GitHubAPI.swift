//
//  GitHubAPI.swift
//  GitHubUserList
//
//  Created by Irvin Liao on 2023/3/12.
//

import Foundation
import Moya

enum GitHubAPI {
    case users(since: Int, perPage: Int)
    case user(username: String)
}

extension GitHubAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
    
    var path: String {
        switch self {
        case .users:
            return "/users"
            
        case .user(let username):
            return "/users/\(username)"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        switch self {
        case .users(let since, let perPage):
            return .requestParameters(
                parameters: ["since": since,
                             "per_page": perPage],
                encoding: URLEncoding.queryString)
            
        case .user:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
