//
//  BookRefSelectedTypeCell.swift
//  MiBook
//
//  Created by Lê Dũng on 1/24/19.
//  Copyright © 2019 limerence. All rights reserved.
//

import UIKit

protocol BookRefSelectedTypeCellDelegate : class{
    func BookRefSelectedTypeCellTouchin(_ value : BookReference)
}

class BookRefSelectedTypeCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = UIColor.white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    weak var delegate : BookRefSelectedTypeCellDelegate?
    @IBOutlet weak var lbTitle: UILabel!
    var bookRefer : BookReference!
    @IBAction func touchin(_ sender: Any) {
        delegate?.BookRefSelectedTypeCellTouchin(self.bookRefer)
    }
    
    func set(_ bookRefer : BookReference)
    {
        self.bookRefer = bookRefer
        lbTitle.text = bookRefer.name
        
        if(bookRefer.isSelected)
        {
            lbTitle.font = UIFont.boldSystemFont(ofSize: 14)
            lbTitle.textColor = template.sellColor
        }
        else
        {
            lbTitle.font = UIFont.systemFont(ofSize: 14)
            lbTitle.textColor = .black

        }
    }

}
