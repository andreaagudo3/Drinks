//
//  UIWindow.swift
//  Drinks
//
//  Created by Andrea Agudo on 13/03/2019.
//  Copyright © 2019 aagudo. All rights reserved.
//

import UIKit

extension UIWindow {
    static var topWindow: UIWindow {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UIViewController()
        window.windowLevel = UIWindow.Level.normal
        window.makeKeyAndVisible()
        return window
    }
}
