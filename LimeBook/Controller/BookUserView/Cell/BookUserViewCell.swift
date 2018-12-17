//
//  BookUserViewCell.swift
//  LimeBook
//
//  Created by Lê Dũng on 11/18/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class BookUserViewCell: UITableViewCell {

    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.backgroundColor = UIColor.white
    }

    @IBOutlet weak var lbAuthor: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(book : Book)
    {
        lbName.text = book.title
        imgView.setSD(book.image)
        lbAuthor.text = book.author
    }

}
