//
//  CDLDLocation.swift
//  RandomUserCoreData
//
//  Created by Mykhailo Sorokin on 4/16/19.
//  Copyright © 2019 Mykhailo Sorokin. All rights reserved.
//

import Foundation

struct CDLDLocation: Codable {
    var street: String?
    var city: String?
    var state: String?
    var postcode: CDLDPostcode?
    var coordinates: CDLDCoordinates?
    var timezone: CDLDTimezone?
}

enum CDLDPostcode: Codable {
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
            self = CDLDPostcode.string(str)
        }
        catch {
            do { let container = try decoder.singleValueContainer()
                let int = try container.decode(Int.self)
                self = CDLDPostcode.integer(int)
            }
            catch {
                throw DecodingError.typeMismatch(CDLDPostcode.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Expected to decode an Int or a String"))
            }
        }
    }
}
