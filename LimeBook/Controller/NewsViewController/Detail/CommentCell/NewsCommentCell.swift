//
//  NewsCommentCell.swift
//  LimeBook
//
//  Created by Lê Dũng on 8/30/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit
protocol NewsCommentCellDelegate : class {
    func commentDidSelect(_ value : Comment)
}

class NewsCommentCell: UITableViewCell {
    var comment : Comment!
    weak var delegate : NewsCommentCellDelegate?
    
    @IBAction func userTouch(_ sender: Any)
    {
    }
    
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var userImageView: UserImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none

        userImageView.set("", url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZLHCNU2PR9kD4jhnwFRDEi7hnap6l0ny41H5emaV2-w-9Yir5")
        lbDate.textColor = template.subTextColor
        contentView.backgroundColor = template.backgroundColor
    }
    @IBOutlet weak var lbContent: UILabel!
    @IBOutlet weak var lbDate: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBOutlet weak var like: LineView!
    
    func set(_ comment : Comment)
    {
        self.comment = comment
        lbContent.attributedText = comment.attributeContent
        userImageView.setMedia(comment.media_file)
        lbName.text = comment.aliasname
        lbDate.text = comment.date.date8601().stringValue()
    }
    
}
