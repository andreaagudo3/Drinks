//
//  DrinksResponse.swift
//  Drinks
//
//  Created by Andrea Agudo on 13/03/2019.
//  Copyright © 2019 aagudo. All rights reserved.
//

struct DrinksResponse: Decodable, Equatable {
    static func == (lhs: DrinksResponse, rhs: DrinksResponse) -> Bool {
        return lhs.drinks == rhs.drinks
    }

    var drinks: [Drink]?

    enum CodingKeys: String, CodingKey {
        case drinks
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        drinks = try values.decodeIfPresent([Drink].self, forKey: .drinks)
    }

    func encode(to encoder: Encoder) throws {}
}
