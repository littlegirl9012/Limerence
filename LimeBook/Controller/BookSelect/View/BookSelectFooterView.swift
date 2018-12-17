//
//  BookSelectFooterView.swift
//  LimeBook
//
//  Created by Lê Dũng on 12/1/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

protocol BookSelectFooterViewDelegate: class
{
    func bookSelectFooterViewAdd()
}


class BookSelectFooterView: GreenView {

    
    weak var delegate : BookSelectFooterViewDelegate?
    @IBOutlet weak var btAdd: UIButton!
    @IBOutlet weak var lbNote: UILabel!

    override func initStyle() {
        lbNote.textColor = template.generalTextColor
        btAdd.setTitleColor(template.sellColor, for: .normal)
    }
    
    @IBAction func addTouch(_ sender: Any) {
        delegate?.bookSelectFooterViewAdd()
    }
    
}
