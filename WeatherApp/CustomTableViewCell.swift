//
//  CustomTableViewCell.swift
//  WeatherApp
//
//  Created by Joni Ryynänen on 09/10/2018.
//  Copyright © 2018 Joni Ryynänen. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var top: UILabel!
    @IBOutlet weak var bottom: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
