//
//  FeelingCell.swift
//  LimeBook
//
//  Created by Lê Dũng on 10/3/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class FeelingCell: GreenView {

    @IBOutlet weak var userImageView: UserImageView!
    @IBOutlet weak var lbUsername: UILabel!
    @IBOutlet weak var lb0: UILabel!
    @IBOutlet weak var lb1: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lbDes: UILabel!
    
    func set(_ value : Feelling)
    {
        lbUsername.text = value.aliasname
        userImageView.set(value.aliasname, url: value.avatar)
        lb0.attributedText = value.attributeContent
        lb1.attributedText = value.attributeNote
        let url = URL.init(string: value.image)
        if(url != nil)
        {
            imgView.af_setImage(withURL: url!)
        }
        else
        {
            imgView.image = nil
        }
    }
    
    override func initStyle() {
        lb0.text = ""
        lb1.text = ""
        lbUsername.text = ""


    }

}
