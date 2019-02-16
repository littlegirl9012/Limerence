//
//  BookOwnerCell.swift
//  MiBook
//
//  Created by Lê Dũng on 2/17/19.
//  Copyright © 2019 limerence. All rights reserved.
//

import UIKit

class BookOwnerCell: UITableViewCell {

    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var imgView: UserImageView!
    @IBOutlet weak var lbProvince: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(_ user : User)
    {
        lbName.text = user.aliasname
        lbProvince.text = user.province_name
        imgView.setUser(user)
    }
}
