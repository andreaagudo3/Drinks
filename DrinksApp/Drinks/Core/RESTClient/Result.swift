//
//  Result.swift
//  Companies
//
//  Created by Andrea Agudo on 25/02/2019.
//  Copyright © 2019 aagudo. All rights reserved.
//

import Foundation

public enum Result<A, CustomError> {
    case success(A)
    case failure(WebError<CustomError>)
}

extension Result {
    init(value: A?, or error: WebError<CustomError>) {
        guard let value = value else {
            self = .failure(error)
            return
        }

        self = .success(value)
    }

    var value: A? {
        guard case let .success(value) = self else { return nil }
        return value
    }

    var error: WebError<CustomError>? {
        guard case let .failure(error) = self else { return nil }
        return error
    }
}
