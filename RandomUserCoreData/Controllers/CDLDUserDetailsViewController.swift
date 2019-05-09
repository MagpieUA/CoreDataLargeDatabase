//
//  CDLDUserDetailsViewController.swift
//  RandomUserCoreData
//
//  Created by Mykhailo Sorokin on 4/19/19.
//  Copyright © 2019 Mykhailo Sorokin. All rights reserved.
//

import UIKit
import SDWebImage

class CDLDUserDetailsViewController: UIViewController {
    
    var user: CDLDUserViewModel?

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var nationalityLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let user = user {
            imageView.sd_setImage(with: user.mediumImageURL, completed: nil)
            nameLabel.text = user.fullName
            emailLabel.text = user.email
            nationalityLabel.text = user.nationality
            genderLabel.text = user.gender
            stateLabel.text = user.state
            cityLabel.text = user.city
            phoneLabel.text = user.phone
            cellLabel.text = user.cell
        }
    }
}
