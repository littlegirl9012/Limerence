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
    
    override func set(_ message: LimeMessage) {
        super.set(message)
        textContentView.drawRadius(4, color: UIColor.white, thickness: 0.0)
        textContentView.backgroundColor =  template.primaryColor
        lbContent.backgroundColor = UIColor.clear
        lbContent.textColor = UIColor.white
        userImageView.set(message.aliasname, url: message.avatar)
    }
}
