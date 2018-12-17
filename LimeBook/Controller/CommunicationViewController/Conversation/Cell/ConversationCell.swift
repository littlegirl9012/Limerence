//
//  ConversationCell.swift
//  LimeBook
//
//  Created by Lê Dũng on 8/19/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class ConversationCell: GreenTableViewCell {

    @IBOutlet weak var userImageView: UserImageView!
    @IBOutlet weak var lbLastMessage: UILabel!
    @IBOutlet weak var lbName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lbLastMessage.text = ""
        unreadView.drawRound()
        
    }
    @IBOutlet weak var unreadView: UIView!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var lbUnread: UILabel!
    func set(_ conversation : Conversation)
    {
        lbName.text = conversation.name
        lbLastMessage.attributedText = conversation.lastMessageAttribute
        if(conversation.media_file != nil)
        {
            userImageView.setMedia(conversation.media_file)
        }
        
        unreadView.isHidden = (conversation.message_unread == 0)
        
        if(conversation.message_unread == 0)
        {
            lbUnread.text = ""
        }
        else{
            lbUnread.text = String(conversation.message_unread)

        }
    }
}
