//
//  BookRefInfoAddress.swift
//  MiBook
//
//  Created by Lê Dũng on 1/27/19.
//  Copyright © 2019 limerence. All rights reserved.
//

import UIKit

class BookRefInfoAddress: UITableViewCell {

    @IBOutlet weak var lbNote: UILabel!
    @IBOutlet weak var lbPhone: UILabel!
    @IBOutlet weak var lbName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        contentView.backgroundColor = template.backgroundColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(_ group : ReferenceGroup)
    {
        lbName.textR = group.aliasname
        lbPhone.textR = group.phone
        lbNote.textR = group.note
    }
    
    
    
}
