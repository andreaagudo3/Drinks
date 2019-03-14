//
//  DecodingExtension.swift
//  Drinks
//
//  Created by Andrea Agudo on 12/03/2019.
//  Copyright © 2019 aagudo. All rights reserved.
//

import Foundation

private struct DummyCodable: Codable {}

extension UnkeyedDecodingContainer {
    public mutating func decodeArray<T>(_ type: T.Type) throws -> [T] where T: Decodable {
        var array = [T]()
        while !self.isAtEnd {
            do {
                let item = try self.decode(T.self)
                array.append(item)
            } catch let error {
                print("error: \(error)")

                // trick to increment currentIndex
                _ = try self.decode(DummyCodable.self)
            }
        }
        return array
    }
}

extension KeyedDecodingContainerProtocol {
    public func decodeArray<T>(_ type: T.Type, forKey key: Self.Key) throws -> [T] where T: Decodable {
        var unkeyedContainer = try self.nestedUnkeyedContainer(forKey: key)
        return try unkeyedContainer.decodeArray(type)
    }
}
