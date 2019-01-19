//
//  OrderDetailBuyCell.swift
//  MiBook
//
//  Created by Lê Dũng on 1/14/19.
//  Copyright © 2019 limerence. All rights reserved.
//

import UIKit
// Cell thông tin người mua hàng
class OrderDetailBuyCell: UITableViewCell
{

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var lbAddress: UILabel!
    @IBOutlet weak var lbPhone: UILabel!
    @IBOutlet weak var lbName: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        contentView.backgroundColor = template.backgroundColor
    }
    
    func set(_ order : Order)
    {
        lbName.text = order.aliasname
        lbPhone.text = order.phone
        lbAddress.textR = order.address
    }
}
