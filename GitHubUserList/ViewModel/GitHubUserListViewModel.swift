//
//  GitHubUserListViewModel.swift
//  GitHubUserList
//
//  Created by Irvin Liao on 2023/3/12.
//

import Foundation
import Moya

class GitHubUserListViewModel: NSObject {
    
    @Published var isLoading = false
    var didFinishRequest: (() -> Void)?
    var users = [GitHubUser]()
    let pageSize = 20
    let limit = 100
    var since = 0
    
    func requestUsers() {
        guard !isLoading else { return }
        
        // list limit
        guard users.count < 100 else { return }
        
        // paging
        if let last = users.last {
            since = last.id
        }
        
        isLoading = true
        API.request([GitHubUser].self, target: .users(since: since, perPage: pageSize)) { codable, error in
            if let error = error {
                Alert.show(error: error)
            }
            else if let users = codable {
                self.users.append(contentsOf: users)
            }
            self.isLoading = false
            self.didFinishRequest?()
        }
    }
}
