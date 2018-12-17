//
//  UserCell.swift
//  LimeBook
//
//  Created by Lê Dũng on 8/18/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit



protocol ContactCellDelegate
{
    func contactCellAccept(_ user : User)
    func contactCellDeny(_ user : User)
    func contactCellCancel(_ user : User)

}

class ContactCell: UITableViewCell {

    var delegate : ContactCellDelegate!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b1View: UIView!
    @IBOutlet weak var bt1: UIButton!
    @IBOutlet weak var statusCell: UIView!
    @IBOutlet weak var imgView: UserImageView!
    @IBOutlet weak var lbName: UILabel!
    
    var user : User!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imgView.drawRound()
        statusCell.isHidden = true ;
        statusCell.drawRound()
        statusCell.backgroundColor = template.highlightTextColor
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func set(_ user : User)
    {
        self.user = user;
        lbName.text = user.aliasname
        imgView.set(user.aliasname, url: user.avatar)
        
        user.isOnline ? setOnline() : setOffline();
        
        
        if(user.status == 1)
        {
            cancelStyle()
        }
        else if (user.status == 2)
        {
            acceptStyle()
        }
        else
        {
            b2.isHidden = true
            bt1.isHidden = true
        }
    }
    
    
    func acceptStyle()
    {
        b2.set(title: "Huỷ")
        b2.backgroundColor = template.dangerColor
        bt1.set(title: "Chấp nhận")
        bt1.backgroundColor = template.primaryColor
        b2.isHidden = false
        bt1.isHidden = false

    }
    
    func cancelStyle()
    {
        bt1.set(title: "Huỷ")
        bt1.isHidden = false;
        bt1.backgroundColor = template.dangerColor

        b2.isHidden = true;
        
    }
    
    
    func setOnline()
    {
        statusCell.isHidden = false ;
    }
    
    func setOffline()
    {
        statusCell.isHidden = true ;

    }
    @IBAction func b2Touch(_ sender: Any)
    {
        delegate.contactCellDeny(self.user)
    }
    
    @IBAction func b1Touch(_ sender: Any) {
        if(user.status == 1)
        {
            delegate.contactCellCancel(self.user)
        }
        if(user.status  == 2)
        {
            delegate.contactCellAccept(self.user)
        }
    }
}
