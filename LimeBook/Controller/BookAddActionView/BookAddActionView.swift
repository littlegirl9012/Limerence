//
//  BookAddActionView.swift
//  LimeBook
//
//  Created by Lê Dũng on 11/11/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit
protocol BookAddActionViewDelegate : class {
    func bookAddFromMibook()
    func bookAddGeneral()
}


class BookAddActionView: GreenView
{
    
    @IBOutlet weak var btClose: UIButton!
    @IBOutlet weak var btGeneral: UIButton!
    @IBOutlet weak var btLibrary: UIButton!
    
    weak var delegate : BookAddActionViewDelegate?
    override func initStyle() {
        btClose.setTitleColor(template.dangerColor, for: .normal)
        btGeneral.setTitleColor(template.primaryColor, for: .normal)
        btLibrary.setTitleColor(template.primaryColor, for: .normal)
        view.backgroundColor = UIColor.white
        drawRadius(4)
    }
    @IBAction func libraryTouch(_ sender: Any)
    {
        delegate?.bookAddFromMibook()
    }
    @IBAction func generalTouch(_ sender: Any)
    {
        delegate?.bookAddGeneral()
    }
    @IBAction func closeTouch(_ sender: Any)
    {
        superview!.hideAlertBox()
    }
    
}
