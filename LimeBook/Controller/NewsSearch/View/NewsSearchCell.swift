//
//  NewsSearchCell.swift
//  LimeBook
//
//  Created by Lê Dũng on 11/3/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class NewsSearchCell: UITableViewCell {

    
    @IBOutlet weak var author: UILabel!
    
    
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbState: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var dotView: UIImageView!
    @IBOutlet weak var stateView: UIView!
    @IBOutlet weak var mainStatusView: UIView!
    @IBOutlet weak var shadowView: UIView!
    var book : Book!
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        shadowView.dropShadow(radius: 6, width: -1, height: -1, opacity: 0.12, shadowRadius: 4)
        mainView.drawRadius(2)
        contentView.backgroundColor = template.backgroundColor
//        stateView.drawRadius(2)
    }
    
    @IBOutlet weak var mainView: UIView!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    func set(book : Book, indexPath : IndexPath)
    {
        lbName.attributedText = book.atributeTitle
        imgView.setSD(book.image)
        if(book.book_type_n == .library)
        {
            author.text = book.author
        }
        else
        {
            author.text = book.content
        }
    }
    

}
