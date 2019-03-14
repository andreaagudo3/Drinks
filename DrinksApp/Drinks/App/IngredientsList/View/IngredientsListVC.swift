//
//  LaunchViewController.swift
//  Drinks
//
//  Created by Andrea Agudo on 05/03/2019.
//  Copyright © 2019 aagudo. All rights reserved.
//

import UIKit
import SwiftyGif

final class IngredientsListVC: UIViewController {

    @IBOutlet weak var ingredientsTableView: UITableView!

    let logoAnimationView = LogoAnimationView()
    private let ingredientsPresenter = IngredientsListPresenter(ingredientsService: IngredientsService())
    var ingredients: [Ingredient]? {
        didSet {
            DispatchQueue.main.async {
                self.ingredientsTableView.reloadData(effect: .leftAndRight)
            }

        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        configureView()
        setTable()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        logoAnimationView.logoGifImageView.startAnimatingGif()
    }

    private func configureView() {
        view.addSubview(logoAnimationView)
        logoAnimationView.pinEdgesToSuperView()
        logoAnimationView.logoGifImageView.delegate = self

        title = localized("ingredients")
        ingredientsPresenter.attachView(self)
    }

    // MARK: getIngredients
    private func getIngredients() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        ingredientsPresenter.getIngredients()
    }

    // MARK: Segue
    private func goToDrinks(ingred: Ingredient) {
        let storyboard = Storyboard.main
        if let cv = storyboard.instantiateViewController(withIdentifier: DrinksVC.identifier) as? DrinksVC {
            cv.ingredient = ingred
            self.navigationController?.pushViewController(cv, animated: true)
        }
    }

    // MARK: TableView
    private func setTable() {
        ingredientsTableView.delegate = self
        ingredientsTableView.dataSource = self
        ingredientsTableView.tableFooterView = UIView()
    }
}

extension IngredientsListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let ingredients = self.ingredients else { return }
        let ingred = ingredients[indexPath.row]
        goToDrinks(ingred: ingred)
    }
}

extension IngredientsListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let ingredients = self.ingredients else { return 0 }
        return ingredients.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: IngredientCell.identifier, for: indexPath) as? IngredientCell,
            let ingredients = self.ingredients else {
                return UITableViewCell()
        }

        let ingred = ingredients[indexPath.row]
        cell.ingredient = ingred

        return cell
    }

}

extension IngredientsListVC: IngredientsListView {
    func setData(_ data: [Ingredient]) {
        self.ingredients = data
    }

    func error(err: WebError<CustomError>) {
        Alert.init(title: localized("default_error.title"), message: err.localizedDescription).present()
    }

}

extension IngredientsListVC: SwiftyGifDelegate {
    func gifDidStop(sender: UIImageView) {
        logoAnimationView.isHidden = true
        getIngredients()
    }
}
