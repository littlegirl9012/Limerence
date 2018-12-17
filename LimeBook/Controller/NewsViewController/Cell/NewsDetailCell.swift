//
//  NewsDetailCell.swift
//  LimeBook
//
//  Created by Lê Dũng on 8/29/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class NewsDetailCell: BookUnitCell {

    @IBOutlet weak var lbRate: UILabel!
    @IBOutlet weak var userImageView: UserImageView!
    @IBOutlet weak var imgGroupView: ImageGroupView!
    @IBOutlet weak var lbContent: UILabel!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var lbName: UILabel!

    var book : Book!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        contentView.backgroundColor = template.backgroundColor
        
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func userTouch(_ sender: Any)
    {
        delegate!.bookUnitUserTouch(self.book.user_id)
    }
    
    class func getIdentifier(_ number : Int) ->String
    {
        if(number > 4 )
        {
            return "NewsDetailCell_4"
        }
        return "NewsDetailCell_" + String(number)
    }
    
    
    class func getIdentifierBook(_ book : Book) ->String
    {
        let count = book.images.count
        if(book.book_type_n == .library)
        {
            if(count > 4 )
            {
                return "NewsDetailCellBook_4"
            }
            return "NewsDetailCellBook_" + String(count)
        }
        else
        {
            if(count > 4 )
            {
                return "NewsDetailCell_4"
            }
            return "NewsDetailCell_" + String(count)
        }
    }

    
    override func set(_ book : Book)
    {
        self.book = book
        lbTitle.attributedText = book.atributeTitle
        lbContent.attributedText = book.attibuteConent
        self.imgGroupView.setMedia(book.media_model)
        if(book.book_type_n != .library)
        {
            lbName.text = book.aliasname
            userImageView.set(book.aliasname, url: book.avatar)
        }
        else
        {
            
        }
        
        if(lbRate != nil)
        {
            lbRate.text = String(Int(book.rate))

        }
    }
    
    func setMedia(_ value :  [MediaFile])
    {
        self.imgGroupView.setMedia(value)
    }
}
