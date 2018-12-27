//
//  LegancyView.swift
//  MiBook
//
//  Created by Lê Dũng on 12/12/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit
import WebKit
protocol LegancyViewDelegate :class
{
    func LegancyViewDidClose()
}

class LegancyView: GreenView, RadioViewDelegate {
    
    weak var delegate : LegancyViewDelegate?
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var btClose: ButtonSuccess!
    @IBOutlet weak var rView: RadioView!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBAction func closeAction(_ sender: Any) {
        
        delegate?.LegancyViewDidClose()
    }
    
    override func initStyle() {
        rView.lbTitle.text = "Đồng ý điều khoản sử dụng"
        rView.set("select_box".image(), _imgUncheck: "unselect_box".image())
        drawRadius(4)
        rView.uncheck()
        rView.font(UIFont.systemFont(ofSize: 14));
        rView.delegate = self;
        btClose.backgroundColor = UIColor.lightGray

    }
    
    func radioChangeState(_ value: Bool, sender: RadioView) {
        userInstance.acceptLagency(value)
        btClose.isEnabled = value
        if(value)
        {
            btClose.backgroundColor = template.primaryColor
        }
        else
        {
            btClose.backgroundColor = UIColor.lightGray
        }
        
        
    }
    

}
