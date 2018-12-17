//
//  ImageGroupCell.swift
//  LimeBook
//
//  Created by Lê Dũng on 8/31/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class ImageGroupCell: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var scrView: UIScrollView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func set(_ media : MediaFile)
    {
        imgView.setMediaFile(media)
    }

}
