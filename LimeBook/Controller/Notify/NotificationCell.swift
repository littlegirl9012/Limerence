//
//  NotificationCell.swift
//  LimeBook
//
//  Created by Lê Dũng on 9/5/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class NotificationCell: UITableViewCell {

    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var imgView: UserImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    
    func set(_ noti : LimeNotification)
    {
        lbName.attributedText = noti.attributeDisplay
        imgView.setMedia(noti.media)
        
    }
    
}
