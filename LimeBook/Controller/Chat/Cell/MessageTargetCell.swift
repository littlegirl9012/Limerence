//
//  MessageTargetCell.swift
//  MiBook
//
//  Created by Lê Dũng on 3/29/18.
//  Copyright © 2018 Ledung. All rights reserved.
//

import UIKit

class MessageTargetCell: MessageCell {

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override func set(_ message: LimeMessage)
    {
        super.set(message)
        textContentView.backgroundColor =  template.primaryColor
        if(lbContent != nil)
        {
            lbContent.backgroundColor = UIColor.clear
            lbContent.textColor = UIColor.white
        }

    }
}
