//
//  BooksCell.swift
//  LimeBook
//
//  Created by Lê Dũng on 8/29/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit



class BooksCell: UITableViewCell {
    
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
        
        shadowView.dropShadow(radius: 6, width: -1, height: -1, opacity: 0.12, shadowRadius: 4)
        mainView.drawRadius(2)
        contentView.backgroundColor = UIColor.white
        stateView.drawRadius(2)
    }
    
    @IBOutlet weak var mainView: UIView!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func set(book : Book, indexPath : IndexPath)
    {
        lbName.text = book.title
        imgView.setSD(book.image)
        author.text = book.author
        
        stateView.backgroundColor = book.stateColor()
        
        lbState.text = book.stateTitle()
        if(book.book_type_n == .general)
        {
            stateView.isHidden = true
        }
        else
        {
            stateView.isHidden = false
        }
    }
        
}

