//
//  LibCatCell.swift
//  LimeBook
//
//  Created by Lê Dũng on 9/25/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class LibCatCell: UITableViewCell {
    @IBOutlet weak var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    @IBOutlet weak var lbName: UILabel!
    
    func set(_ cat : BookCategory)
    {
        lbName.text = cat.name
        let imageName = "cat" + String(cat.id)
        imgView.image = imageName.image()
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
