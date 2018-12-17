//
//  SettingItemCell.swift
//  LimeBook
//
//  Created by Lê Dũng on 9/20/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class SettingItemCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var imgRoundView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        imgRoundView.drawRound()
    }
    @IBOutlet weak var lbName: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func set(_ item :SettingItem)
    {
        imgRoundView.backgroundColor = item.color
        imgView.image = item.image
        lbName.text = item.name
    }

}
