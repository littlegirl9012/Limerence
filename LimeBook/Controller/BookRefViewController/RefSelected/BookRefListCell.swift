//
//  BookRefListCell.swift
//  MiBook
//
//  Created by Lê Dũng on 1/20/19.
//  Copyright © 2019 limerence. All rights reserved.
//

import UIKit

class BookRefListCell: UITableViewCell {

    @IBOutlet weak var lbTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = template.backgroundColor
        lbPrice.textColor = template.buyColor
        cView.backgroundColor = "098174".hexColor()

    }


    @IBOutlet weak var lbPrice: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }
    
    @IBOutlet weak var lbIndex: UILabel!
    
    @IBOutlet weak var cView: UIView!
    
    func set(_ refBook : ReferenceGroup)
    {
        if(refBook.price == 0)
        {
            lbPrice.textColor = template.buyColor
        }
        else
        {
            lbPrice.textColor = template.sellColor
        }
        lbPrice.text = refBook.price.priceValue()
        lbTitle.text = "Bộ sách giáo khoa " + refBook.name
        lbIndex.text =  String(refBook.name.last!)
    }
}
