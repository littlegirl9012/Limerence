//
//  OrderHistoryCell.swift
//  MiBook
//
//  Created by Lê Dũng on 1/13/19.
//  Copyright © 2019 limerence. All rights reserved.
//

import UIKit

class OrderHistoryCell: UITableViewCell {

    @IBOutlet weak var lbTitle: UILabel!
    
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var lbStatus: UILabel!
    @IBOutlet weak var lbTotalPrice: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.backgroundColor = template.backgroundColor
        lbTitle.textColor = template.primaryColor
        selectionStyle = .none
        lbTotalPrice.textColor = template.sellColor
        lbDate.textColor = template.subTextColor

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func set(order  : Order)
    {
        lbTitle.text = order.buySellTitle()
        lbDate.text = order.create_date.date8601().stringValue()
        lbTotalPrice.text = order.product_price.priceValue()
        if(order.isUserSell())
        {
            lbTitle.textColor = template.sellColor
        }
        else
        {
            lbTitle.textColor = template.buyColor
        }
        lbStatus.text = order.getStatusTitle()
    }
    

    
}
