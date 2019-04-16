//
//  CDLDLocation.swift
//  RandomUserCoreData
//
//  Created by Mykhailo Sorokin on 4/16/19.
//  Copyright © 2019 Mykhailo Sorokin. All rights reserved.
//

import Foundation

struct CDLDLocation: Codable {
    var street: String
    var city: String
    var state: String
    var postcode: Int
    var coordinates: CDLDCoordinates
    var timezone: CDLDTimezone
}
