//
//  PostNoteView.swift
//  LimeBook
//
//  Created by Lê Dũng on 10/1/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class PostNoteView: GreenView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    @IBOutlet weak var lbTitle: UILabel!
    
    func set(_ title : String)
    {
        lbTitle.text = title;
    }
}
