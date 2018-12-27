//
//  ReportView.swift
//  MiBook
//
//  Created by Lê Dũng on 12/14/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

protocol ReportViewDelegate : class {
    func reportViewDidSend(_ content : String)
    func reportViewDidClose()
}

class ReportView: GreenView {

    @IBOutlet weak var tvContent: UITextView!
    
    weak var delegate  : ReportViewDelegate?
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    @IBAction func closeTouch(_ sender: Any) {
        delegate?.reportViewDidClose()
    }
    @IBAction func sendTouch(_ sender: Any) {
        delegate?.reportViewDidSend(self.tvContent.text)
    }
    
    override func initStyle() {
        self.backgroundColor = UIColor.white
        drawRadius(4)
    }
}
