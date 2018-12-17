//
//  FeelingListCell.swift
//  LimeBook
//
//  Created by Lê Dũng on 10/11/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit
import AlamofireImage
class FeelingListCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        imgView.drawRound()
    }
    
    @IBOutlet weak var imgView: UIImageView!
    
    func set(_ fl : Feelling)
    {
        let url = URL.init(string: fl.avatar)
        if(url != nil)
        {
            imgView.af_setImage(withURL: url!)
        }
        else
        {
            imgView.image = nil
        }
    }
    
    
}
