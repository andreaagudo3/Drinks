//
//  IngredientsListPresenter.swift
//  Drinks
//
//  Created by Andrea Agudo on 12/03/2019.
//  Copyright © 2019 aagudo. All rights reserved.
//

protocol IngredientsListView: AnyObject {
    func setData(_ data: [Ingredient])
    func error(err: WebError<CustomError>)
}

class IngredientsListPresenter {

    let ingredientsService: IngredientsService
    weak var ingredientsView: IngredientsListView?

    init(ingredientsService: IngredientsService) {
        self.ingredientsService = ingredientsService
    }

    func attachView(_ view: IngredientsListView) {
        ingredientsView = view
    }

    func detachView() {
        ingredientsView = nil
    }

    func getIngredients() {
        ingredientsService.getIngredients { (response) in
            switch response {
            case .success(let data):
                guard let ingredients = data.drinks else { return }
                self.ingredientsView?.setData(ingredients)
            case .failure(let error):
                self.ingredientsView?.error(err: error)
            }
        }
    }

}
