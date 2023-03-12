//
//  GitHubUserDetailViewModel.swift
//  GitHubUserList
//
//  Created by Irvin Liao on 2023/3/12.
//

import Foundation

class GitHubUserDetailViewModel: NSObject {
    
    var user: GitHubUser
    
    // MARK: - Initialization
    
    init(user: GitHubUser) {
        self.user = user
    }
}
