//
//  OrderDetailHeaderView.swift
//  MiBook
//
//  Created by Lê Dũng on 1/13/19.
//  Copyright © 2019 limerence. All rights reserved.
//

import UIKit

class OrderDetailHeaderView: GreenView {
    @IBOutlet weak var lbTitle: UILabel!
    
    
    override func initStyle() {
        lbTitle.textColor = template.primaryColor
        view.backgroundColor = template.backgroundColor
        self.backgroundColor = template.backgroundColor
    }
    func setTitle(value : String)
    {
        lbTitle.text = value
    }
}
