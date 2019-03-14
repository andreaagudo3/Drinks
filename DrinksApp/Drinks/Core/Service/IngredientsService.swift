//
//  CompaniesService.swift
//  Companies
//
//  Created by Andrea Agudo on 17/02/2019.
//  Copyright © 2019 aagudo. All rights reserved.
//

import UIKit

protocol IngredientsServiceProtocol {
    func getIngredients(completion: @escaping (Result<IngredientsResponse, CustomError>) -> Void)
}

class IngredientsService: IngredientsServiceProtocol {

    var ingredWebClient: WebClient {
        let key = URLKeys.getIngredients.key
        if let path = Bundle.main.path(forResource: "APIProperties", ofType: "plist"),
            let properties = NSDictionary(contentsOfFile: path),
            let plistURL = properties.object(forKey: key) as? String {
            return WebClient(baseUrl: plistURL)
        }
        return WebClient(baseUrl: "")
    }

    var drinksWebClient: WebClient {
        let key = URLKeys.getDrinks.key
        if let path = Bundle.main.path(forResource: "APIProperties", ofType: "plist"),
            let properties = NSDictionary(contentsOfFile: path),
            let plistURL = properties.object(forKey: key) as? String {
            return WebClient(baseUrl: plistURL)
        }
        return WebClient(baseUrl: "")
    }

    internal func getIngredients(completion: @escaping (Result<IngredientsResponse, CustomError>) -> Void) {
        let ingredientsResource = Resource<IngredientsResponse, CustomError>(jsonDecoder: JSONDecoder(), path: "?i=list")
        ingredWebClient.load(resource: ingredientsResource) { response in
            if let companies = response.value {
                completion(Result.success(companies))
            } else if let error = response.error {
                completion(Result.failure(error))
            }
        }
    }

    internal func getDrinks(with name: String, completion: @escaping (Result<DrinksResponse, CustomError>) -> Void) {
        let replacedName = name.replacingOccurrences(of: " ", with: "_")
        let drinksResource = Resource<DrinksResponse, CustomError>(jsonDecoder: JSONDecoder(), path: "?i=" + replacedName)
        drinksWebClient.load(resource: drinksResource) { response in
            if let companies = response.value {
                completion(Result.success(companies))
            } else if let error = response.error {
                completion(Result.failure(error))
            }
        }
    }
}
