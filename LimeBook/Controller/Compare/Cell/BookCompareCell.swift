//
//  BookCompareCell.swift
//  MiBook
//
//  Created by Lê Dũng on 2/14/19.
//  Copyright © 2019 limerence. All rights reserved.
//

import UIKit

class BookCompareCell: UITableViewCell {

    @IBOutlet weak var storeView: UIView!
    @IBOutlet weak var lbStore: UILabel!
    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var lbAuthor: UILabel!
    @IBOutlet weak var lbTitle: UILabel!
    var book : Book!
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = template.backgroundColor
        storeView.drawRadius(4)
        lbPrice.textColor = template.sellColor
    }
    @IBAction func touchIn(_ sender: Any) {
        guard let url = URL(string: book.link) else { return }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var imgView: BookImageView!
    func set(_ book : Book)
    {
        self.book = book
        lbTitle.text = book.title
        lbPrice.text = book.sell_price.priceValue()
        lbAuthor.textR = book.author
        imgView.set(book.image)
        storeView.backgroundColor = book.storeColor().1
        lbStore.text = book.storeColor().0
    }
    
}
