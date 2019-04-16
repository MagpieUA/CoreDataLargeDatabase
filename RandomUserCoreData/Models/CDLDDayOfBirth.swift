//
//  CDLDDayOfBirth.swift
//  RandomUserCoreData
//
//  Created by Mykhailo Sorokin on 4/16/19.
//  Copyright © 2019 Mykhailo Sorokin. All rights reserved.
//

import Foundation

struct CDLDDayOfBirth: Codable {
    var date: String?
    var age: CDLDAge?
}

enum CDLDAge: Codable {
    case string(String), integer(Int)
    
    func encode(to encoder: Encoder) throws {
        switch self {
        case .string(let str):
            var container = encoder.singleValueContainer()
            try container.encode(str)
        case .integer(let int):
            var container = encoder.singleValueContainer()
            try container.encode(int)
        }
    }
    
    init(from decoder: Decoder) throws {
        do {
            let container = try decoder.singleValueContainer()
            let str = try container.decode(String.self)
            self = CDLDAge.string(str)
        }
        catch {
            do { let container = try decoder.singleValueContainer()
                let int = try container.decode(Int.self)
                self = CDLDAge.integer(int)
            }
            catch {
                throw DecodingError.typeMismatch(CDLDAge.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Expected to decode an Int or a String"))
            }
        }
    }
}
