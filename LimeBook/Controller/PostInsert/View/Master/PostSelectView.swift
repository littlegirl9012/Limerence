//
//  PostSelectView.swift
//  LimeBook
//
//  Created by Lê Dũng on 10/6/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit



enum PostSelectType : Int
{
    case clear = 0
    case select = -1
}

protocol PostSelectViewDelegate {
    func postSelectViewInvoke(_ type : PostSelectType, sender : PostSelectView)
}

class PostSelectView: GreenView {

    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var rightBt: UIButton!
    var delegate : PostSelectViewDelegate!
    var _type : PostSelectType = .select
    
    func clearType()
    {
        rightBt.setImage("delete-cross".image().tint(template.warningColor), for: .normal)
    }
    func selectType()
    {
        rightBt.setImage("Next".image().tint(template.subTextColor), for: .normal)
    }
    
    func setType(_ typ : PostSelectType)
    {
        self._type = typ;
        if(typ == .clear)
        {
            clearType()
        }
        else
        {
            selectType()
        }
    }
    
    func set(title : String)
    {
        lbTitle.text = title;
        lbTitle.textColor = template.generalTextColor

    }
    @IBAction func centerTouch(_ sender: Any) {
        delegate.postSelectViewInvoke(.select, sender: self)
    }
    
    func set(_ plaholder : String)
    {
        lbTitle.text = plaholder;
        lbTitle.textColor = template.subTextColor
    }
    
    
    @IBAction func tightTouch(_ sender: Any)
    {
        delegate.postSelectViewInvoke(_type, sender: self)
    }
    
    override func initStyle() {
        
    }
}
