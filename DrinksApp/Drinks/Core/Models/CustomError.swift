//
//  CustomError.swift
//  Companies
//
//  Created by Andrea Agudo on 21/02/2019.
//  Copyright © 2019 aagudo. All rights reserved.
//

import Foundation

struct CustomError: Error, Decodable {
    var message: String
}
