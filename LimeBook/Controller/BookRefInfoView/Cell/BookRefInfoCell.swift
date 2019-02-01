//
//  BookRefInfoCell.swift
//  MiBook
//
//  Created by Lê Dũng on 1/26/19.
//  Copyright © 2019 limerence. All rights reserved.
//

import UIKit

class BookRefInfoCell: UITableViewCell {

    @IBOutlet weak var dotView: UIView!
    @IBOutlet weak var lbTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        dotView.backgroundColor = template.sellColor
        dotView.drawRound()
        contentView.backgroundColor = template.backgroundColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(_ book : BookReference)
    {
        lbTitle.text = book.getNameDisplay()
    }
    
}
