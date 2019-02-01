//
//  BookRefHeaderView.swift
//  MiBook
//
//  Created by Lê Dũng on 1/20/19.
//  Copyright © 2019 limerence. All rights reserved.
//

import UIKit


protocol BookRefHeaderViewDelegate : class
{
    func bookRefHeaderViewTouchIn(_ section : Int)
}
class BookRefHeaderView: GreenView {
    @IBOutlet weak var contentView: UIView!
    var section : Int! ;
    weak var delegate : BookRefHeaderViewDelegate?
    @IBOutlet weak var rightView: UIView!
    
    @IBOutlet weak var btAdd: UIButton!
    override func initStyle() {
        backgroundColor = template.backgroundColor
        btAdd.setTitleColor(template.primaryColor, for: .normal)
        view.backgroundColor = template.backgroundColor
    }
    @IBAction func touchIn(_ sender: Any) {
        delegate?.bookRefHeaderViewTouchIn(section)
    }
    
    func set(_title : String , section : Int)
    {
        self.section = section
        self.btAdd.setTitle(_title, for: .normal)
    }
    
    func hidenRightView()
    {
        rightView.isHidden = true
    }
}
