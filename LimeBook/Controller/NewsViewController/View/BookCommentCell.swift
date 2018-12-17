//
//  BookCommentCell.swift
//  LimeBook
//
//  Created by Lê Dũng on 9/30/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class BookCommentCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    
        imgView.drawRound()
        // Initialization code
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
