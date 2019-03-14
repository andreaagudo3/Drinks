//
//  DrinkCell.swift
//  Drinks
//
//  Created by Andrea Agudo on 13/03/2019.
//  Copyright © 2019 aagudo. All rights reserved.
//

import UIKit
import Nuke

final class DrinkCell: UITableViewCell {

    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var drinkImageView: UIImageView!

    static let identifier = "drinkCell"
    static let nibName = "DrinkCell"

    var drink: Drink? {
        didSet {
            setData()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    private func configureView() {
        shadowView.setCustomizedShadow()
        drinkImageView.layer.cornerRadius = 15
    }

    private func setData() {
        guard let drink = drink else { return}

        if let name = drink.strDrink {
            nameLabel.text = name
        }

        if let imageUrl = drink.strDrinkThumb, let url = URL(string: imageUrl) {
            ImageManager.loadImage(with: url, into: self.drinkImageView)
        } else {
            self.drinkImageView.image = UIImage(named: "drinkPlaceholder")
        }
    }
}
