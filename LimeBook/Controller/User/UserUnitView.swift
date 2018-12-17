//
//  UserUnitVIew.swift
//  LimeBook
//
//  Created by Lê Dũng on 8/22/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class UserUnitView: GreenView {

    @IBOutlet weak var lbLine: UIView!
    @IBOutlet weak var lbValue: UILabel!
    @IBOutlet weak var lbName: UILabel!
    
    var actionBlock  : (()->Void)!
    override func initStyle() {
        lbName.textColor = template.generalTextColor
        lbValue.textColor = template.subTextColor
        
        lbLine.backgroundColor = template.subTextColor
        lbLine.alpha = 0.24
        
        lbName.text = ""
        lbValue.text = ""
        
        view.backgroundColor = UIColor.white
    }
    
    @IBAction func touchIn(_ sender: Any)
    {
        if(actionBlock != nil)
        {
            actionBlock();
        }
    }
    
    func setTouch(_ action : @escaping (()->Void))
    {
        self.actionBlock = action;
    }
    func set( _ name : String, _ value : String)
    {
        lbName.text = name;
        lbValue.text = value
    }
    
    func setColor(_ value : UIColor)
    {
        lbName.textColor = value;
    }

}
