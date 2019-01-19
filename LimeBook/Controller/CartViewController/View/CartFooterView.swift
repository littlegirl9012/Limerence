//
//  CartFooterView.swift
//  MiBook
//
//  Created by Lê Dũng on 1/6/19.
//  Copyright © 2019 limerence. All rights reserved.
//

import UIKit

class CartFooterView: GreenView {
    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var lbShip: UILabel!
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    func set(_ value : Order)
    {
        lbPrice.text = value.totalPrice().priceValue()
        lbShip.text = value.shipUserTitle()
    }
    
    override func initStyle() {
        view.backgroundColor = template.backgroundColor
        lbPrice.textColor = template.sellColor
        lbShip.textColor = template.sellColor

    }

}
