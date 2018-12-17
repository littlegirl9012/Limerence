//
//  LibraryDetetailCell.swift
//  LimeBook
//
//  Created by Lê Dũng on 9/27/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class LibraryDetailCell: UITableViewCell
{
    @IBOutlet weak var lbAuthor: UILabel!
    @IBOutlet weak var lbAlias: UILabel!
    
    @IBOutlet weak var userImgView: UserImageView!
    @IBOutlet weak var lbContent: UILabel!
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var lbName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.drawRadius(4)
        contentView.backgroundColor = template.backgroundColor
    }

    
    func set(_ book : Book)
    {
        lbName.text = book.title
        lbAuthor.text = book.author
        lbContent.attributedText = book.attibuteConent
        
        //userImgView.setMedia(book.image_media)
        lbAlias.text = book.aliasname
    }
    
}
