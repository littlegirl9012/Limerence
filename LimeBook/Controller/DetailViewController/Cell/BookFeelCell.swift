//
//  BookFeelCell.swift
//  LimeBook
//
//  Created by Lê Dũng on 10/14/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

protocol BookFeelCellDelegate : class {
    func bookFeelCellTouch(_ feel : Feelling)
}

class BookFeelCell: UITableViewCell {

    weak var delegate : BookFeelCellDelegate?
    @IBOutlet weak var mainView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var lbTitle: UILabel!
    
    var feel : Feelling?
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lbNote: UILabel!
    @IBOutlet weak var lbContent: UILabel!
    @IBOutlet weak var userImageView: UserImageView!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        contentView.backgroundColor = template.backgroundColor
        mainView.backgroundColor = UIColor.white
    }
    
    @IBAction func touchIn(_ sender: Any)
    {
        delegate?.bookFeelCellTouch(self.feel!)
    }
    func set(_ value : Feelling)
    {
        self.feel = value
        lbTitle.text = value.aliasname
        userImageView.set(value.aliasname, url: value.avatar)
        lbContent.attributedText = value.attributeContent
        lbNote.attributedText = value.attributeNote
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
    
}
