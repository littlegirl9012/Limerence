//
//  EmojCell.swift
//  LimeBook
//
//  Created by Lê Dũng on 8/20/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class EmojCell: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func set(_ emoj : EmojiTextAttachment)
    {
        imgView.image = emoj.image
    }
}
