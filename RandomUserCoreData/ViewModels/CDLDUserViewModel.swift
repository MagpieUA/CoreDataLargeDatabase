//
//  CDLDUserViewModel.swift
//  RandomUserCoreData
//
//  Created by Mykhailo Sorokin on 4/16/19.
//  Copyright © 2019 Mykhailo Sorokin. All rights reserved.
//

import Foundation

class CDLDUserViewModel {
    
    var user: CDLDUser
    
    init(user: CDLDUser) {
        self.user = user
    }
    
    var fullName: String {
        var resultString = ""
        resultString.append(self.user.name?.first ?? "")
        resultString.append(" ")
        resultString.append(self.user.name?.last ?? "")
        return resultString.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
    }
}
