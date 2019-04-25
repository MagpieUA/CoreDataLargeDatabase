//
//  RandomUserTableViewCell.swift
//  RandomUserCoreData
//
//  Created by Mykhailo Sorokin on 4/12/19.
//  Copyright © 2019 Mykhailo Sorokin. All rights reserved.
//

import UIKit
import SDWebImage

class RandomUserTableViewCell: UITableViewCell, Reusable {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    func configureWithUserViewModel(user: CDLDUserViewModel?) {
        if let user = user {
            nameLabel.text = user.fullName
            thumbnailImageView.sd_setImage(with: user.thumbnailURL, completed: nil)
        }
    }
}
