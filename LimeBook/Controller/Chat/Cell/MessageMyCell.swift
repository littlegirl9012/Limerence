//
//  MessageMyCell.swift
//  MiBook
//
//  Created by Lê Dũng on 3/29/18.
//  Copyright © 2018 Ledung. All rights reserved.
//

import UIKit

class MessageMyCell: MessageCell {
    
    override func awakeFromNib()
    {
        super.awakeFromNib()

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    override func set(_ message: LimeMessage)
    {
        super.set(message)
        userImageView.setMedia(userInstance.user.mediaAvatar)
    }

}
