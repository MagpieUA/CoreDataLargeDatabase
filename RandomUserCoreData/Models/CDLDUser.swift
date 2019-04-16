//
//  CDLDUser.swift
//  RandomUserCoreData
//
//  Created by Mykhailo Sorokin on 4/16/19.
//  Copyright © 2019 Mykhailo Sorokin. All rights reserved.
//

import Foundation

struct CDLDUser: Codable {
    var gender: String
    var name: CDLDName
    var location: CDLDLocation
    var email: String
    var login: CDLDLogin
    var dob: CDLDDayOfBirth
    var phone: String
    var cell: String
    var id: CDLDID
    var picture: CDLDPicture
    var nat: String
}
