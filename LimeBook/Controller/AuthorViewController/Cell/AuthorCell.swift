//
//  AuthorCell.swift
//  LimeBook
//
//  Created by Lê Dũng on 10/7/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class AuthorCell: UITableViewCell {

    @IBOutlet weak var lbAliasname: UILabel!
    @IBOutlet weak var lbName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        lbName.textColor = template.generalTextColor
        lbAliasname.textColor = template.subTextColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func set(_ author : Author)
    {
        lbName.text = author.name
        if(author.name != author.aliasname)
        {
            lbAliasname.text = author.aliasname

        }
        else
        {
            lbAliasname.text = ""
        }

    }
}
