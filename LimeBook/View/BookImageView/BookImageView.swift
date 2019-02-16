//
//  BookImageView.swift
//  MiBook
//
//  Created by Lê Dũng on 2/15/19.
//  Copyright © 2019 limerence. All rights reserved.
//

import UIKit

class BookImageView: GreenView {

    @IBOutlet weak var imgView: UIImageView!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    func set(_ urlString : String)
    {
        imgView.setSD(urlString)
    }
}
