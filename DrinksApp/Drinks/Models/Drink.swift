//
//  Drink.swift
//  Drinks
//
//  Created by Andrea Agudo on 12/03/2019.
//  Copyright © 2019 aagudo. All rights reserved.
//

struct Drink: Decodable, Equatable {
    var strDrink: String?
    var strDrinkThumb: String?
    var idDrink: String?

    enum CodingKeys: String, CodingKey {
        case strDrink, strDrinkThumb, idDrink
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        strDrink = try values.decodeIfPresent(String.self, forKey: CodingKeys.strDrink)
        strDrinkThumb = try values.decodeIfPresent(String.self, forKey: CodingKeys.strDrinkThumb)
        idDrink = try values.decodeIfPresent(String.self, forKey: CodingKeys.idDrink)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(strDrink, forKey: .strDrink)
        try container.encodeIfPresent(strDrinkThumb, forKey: .strDrinkThumb)
        try container.encodeIfPresent(idDrink, forKey: .idDrink)
    }
}
