//
//  BookCatCell.swift
//  LimeBook
//
//  Created by Lê Dũng on 9/8/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit




class BookCatCell: UITableViewCell {

    override func awakeFromNib()
    {
        super.awakeFromNib()
    }
    @IBOutlet weak var selectBar: UIView!
    
    @IBOutlet weak var lbName: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func set(_ cate : BookCategory)
    {
        lbName.text = cate.name
        cate.selected ? (selectBar.backgroundColor = template.sellColor) : (selectBar.backgroundColor = UIColor.clear)
    }
}
