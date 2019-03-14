//
//  LogoAnimationView.swift
//  Drinks
//
//  Created by Andrea Agudo on 11/03/2019.
//  Copyright © 2019 aagudo. All rights reserved.
//

import UIKit
import SwiftyGif

class LogoAnimationView: UIView {

    let logoGifImageView = UIImageView(gifImage: UIImage(gifName: "drinksGif.gif"), loopCount: 2)

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        backgroundColor = UIColor(white: 246.0 / 255.0, alpha: 1)
        addSubview(logoGifImageView)

        let bounds = UIScreen.main.bounds
        let width = bounds.size.width
        let height = bounds.size.height

        logoGifImageView.translatesAutoresizingMaskIntoConstraints = false
        logoGifImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        logoGifImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        logoGifImageView.widthAnchor.constraint(equalToConstant: width).isActive = true
        logoGifImageView.heightAnchor.constraint(equalToConstant: height).isActive = true
        logoGifImageView.contentMode = .scaleAspectFill
    }
}
