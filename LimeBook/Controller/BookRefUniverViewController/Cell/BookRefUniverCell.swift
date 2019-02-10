//
//  BookRefUniverCell.swift
//  MiBook
//
//  Created by Lê Dũng on 2/3/19.
//  Copyright © 2019 limerence. All rights reserved.
//

import UIKit

protocol BookRefUniverCellDelegate : class {
    func BookRefUniverCellTouchUser(_ book : Book)
}
class BookRefUniverCell: UITableViewCell {

    
    var book : Book!
    weak var delegate : BookRefUniverCellDelegate?
    @IBOutlet weak var btAlias: UIButton!
    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lbAuthor: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var lbTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.backgroundColor = template.backgroundColor
        lbPrice.textColor = template.sellColor
        btAlias.setTitleColor(template.primaryColor, for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
 
    @IBAction func nameTouch(_ sender: Any) {
        delegate?.BookRefUniverCellTouchUser(self.book)
    }
    
    func set(_ book : Book)
    {
        self.book = book
        lbTitle.text = book.title
        lbAuthor.text = book.author
        imgView.setSD(book.image)
        lbPrice.isHidden = (book.book_type != 3)
        lbPrice.text = book.price.priceValue()
        
        btAlias.set(title: book.aliasname)
        
    }
}
