//
//  TraddingView.swift
//  LimeBook
//
//  Created by Lê Dũng on 10/9/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class TraddingView: MasterPostView , RadioViewDelegate{

    var buyPost : BuyPostView!
    var sellPost : SellPostView!
    var masterPost : MasterPostView!
    
    @IBOutlet weak var drawView: UIView!
    @IBOutlet weak var radioSell: RadioView!
    @IBOutlet weak var radioBuy: RadioView!

    override func initStyle() {
        radioBuy.set(false, "Mua sách")
        radioSell.set(false, "Bán sách")
        radioBuy.delegate = self;
        radioSell.delegate = self;
    }
    
    func uncheckAll()
    {
        radioSell.uncheck()
        radioBuy.uncheck()
    }
    func reloadAll()
    {
        drawView.removeSubsView()
    }

    func actvieView(_ value : UIView)
    {
        self.masterPost = (value as! MasterPostView)
        reloadAll()
        drawView.addSubview(value)
        drawView.setLayout(value)
    }

    func radioChangeState(_ value: Bool, sender: RadioView) {
        uncheckAll()
        sender.check()
        if(sender == radioBuy)
        {
            if(buyPost == nil)
            {
                buyPost = BuyPostView.init(frame: CGRect.init())
            }
            actvieView(buyPost)
        }
        else
        {
            if(sellPost == nil)
            {
                sellPost = SellPostView.init(frame: CGRect.init())
            }

            actvieView(sellPost)
        }
    }
    
    override func getPostPakage() -> (Mi, [ImageSelect])? {
        if(radioSell.isCheck)
        {
            return sellPost.getPostPakage()
        }
        if(radioBuy.isCheck)
        {
            return buyPost.getPostPakage()
        }
        return nil
    }
}
