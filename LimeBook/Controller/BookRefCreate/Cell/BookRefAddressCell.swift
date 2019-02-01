//
//  BookRefAddressCell.swift
//  MiBook
//
//  Created by Lê Dũng on 1/23/19.
//  Copyright © 2019 limerence. All rights reserved.
//

import UIKit

protocol BookRefAddressCellDelegate : class {
    func BookRefAddressCellSelectAddress()
    func BookRefAddressCellSelectChangePhone(_ vallue : String)
    
}

class BookRefAddressCell: UITableViewCell {
    
    weak var delegate : BookRefAddressCellDelegate?
    
    @IBOutlet weak var tfPhone: UITextField!
    
    
    @IBAction func phoneChange(_ sender: Any) {
        delegate?.BookRefAddressCellSelectChangePhone(tfPhone.text!)
    }
    
    @IBOutlet weak var lbAddress: UILabel!
    @IBOutlet weak var lbPhone: UILabel!
    @IBOutlet weak var lbName: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        tfPhone.text = userInstance.user.phone
        contentView.backgroundColor = template.backgroundColor
    }
    
    func hidenRightButton()
    {
        
    }

    
    func set(province : DHMProvince?,district : DHMDistrict?)
    {
        if(province != nil)
        {
            lbAddress.text = province!.name + ", " + district!.name
            lbAddress.textColor = UIColor.black
        }
        else
        {
            lbAddress.text = "Địa phương"
            lbAddress.textColor = template.sellColor
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func touchInAddress(_ sender: Any) {
        delegate?.BookRefAddressCellSelectAddress()
    }
}
