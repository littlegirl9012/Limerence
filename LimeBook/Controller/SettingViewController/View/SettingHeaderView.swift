//
//  SettingHeaderView.swift
//  LimeBook
//
//  Created by Lê Dũng on 9/2/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class SettingHeaderView: GreenView {
    @IBOutlet weak var lbNname: UILabel!
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    
    override func initStyle() {
        lbNname.textColor = template.highlightTextColor
    }
    
    func set(_ title : String)
    {
        lbNname.text = title;
    }

}
