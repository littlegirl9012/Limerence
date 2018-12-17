//
//  SettingCell.swift
//  LimeBook
//
//  Created by Lê Dũng on 8/21/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class SettingCell: GreenTableViewCell {

    @IBOutlet weak var lbDes: UILabel!
    @IBOutlet weak var lbName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lbName.text = ""
    }
    @IBOutlet weak var userImageView: UserImageView!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(_ item :SettingItem)
    {
        lbName.text = item.name
        userImageView.set(item.name, url: item.url)
    }
    
}
