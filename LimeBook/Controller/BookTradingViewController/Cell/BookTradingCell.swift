//
//  BookTradingCell.swift
//  LimeBook
//
//  Created by Lê Dũng on 12/4/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class BookTradingCell: UITableViewCell {
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var btState: UIButton!


    @IBOutlet weak var lbAuthor: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = template.backgroundColor
        lbPrice.textColor = template.sellColor
        lbAuthor.textColor = template.subTextColor
        btState.drawRadius(2)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(_ book : Book)
    {
        imgView.setSD(book.image)
        lbAuthor.text = book.author
        lbTitle.text = book.title
        lbPrice.text = book.price.priceValue()
    }
    
}
