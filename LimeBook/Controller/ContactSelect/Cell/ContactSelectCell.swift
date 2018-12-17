//
//  ContactSelectCell.swift
//  LimeBook
//
//  Created by Lê Dũng on 8/21/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class ContactSelectCell: GreenTableViewCell {

    @IBOutlet weak var imgView: UserImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var lbTitle: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(_ user : User)
    {
        lbTitle.text = user.aliasname
        imgView.setUser(user)
    }
    
}
