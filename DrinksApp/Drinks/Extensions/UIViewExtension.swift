//
//  UIViewExtension.swift
//  Drinks
//
//  Created by Andrea Agudo on 11/03/2019.
//  Copyright © 2019 aagudo. All rights reserved.
//

import UIKit

extension UIView {
    func pinEdgesToSuperView() {
        guard let superView = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
        leftAnchor.constraint(equalTo: superView.leftAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
        rightAnchor.constraint(equalTo: superView.rightAnchor).isActive = true
    }

    func setCustomizedShadow(opacity: Float = 0.2, shadowRadius: CGFloat = 2, cornerRadius: CGFloat = 10) {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOffset = CGSize.zero
        self.layer.cornerRadius = cornerRadius
    }
}
