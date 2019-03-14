//
//  Alert.swift
//  Drinks
//
//  Created by Andrea Agudo on 13/03/2019.
//  Copyright © 2019 aagudo. All rights reserved.
//

import UIKit

protocol Alerter: class {
    func alert(title: String, message: String, handler: ((UIAlertAction) -> Void)?)
}

extension UIViewController: Alerter {
    func alert(with customActions: [UIAlertAction], title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        customActions.forEach {( alert.addAction($0) )}
        present(alert, animated: true, completion: nil)
    }

    func alert(title: String, message: String, handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: handler))
        present(alert, animated: true, completion: nil)
    }
}

struct Alert {
    let title: String
    let message: String
    var actions: [UIAlertAction] = []

    init(title: String, message: String) {
        self.title = title
        self.message = message
    }

    init(key: String) {
        self.init(
            title: localized("\(key).title"),
            message: localized("\(key).message")
        )
    }

    func present(handler: ((UIAlertAction) -> Void)? = nil) {
        func present() {
            let window = UIWindow.topWindow
            window.windowLevel = UIWindow.Level.alert + 1

            if actions.isEmpty {
                window.rootViewController?.alert(title: title, message: message, handler: handler)
            } else {
                window.rootViewController?.alert(with: actions, title: title, message: message)
            }
        }

        if Thread.isMainThread {
            present()
        } else {
            DispatchQueue.main.async(execute: present)
        }
    }
}

extension Alert {
    static var defaultError: Alert {
        return Alert(key: "default_error")
    }
}
