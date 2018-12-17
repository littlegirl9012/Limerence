//
//  MessageLoadmoreCell.swift
//  LimeBook
//
//  Created by Lê Dũng on 8/20/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class MessageLoadmoreCell: GreenTableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
//        self.contentView.backgroundColor = .clear
//        self.backgroundColor = .clear
        innerView.drawRadius(12)
        
    }
    @IBOutlet weak var innerView: UIView!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
