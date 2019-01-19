//
//  CartAcceptView.swift
//  MiBook
//
//  Created by Lê Dũng on 1/10/19.
//  Copyright © 2019 limerence. All rights reserved.
//

import UIKit

protocol CartAcceptViewDelegate : class{
    func cartAcceptViewTouch()
}

class CartAcceptView: GreenView {

    
    weak var delegate : CartAcceptViewDelegate?
    
    @IBAction func acceptTouch(_ sender: Any) {
        delegate?.cartAcceptViewTouch()
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
