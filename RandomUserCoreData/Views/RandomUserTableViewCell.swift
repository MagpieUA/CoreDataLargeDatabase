//
//  RandomUserTableViewCell.swift
//  RandomUserCoreData
//
//  Created by Mykhailo Sorokin on 4/12/19.
//  Copyright © 2019 Mykhailo Sorokin. All rights reserved.
//

import UIKit

class RandomUserTableViewCell: UITableViewCell, Reusable {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    func configureWithUser(user: CDLDUser) {
        nameLabel.text = user.name?.first
    }
}
