//
//  CartAddressCell.swift
//  MiBook
//
//  Created by Lê Dũng on 1/9/19.
//  Copyright © 2019 limerence. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

protocol CartAddressCellDelegate : class {
    func cartAddressCellTouchAddress()
    func cartAddressChangePhone(_ value : String)
}

class CartAddressCell: UITableViewCell {

    weak var delegate : CartAddressCellDelegate?
    @IBOutlet weak var lbTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = template.backgroundColor;
        lbTitle.textColor = template.primaryColor
        lbTitle.text = "Thôn tin liên lạc"
        lbAddress.text = ""
        selectionStyle = .none

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBOutlet weak var lbAddress: UILabel!
    @IBAction func addressTouch(_ sender: Any) {
        delegate?.cartAddressCellTouchAddress()
    }
    @IBOutlet weak var tfPhone: UITextField!
    
    func setPlace(_ gmsPlace : GMSPlace?)
    {
        if(gmsPlace != nil)
        {
            lbAddress.text = gmsPlace!.formattedAddress
        }
    }
    @IBAction func tfChange(_ sender: Any) {
        delegate?.cartAddressChangePhone(tfPhone.text?.trim() ?? "")
    }
    
}
