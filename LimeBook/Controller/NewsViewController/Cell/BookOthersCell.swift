//
//  BookOthersCell.swift
//  LimeBook
//
//  Created by Lê Dũng on 10/9/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class BookOthersCell: BookMasterCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    override func set(_ book: Book, _ indexPath: IndexPath)
    {
        super.set(book, indexPath)
        lbName.text = book.title
        lbContent.attributedText = book.attibuteConent
        self.userImageView.set("", url: book.avatar)
        lbUsername.text = book.aliasname
        imgGroupView.setMedia(book.media_model)
    }
    override func clear() {
        super.clear()
    }
    
    
}
