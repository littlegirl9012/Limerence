//
//  UserCell.swift
//  LimeBook
//
//  Created by Lê Dũng on 8/18/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    @IBOutlet weak var statusCell: UIView!
    @IBOutlet weak var imgView: UserImageView!
    @IBOutlet weak var lbName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imgView.drawRound()
        statusCell.isHidden = true ;
        statusCell.drawRound()
        statusCell.backgroundColor = template.highlightTextColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func set(_ user : User)
    {
        lbName.text = user.aliasname
        imgView.set(user.aliasname, url: user.avatar)
        
        user.isOnline ? setOnline() : setOffline();
    }
    
    func setOnline()
    {
        statusCell.isHidden = false ;
    }
    
    func setOffline()
    {
        statusCell.isHidden = true ;

    }
    
}
