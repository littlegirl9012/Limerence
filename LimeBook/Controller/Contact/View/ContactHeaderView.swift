//
//  ContactHeaderView.swift
//  LimeBook
//
//  Created by Lê Dũng on 8/31/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class ContactHeaderView: GreenView {

    @IBOutlet weak var lbName: UILabel!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func initStyle() {
        view.backgroundColor = template.backgroundColor
        lbName.textColor = template.highlightTextColor
    }
    func set(_ title : String)
    {
        lbName.text = title
    }

}
