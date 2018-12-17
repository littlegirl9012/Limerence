//
//  CommunicateTopView.swift
//  LimeBook
//
//  Created by Lê Dũng on 12/2/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit
protocol CommunicateTopViewDelegate : class {
    func communicateChangePage(_ index : Int)
    func communicateAddTouch()

}

class CommunicateTopView: GreenView {


    weak var delegate : CommunicateTopViewDelegate?

    @IBOutlet weak var btConver: UIButton!
    @IBOutlet weak var btContact: UIButton!
    @IBOutlet weak var btAdd: UIButton!

    var index = 0

    override func initStyle() {
        view.backgroundColor =   "44424A".hexColor()
        
        converStyle()
    }
    
    func contactStyle()
    {
        btConver.alpha = 0.5
        btContact.alpha = 1
    }
    
    func converStyle()
    {
        btContact.alpha = 0.5
        btConver.alpha = 1
    }

    @IBAction func addTouch(_ sender: Any)
    {
        delegate?.communicateAddTouch()
    }
    @IBAction func converTouch(_ sender: Any)
    {
        if(index == 0)
        {
            return
        }
        index = 0
        converStyle()
        delegate?.communicateChangePage(index)
    }
    
    
    @IBAction func contactTouch(_ sender: Any) {
        if(index == 1)
        {
            return;
        }
        index = 1
        contactStyle()
        delegate?.communicateChangePage(index)

    }
}
