//
//  BookRefSelectedCell.swift
//  MiBook
//
//  Created by Lê Dũng on 1/24/19.
//  Copyright © 2019 limerence. All rights reserved.
//

import UIKit

class BookRefSelectedCell: UITableViewCell {

    @IBOutlet weak var viewCheck: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        viewCheck.drawRound()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(_ value : BookReference)
    {
        lbTitle.text = value.name
        
        if(value.isSelected)
        {
            check()
        }
        else
        {
            unCheck()
        }
    }
    
    func check()
    {
        imgView.image = "white_check".image()
        viewCheck.backgroundColor = template.sellColor
        viewCheck.isHidden = false
        lbTitle.font = UIFont.boldSystemFont(ofSize: 14)

    }
    
    func unCheck()
    {
        imgView.image = nil
        viewCheck.backgroundColor = UIColor.lightGray
        lbTitle.font = UIFont.systemFont(ofSize: 14)
        viewCheck.isHidden = true

    }
    
}


/*
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

 */
