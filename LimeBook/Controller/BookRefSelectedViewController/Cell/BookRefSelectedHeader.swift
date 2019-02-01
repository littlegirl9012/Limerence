//
//  BookRefSelectedHeader.swift
//  MiBook
//
//  Created by Lê Dũng on 1/24/19.
//  Copyright © 2019 limerence. All rights reserved.
//

import UIKit
protocol BookRefSelectedHeaderDelegate : class{
    func BookRefSelectedHeaderTouchin(_ value : BookReference)
}

class BookRefSelectedHeader: GreenView {

    weak var delegate : BookRefSelectedHeaderDelegate?
    @IBOutlet weak var lbTitle: UILabel!
    var bookRefer : BookReference!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBAction func touchin(_ sender: Any) {
        delegate?.BookRefSelectedHeaderTouchin(self.bookRefer)
        
    }
    
    func set(_ bookRefer : BookReference)
    {
        self.bookRefer = bookRefer
        lbTitle.text = bookRefer.name
        
        if(bookRefer.isSelected)
        {
            lbTitle.font = UIFont.boldSystemFont(ofSize: 14)
            lbTitle.textColor = template.sellColor
        }
        else
        {
            lbTitle.font = UIFont.systemFont(ofSize: 14)
            lbTitle.textColor = .black
        }
    }
}
