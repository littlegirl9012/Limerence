//
//  BookRefInfoHeaderView.swift
//  MiBook
//
//  Created by Lê Dũng on 1/26/19.
//  Copyright © 2019 limerence. All rights reserved.
//

import UIKit

class BookRefInfoHeaderView: GreenView {

    @IBOutlet weak var lbTitle: UILabel!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */


    @IBOutlet weak var lbPrice: UILabel!
    override func initStyle() {
        view.backgroundColor = template.backgroundColor
        lbTitle.textColor = template.primaryColor
        lbPrice.textColor = template.sellColor
        
    }
    
}
