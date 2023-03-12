//
//  AlertManager.swift
//  GitHubUserList
//
//  Created by Irvin Liao on 2023/3/12.
//

import Foundation
import UIKit

let Alert = AlertManager.shared

class AlertManager: NSObject {
    
    static let shared = AlertManager()
    
    func topVC() -> UIViewController {
        if let keyWindow = UIApplication.shared.connectedScenes
            .filter({ $0.activationState == .foregroundActive })
            .compactMap({ $0 as? UIWindowScene })
            .first?
            .windows
            .filter({ $0.isKeyWindow })
            .first,
           let rootVC = keyWindow.rootViewController {
            return rootVC
        } else {
            return UIViewController()
        }
    }
    
    func show(title: String?, message: String?) {
        let ok = UIAlertAction(title: "OK", style: .default)
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(ok)
        topVC().present(alert, animated: true)
    }
    
    func show(error: Error) {
        let ok = UIAlertAction(title: "OK", style: .default)
        let alert = UIAlertController(title: "Notice", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(ok)
        topVC().present(alert, animated: true)
    }
}
