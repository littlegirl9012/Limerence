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
    var message : LimeMessage?
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
        if(message.messageType() == .media)
        {
            if(message.user_id == userInstance.user.id)
            {
                return  "MessageImageMyCell"
            }
            else
            {
                return "MessageImageTargetCell"
            }
        }

        return ""
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
        
        textContentView.drawRadius(4, color: UIColor.white, thickness: 0.0)
        textContentView.backgroundColor =  UIColor.white
        selectionStyle = .none
        contentView.isOpaque = true
        backgroundView?.isOpaque = true
        lbTime.alpha = 0.48
        contentView.backgroundColor =  template.backgroundColor
        
        if(lbContent != nil)
        {
            lbContent.textColor = template.generalTextColor
            lbContent.layer.masksToBounds = true;
            lbContent.backgroundColor = UIColor.white
        }
        if(imgView != nil)
        {
            imgView.drawRadius(0)
            textContentView.drawRadius(0)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func set(_ message : LimeMessage)
    {
        userImageView.set(message.aliasname, url: message.avatar)
        lbTime.text = message.timeDisplay

        if(message.messageType() == .plaintext)
        {
            lbContent.attributedText = message.attri
        }
        if(message.messageType() == .media)
        {
            imgView.setSD(message.content)
        }
        self.message = message
    }
    @IBAction func touchInImage(_ sender: Any) {
        let imageGroup = ImageGroupControler()
        let mediaFile = MediaFile.init(self.message!.content, MediaType.image)
        imageGroup.image = [mediaFile]
        viewController()?.push(imageGroup)
    }
}
