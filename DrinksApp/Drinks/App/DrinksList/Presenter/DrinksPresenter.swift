//
//  DrinksPresenter.swift
//  Drinks
//
//  Created by Andrea Agudo on 13/03/2019.
//  Copyright © 2019 aagudo. All rights reserved.
//

protocol DrinksView: AnyObject {
    func setData(_ data: [Drink])
    func error(err: WebError<CustomError>)
}

class DrinksPresenter {
    let ingredientsService: IngredientsService
    weak var drinksView: DrinksView?

    init(ingredientsService: IngredientsService) {
        self.ingredientsService = ingredientsService
    }

    func attachView(_ view: DrinksView) {
        drinksView = view
    }

    func detachView() {
        drinksView = nil
    }

    func getDrinks(with ingredient: Ingredient) {
        guard let name = ingredient.strIngredient1 else { return }

        ingredientsService.getDrinks(with: name) { (response) in
            switch response {
            case .success(let data):
                guard let ingredients = data.drinks else { return }
                self.drinksView?.setData(ingredients)
            case .failure(let error):
                self.drinksView?.error(err: error)
            }
        }
    }

}
