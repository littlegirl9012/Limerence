//
//  CartItemCell.swift
//  MiBook
//
//  Created by Lê Dũng on 1/6/19.
//  Copyright © 2019 limerence. All rights reserved.
//

import UIKit



class CartItemCell: UITableViewCell {

    @IBOutlet weak var lbPrice: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = template.backgroundColor
        lbPrice.textColor = template.sellColor
        selectionStyle = .none
    }
    @IBOutlet weak var lbName: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(_ book : Book)
    {
        lbName.text = book.title
        lbPrice.text = book.price.priceValue()
    }
    
}
