//
//  GitHubUserDetailViewController.swift
//  GitHubUserList
//
//  Created by Irvin Liao on 2023/3/12.
//

import UIKit
import Kingfisher

class GitHubUserDetailViewController: BaseViewController {
    
    @IBOutlet weak var avatarIV: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var badge: UIView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var linkLabel: UILabel!
    
    var vm: GitHubUserDetailViewModel
    
    // MARK: - Initialization
    
    init?(coder: NSCoder, viewModel: GitHubUserDetailViewModel) {
        self.vm = viewModel
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        avatarIV.rounded()
    }
    
    // MARK: - UI Setup
    
    func setupUI() {
        avatarIV.kf.setImage(with: URL(string: vm.user.avatarURL))
        nameLabel.text = vm.user.login
        loginLabel.text = vm.user.login
        badge.isHidden = vm.user.login.count > 5
        locationLabel.text = vm.user.nodeID
        linkLabel.text = vm.user.url
    }
    
    // MARK: - IBActions
    
    @IBAction func tapClose() {
        dismiss(animated: true)
    }
}
