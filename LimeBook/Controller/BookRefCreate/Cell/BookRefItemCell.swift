//
//  BookRefItemCell.swift
//  MiBook
//
//  Created by Lê Dũng on 1/20/19.
//  Copyright © 2019 limerence. All rights reserved.
//

import UIKit

class BookRefItemCell: UITableViewCell {

    @IBOutlet weak var dotView: UIView!
    @IBOutlet weak var lbTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = template.backgroundColor
        dotView.backgroundColor = template.sellColor
        dotView.drawRound()
        
        selectionStyle = . none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func set(_ ref : BookReference)
    {
        lbTitle.text = ref.name
    }
    
}
