//
//  UserImageView.swift
//  LimeBook
//
//  Created by Lê Dũng on 8/20/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit
import  AlamofireImage




class UserImageViewMe: GreenView {

    @IBOutlet weak var imgView: UIImageView!
    
    override func initStyle() {
        
        self.drawRound()
        view.backgroundColor = template.primaryColor
        lbName.text = ""
        
        drawImage()
    }
    
    func drawImage()
    {
        if(userInstance.user.mediaAvatar.content != nil)
        {
            imgView.image = userInstance.user.mediaAvatar.content as! UIImage
        }

    }
    @IBOutlet weak var lbName: UILabel!


}
