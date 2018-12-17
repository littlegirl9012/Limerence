//
//  GenderInputView.swift
//  Mobile_68
//
//  Created by Lê Dũng on 7/7/18.
//  Copyright © 2018 Ledung. All rights reserved.
//

import UIKit

protocol GIVDelegate {
    func givDidSelect(_ genderValue : Int)
}


class GenderInputView: GreenView {

    @IBOutlet weak var shadowView: UIView!
    
    var delegate : GIVDelegate!
    
    
    override func initStyle() {
        //shadowView.dropShadow()
    }
    
    
    
    @IBAction func rightTouch(_ sender: Any)
    {
        delegate.givDidSelect(1)
    
    }
    
    @IBAction func lefTouch(_ sender: Any) {
        delegate.givDidSelect(0)

    }


}
