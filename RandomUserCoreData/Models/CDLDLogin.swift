//
//  CDLDLogin.swift
//  RandomUserCoreData
//
//  Created by Mykhailo Sorokin on 4/16/19.
//  Copyright © 2019 Mykhailo Sorokin. All rights reserved.
//

import Foundation

struct CDLDLogin: Codable {
    var uuid: String
    var username: String
    var password: String
    var salt: String
    var md5: String
    var sha1: String
    var sha256: String
}
