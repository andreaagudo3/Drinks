//
//  URLKeys.swift
//  Drinks
//
//  Created by Andrea Agudo on 12/03/2019.
//  Copyright © 2019 aagudo. All rights reserved.
//

import Foundation

enum URLKeys {
    case getIngredients
    case getDrinks

    var key: String {
        switch self {
        case .getIngredients:
            return "urlGetIngredients"
        case .getDrinks:
            return "urlGetDrinks"
        }
    }
}
