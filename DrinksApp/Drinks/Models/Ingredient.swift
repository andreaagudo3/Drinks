//
//  File.swift
//  Drinks
//
//  Created by Andrea Agudo on 12/03/2019.
//  Copyright © 2019 aagudo. All rights reserved.
//

import Foundation

struct Ingredient: Decodable, Equatable {
    var strIngredient1: String?

    enum CodingKeys: String, CodingKey {
        case strIngredient1
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        strIngredient1 = try values.decodeIfPresent(String.self, forKey: CodingKeys.strIngredient1)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(strIngredient1, forKey: .strIngredient1)
    }
}
