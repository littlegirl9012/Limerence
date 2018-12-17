//
//  NewsCategoryCell.swift
//  LimeBook
//
//  Created by Lê Dũng on 10/7/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class NewsCategoryCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var lbName: UILabel!
    
    @IBOutlet weak var selectbar: UIView!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func set(_ value : LimeBookType)
    {
        lbName.text = value.name
        if(value.userSelect)
        {
            selectbar.backgroundColor = template.sellColor
        }
        else
        {
            selectbar.backgroundColor = .white

        }
        
    }
}
