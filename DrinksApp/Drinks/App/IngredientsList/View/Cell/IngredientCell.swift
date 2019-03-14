//
//  IngredientCell.swift
//  Drinks
//
//  Created by Andrea Agudo on 13/03/2019.
//  Copyright © 2019 aagudo. All rights reserved.
//

import UIKit

final class IngredientCell: UITableViewCell {

    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var nameLabel: UILabel!

    static let identifier = "ingredientCell"
    static let nibName = "IngredientCell"

    var ingredient: Ingredient? {
        didSet {
            setData()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
    }

    private func configureView() {
        shadowView.setCustomizedShadow()
    }

    private func setData() {
        guard
            let ingredient = ingredient,
            let name = ingredient.strIngredient1 else {
                return
        }
        nameLabel.text = name
    }

}
