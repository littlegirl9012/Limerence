//
//  OrderDetailInfoCell.swift
//  MiBook
//
//  Created by Lê Dũng on 1/13/19.
//  Copyright © 2019 limerence. All rights reserved.
//

import UIKit

class OrderDetailInfoCell: UITableViewCell {

    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var lbTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = template.backgroundColor
        lbPrice.textColor = template.sellColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(_ book : Book)
    {
        lbTitle.textR = book.title
        lbPrice.textR = book.price.priceValue()
    
    }
    
}
