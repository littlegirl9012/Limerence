//
//  OrderChangeStateView.swift
//  MiBook
//
//  Created by Lê Dũng on 1/15/19.
//  Copyright © 2019 limerence. All rights reserved.
//

import UIKit

protocol OrderChangeStateViewDelegate : class
{
    func orderChangeStateViewAccept()
    func orderChangeStateViewDeny()
    func orderChangeStateViewClose()
    func orderChangeStateViewSuccess()



}

class OrderChangeStateView: GreenView {
    @IBOutlet weak var topView: UIView!
    weak var delegate : OrderChangeStateViewDelegate?
    @IBOutlet weak var btClose: UIButton!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var btAccept: UIButton!
    
    override func initStyle() {
        topView.backgroundColor = .white
        btClose.setTitleColor(template.dangerColor, for: .normal)
        lbTitle.textColor = template.primaryColor

        drawRadius(4)
    }
    
    @IBAction func closeTouch(_ sender: Any) {
        delegate?.orderChangeStateViewClose()
    }
    @IBAction func denyTouch(_ sender: Any) {
        delegate?.orderChangeStateViewDeny()
    }
    @IBAction func acceptTouch(_ sender: Any) {
        delegate?.orderChangeStateViewAccept()
    }
    @IBAction func sucessTouch(_ sender: Any) {
        delegate?.orderChangeStateViewSuccess()
    }
}
