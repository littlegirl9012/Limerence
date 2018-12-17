//
//  BookInfoUnitView.swift
//  LimeBook
//
//  Created by Lê Dũng on 9/30/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class BookInfoUnitView: GreenView {
    @IBOutlet weak var lbValue: UILabel!
    @IBOutlet weak var lbTitle: UILabel!
    
    
    
    override func initStyle() {
        lbTitle.textColor = template.generalTextColor
        lbValue.textColor = template.subTextColor
    }
    func set(_ title : String, _ value : String)
    {
        lbTitle.text = title
        lbValue.textR = value
    }

}
