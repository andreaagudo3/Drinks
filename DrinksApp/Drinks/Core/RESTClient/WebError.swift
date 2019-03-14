//
//  WebError.swift
//  Companies
//
//  Created by Andrea Agudo on 25/02/2019.
//  Copyright © 2019 aagudo. All rights reserved.
//

import Foundation

public enum WebError<CustomError>: Error {
    case noInternetConnection
    case custom(CustomError)
    case unauthorized
    case other
}
