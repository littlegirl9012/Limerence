//
//  OrderDetailHeaderStatusView.swift
//  MiBook
//
//  Created by Lê Dũng on 1/15/19.
//  Copyright © 2019 limerence. All rights reserved.
//

import UIKit

protocol OrderDetailHeaderStatusViewDelegate : class {
    func orderDetailHeaderStatusViewChangeState()
}

class OrderDetailHeaderStatusView: GreenView {

    weak var delegate : OrderDetailHeaderStatusViewDelegate?
    @IBOutlet weak var btStatus: UIButton!
    
    @IBOutlet weak var lbTitle: UILabel!
    override func initStyle() {
        backgroundColor = template.backgroundColor
        lbTitle.textColor = template.sellColor
    }
    
    @IBAction func touchIn(_ sender: Any) {
        delegate?.orderDetailHeaderStatusViewChangeState()
    }
    func set(_ order : Order)
    {
        lbTitle.text = order.getStatusTitle()
        btStatus.isHidden = order.endState();
    }
}

