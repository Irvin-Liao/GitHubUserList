//
//  AppDelegate.swift
//  GitHubUserList
//
//  Created by Irvin Liao on 2023/3/12.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "GitHubUserListViewController") as! GitHubUserListViewController
        let nav = UINavigationController(rootViewController: vc)
        window?.rootViewController = nav
        return true
    }
}
