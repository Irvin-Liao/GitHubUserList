//
//  GitHubUserListViewController.swift
//  GitHubUserList
//
//  Created by Irvin Liao on 2023/3/12.
//

import UIKit
import Combine
import Kingfisher

class GitHubUserListViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var vm = GitHubUserListViewModel()
    private var subscribers: [AnyCancellable] = []
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBinding()
        requestUsers()
    }
    
    // MARK: - UI Setup
    
    func setupUI() {
        title = "GitHub Users"
    }
    
    // MARK: - Binding
    
    func setupBinding() {
        vm.$isLoading.sink { isLoading in
            if isLoading {
                self.showHUD()
            } else {
                self.hideHUD()
            }
        }.store(in: &subscribers)
        
        vm.didFinishRequest = {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - API
    
    func requestUsers() {
        vm.requestUsers()
    }
}

// MARK: - UITableViewDataSource

extension GitHubUserListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GitHubUserListCell", for: indexPath) as? GitHubUserListCell else {
            return UITableViewCell()
        }
        cell.populateUser(vm.users[indexPath.row], at: indexPath)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension GitHubUserListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = GitHubUserDetailViewModel(user: vm.users[indexPath.row])
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "GitHubUserDetailViewController") { coder in
            GitHubUserDetailViewController(coder: coder, viewModel: viewModel)
        }
        present(vc, animated: true)
    }
}

// MARK: - UITableViewCell

class GitHubUserListCell: UITableViewCell {
    @IBOutlet weak var roundBg: UIView!
    @IBOutlet weak var avatarIV: UIImageView!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var badge: UIView!
    @IBOutlet weak var numberOfItemLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        roundBg.dropShadow(alpha: 0.15, x: 0, y: 2, blur: 4, spread: 0)
        avatarIV.rounded()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarIV.image = nil
    }
    
    func populateUser(_ user: GitHubUser, at indexPath: IndexPath) {
        avatarIV.kf.setImage(with: URL(string: user.avatarURL))
        loginLabel.text = user.login
        badge.isHidden = user.login.count > 5
        numberOfItemLabel.text = "\(indexPath.row + 1)"
    }
}

extension GitHubUserListViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.height {
            guard !vm.isLoading else { return }
            requestUsers()
        }
    }
}
