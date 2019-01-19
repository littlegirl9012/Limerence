//
//  DistrictCell.swift
//  Mobile_68
//
//  Created by Lê Dũng on 7/19/18.
//  Copyright © 2018 Ledung. All rights reserved.
//

import UIKit

class DistrictCell: UITableViewCell {

    @IBOutlet weak var lbName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.backgroundColor = template.backgroundColor
        backgroundColor = template.backgroundColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(_ value : DHMDistrict)
    {
        lbName.text = value.name
    }
    
}
