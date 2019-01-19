//
//  CartHeaderView.swift
//  MiBook
//
//  Created by Lê Dũng on 1/6/19.
//  Copyright © 2019 limerence. All rights reserved.
//

import UIKit

class CartHeaderView: GreenView {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var userImageVIew: UIView!
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func initStyle() {
        userImageVIew.drawRound()
        self.backgroundColor = template.backgroundColor
        self.contentView.backgroundColor = .white
        
    }
    func set(_ order : Order)
    {
        lbTitle.text = order.aliasname
        imgView.setSD(order.avatar)
    }

}
