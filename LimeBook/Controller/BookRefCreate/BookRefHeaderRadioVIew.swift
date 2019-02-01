//
//  BookRefHeaderRadioVIew.swift
//  MiBook
//
//  Created by Lê Dũng on 1/25/19.
//  Copyright © 2019 limerence. All rights reserved.
//

import UIKit

protocol BookRefHeaderRadioVIewDelegate : class {
    func BookRefHeaderRadioVIewChangeState(_ state : RefType)
}

class BookRefHeaderRadioVIew: GreenView , RadioViewDelegate{
    @IBOutlet weak var giftView: RadioView!
    @IBOutlet weak var buyView: RadioView!
    
    
    
    var refType = RefType.gift
    
    weak var delegate : BookRefHeaderRadioVIewDelegate?
    
    override func initStyle() {
        giftView.delegate = self;
        buyView.delegate = self;
        giftView.set(true, "Cho, tặng")
        buyView.set(false, "Bán lại")
        view.backgroundColor = template.backgroundColor
    }
    func disableAll()
    {
        giftView.uncheck()
        buyView.uncheck()
    }
    
    func radioChangeState(_ value: Bool, sender: RadioView) {
        disableAll()
        sender.check()
        if(sender == giftView)
        {
            refType = .gift
            delegate?.BookRefHeaderRadioVIewChangeState(.gift)
        }
        else
        {
            refType = .trading
            delegate?.BookRefHeaderRadioVIewChangeState(.trading)
        }
    }
}
