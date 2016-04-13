//
//  ProfileStaticTableViewCell.swift
//  workaday
//
//  Created by Adam Preston on 4/13/16.
//  Copyright © 2016 RTI. All rights reserved.
//

import UIKit

class ProfileStaticTableViewCell: UITableViewCell {

    // MARK: Properties
    
    static let reuseIdentifier = "ProfileStaticTableViewCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
}
