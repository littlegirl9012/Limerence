//
//  BookSelectCell.swift
//  LimeBook
//
//  Created by Lê Dũng on 9/26/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class BookSelectCell: UITableViewCell {
    @IBOutlet weak var lbAuthor: UILabel!
    @IBOutlet weak var imgView: UIImageView!

    @IBOutlet weak var lbName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lbName.textColor = template.generalTextColor
        lbAuthor.textColor = template.subTextColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func set(_ book : Book)
    {
        lbName.text = book.title.trim()
        lbAuthor.text = book.author
        imgView.setSD(book.image)
    }
    
    
}
