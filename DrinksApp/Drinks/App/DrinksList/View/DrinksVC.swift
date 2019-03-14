//
//  DrinksVC.swift
//  Drinks
//
//  Created by Andrea Agudo on 13/03/2019.
//  Copyright © 2019 aagudo. All rights reserved.
//

import UIKit

final class DrinksVC: UIViewController {

    @IBOutlet weak var drinksTableView: UITableView!

    static let identifier = "drinksVC"
    private let drinksPresenter = DrinksPresenter(ingredientsService: IngredientsService())
    var drinks: [Drink]? {
        didSet {
            DispatchQueue.main.async {
                self.drinksTableView.reloadData(effect: .leftAndRight)
            }

        }
    }

    var ingredient: Ingredient? {
        didSet {
            if let ingredient = ingredient {
                drinksPresenter.getDrinks(with: ingredient)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setTable()
    }

    private func configureView() {
        if let name = ingredient?.strIngredient1 {
            title = localized("drinks_with") + name
        }
        drinksPresenter.attachView(self)
    }

    // MARK: TableView
    private func setTable() {
        drinksTableView.delegate = self
        drinksTableView.dataSource = self
        drinksTableView.tableFooterView = UIView()
    }
}

extension DrinksVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension DrinksVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let drinks = self.drinks else { return 0 }
        return drinks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: DrinkCell.identifier, for: indexPath) as? DrinkCell,
            let drinks = self.drinks else {
                return UITableViewCell()
        }

        let drink = drinks[indexPath.row]
        cell.drink = drink

        return cell
    }

}

extension DrinksVC: DrinksView {
    func setData(_ data: [Drink]) {
        self.drinks = data
    }

    func error(err: WebError<CustomError>) {
        Alert.init(title: localized("default_error.title"), message: err.localizedDescription).present()
    }

}
