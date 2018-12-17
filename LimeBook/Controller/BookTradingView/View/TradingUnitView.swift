//
//  TradingUnitView.swift
//  MiBook
//
//  Created by Lê Dũng on 12/9/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class TradingUnitView: GreenView {
    
    @IBOutlet weak var lbContent: UILabel!
    @IBOutlet weak var lbTitle: UILabel!
    func setTitle(_ value  : String )
    {
        lbTitle.text = value
    }
    func setContent(_ value  : String )
    {
        lbContent.text = value
    }

}
