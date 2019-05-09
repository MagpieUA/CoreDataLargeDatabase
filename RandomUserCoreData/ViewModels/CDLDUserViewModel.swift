//
//  CDLDUserViewModel.swift
//  RandomUserCoreData
//
//  Created by Mykhailo Sorokin on 4/16/19.
//  Copyright © 2019 Mykhailo Sorokin. All rights reserved.
//

import Foundation

class CDLDUserViewModel {
    
    var user: User
    
    init(user: User) {
        self.user = user
    }
    
    var fullName: String {
        var resultString = ""
        resultString.append(self.user.firstName?.capitalized ?? "")
        resultString.append(" ")
        resultString.append(self.user.lastName?.capitalized ?? "")
        return resultString.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
    }
    
    var email: String? {
        return self.user.email
    }
    
    var nationality: String? {
        return self.user.nat
    }
    
    var gender: String? {
        return self.user.gender
    }
    
    var state: String? {
        return self.user.state
    }
    
    var city: String? {
        return self.user.city
    }
    
    var phone: String? {
        return self.user.phone
    }
    
    var cell: String? {
        return self.user.cell
    }
    
    var thumbnailURL: URL? {
        guard let urlString = self.user.thumbnailURLString else { return nil }
        return URL(string: urlString)
    }
    
    var mediumImageURL: URL? {
        guard let urlString = self.user.imageURLString else { return nil}
        return URL(string: urlString)
    }
}
