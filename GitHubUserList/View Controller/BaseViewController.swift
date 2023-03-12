//
//  BaseViewController.swift
//  GitHubUserList
//
//  Created by Irvin Liao on 2023/3/12.
//

import UIKit
import PKHUD

class BaseViewController: UIViewController {
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - HUD
    
    func showHUD() {
        HUD.show(.progress, onView: view)
    }
    
    func hideHUD() {
        HUD.hide()
    }
}
