//
//  RatingView.swift
//  LimeBook
//
//  Created by Lê Dũng on 10/6/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit
import SwiftyStarRatingView
class RatingView: GreenView {

    @IBOutlet weak var rateView: SwiftyStarRatingView!
    @IBOutlet weak var lbTitle: UILabel!
    var title = ""
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func initStyle() {
    
        lbTitle.textColor  = template.generalTextColor
        rateView.tintColor = template.sellColor
        rateView.addTarget(self, action: #selector(startChange), for: .valueChanged)

    }
    
    @objc func startChange()
    {
        
        let start = " " + String(Double(rateView.value))
        
    
        let attr = NSMutableAttributedString.init(string: self.title)
        let attributedStringColor = [NSAttributedStringKey.foregroundColor : template.sellColor,NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 14)];
        let attributedString = NSAttributedString(string: start, attributes: attributedStringColor)
        
        attr.append(attributedString)
        lbTitle.attributedText = attr
    }
    
    func set(_ title : String)
    {
        self.title = title;
        lbTitle.text = title;
    }

}
