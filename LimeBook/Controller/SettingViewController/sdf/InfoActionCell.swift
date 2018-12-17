//
//  InfoActionCell.swift
//  LimeBook
//
//  Created by Lê Dũng on 12/3/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class InfoActionCell: UITableViewCell {

    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var actionBar: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.backgroundColor = template.backgroundColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func set(_ item : SettingItem){
        lbTitle.text = item.name
    }
    
}
