//
//  MessageCell.swift
//  MiBook
//
//  Created by Lê Dũng on 3/1/18.
//  Copyright © 2018 Ledung. All rights reserved.
//

import UIKit
import AlamofireImage

class MessageCell: UITableViewCell {
    @IBOutlet weak var textContentView: UIView!

    @IBOutlet weak var lbContent: UITextView!
    @IBOutlet weak var avatar: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lbTime: UILabel!
    
    @IBOutlet weak var userImageView: UserImageView!

    
    class func getCell(_ message : LimeMessage)-> String
    {
        if(message.messageType() == .plaintext)
        {
            if(message.user_id == userInstance.user.id)
            {
                return  "MessageMyCell"
            }
            else
            {
                return "MessageTargetCell"
            }
        }
        return ""
        
    }
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
        
        textContentView.drawRadius(4, color: UIColor.white, thickness: 0.0)
        textContentView.backgroundColor =  UIColor.white
        lbContent.backgroundColor = UIColor.white
        
        selectionStyle = .none
        lbContent.layer.masksToBounds = true;
        contentView.isOpaque = true
        backgroundView?.isOpaque = true
        lbContent.textColor = template.generalTextColor
        lbTime.alpha = 0.48
        contentView.backgroundColor =  template.backgroundColor
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func set(_ message : LimeMessage)
    {
        lbTime.text = message.timeDisplay
        lbContent.attributedText = message.attri
    }
}
