//
//  UserSearchCell.swift
//  LimeBook
//
//  Created by Lê Dũng on 10/25/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class UserSearchCell: UITableViewCell {
    
    @IBOutlet weak var userImageView: UserImageView!
    @IBOutlet weak var lbName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.backgroundColor = UIColor.white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(_ user : User)
    {
        lbName.text = user.aliasname
        userImageView.setMedia(user.mediaAvatar)
    }
    
}
