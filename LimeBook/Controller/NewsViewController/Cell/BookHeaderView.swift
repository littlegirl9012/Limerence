//
//  BookHeaderView.swift
//  LimeBook
//
//  Created by Lê Dũng on 10/14/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class BookHeaderView: GreenView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    @IBOutlet weak var lbTitl: UILabel!
    
    override func initStyle() {
        self.backgroundColor = template.backgroundColor ;
        lbTitl.textColor = template.primaryColor
        
    }
    
    func set(_ value : String)
    {
        lbTitl.text = value
    }
}
