//
//  BookDetailTradingView.swift
//  MiBook
//
//  Created by Lê Dũng on 12/28/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class BookDetailTradingView: GreenView {
    @IBOutlet weak var tvContent: UITextView!
    @IBOutlet weak var tfPrice: UITextField!
    @IBOutlet weak var priceView: UIView!
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func initStyle() {
        tvContent.drawRadius(4, color: template.subTextColor, thickness: 0.5)
        priceView.drawRadius(4, color: template.subTextColor, thickness: 0.5)

    }

}
