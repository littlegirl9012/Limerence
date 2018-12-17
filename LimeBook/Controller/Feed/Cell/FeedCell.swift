//
//  FeedCell.swift
//  LimeBook
//
//  Created by Lê Dũng on 8/29/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {

    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var pinView: UIView!

    override func awakeFromNib() {
        
        selectionStyle = .none
        pinView.drawRound()
        super.awakeFromNib()
        lbDate.textColor = template.subTextColor
        lbTitle.textColor = template.generalTextColor
        pinView.backgroundColor = template.sellColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(_ book : Book)
    {
        lbTitle.text = book.title.uppercased()
        lbDate.text = book.date.date8601().stringValue()
    }
    
}
