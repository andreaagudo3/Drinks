//
//  IngredientsResponse.swift
//  Drinks
//
//  Created by Andrea Agudo on 13/03/2019.
//  Copyright © 2019 aagudo. All rights reserved.
//

struct IngredientsResponse: Decodable, Equatable {
    static func == (lhs: IngredientsResponse, rhs: IngredientsResponse) -> Bool {
        return lhs.drinks == rhs.drinks
    }

    var drinks: [Ingredient]?

    enum CodingKeys: String, CodingKey {
        case drinks
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        drinks = try values.decodeIfPresent([Ingredient].self, forKey: .drinks)
    }

    func encode(to encoder: Encoder) throws {}
}
