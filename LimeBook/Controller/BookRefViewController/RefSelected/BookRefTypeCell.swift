//
//  ProvinceCell.swift
//  Mobile_68
//
//  Created by Lê Dũng on 7/19/18.
//  Copyright © 2018 Ledung. All rights reserved.
//

import UIKit

protocol BookRefTypeCellDelegate {
    func provinceCellDidSelect(_ value : DHMProvince)
}
class BookRefTypeCell: UITableViewCell {

    var delegate : ProvinceCellDelegate!
    
    var prov : DHMProvince!
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = template.backgroundColor
        backgroundColor = template.backgroundColor

    }
    @IBAction func userTouch(_ sender: Any) {
        delegate.provinceCellDidSelect(self.prov)
    }
    
    @IBOutlet weak var lbProvince: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(_ province : DHMProvince)
    {
        self.prov = province
        lbProvince.text = province.name.capitalized
        
        if(province.IsSelect)
        {
            lbProvince.font = UIFont.init(name: "AvenirNext-Medium", size: 16)
            lbProvince.textColor = template.primaryColor
        }
        else
        {
            lbProvince.font = UIFont.init(name: "AvenirNext-Regular", size: 16)
            lbProvince.textColor = .black
        }

    }
}
