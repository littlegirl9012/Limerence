//
//  MKCell.swift
//  MiBook
//
//  Created by Lê Dũng on 1/9/19.
//  Copyright © 2019 limerence. All rights reserved.
//

import UIKit

class MKCell: UITableViewCell {

    private var node : MKNode!
    private var isHeader = false ;
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }
    
    
    init(header : Bool)
    {
        super.init(style: .default, reuseIdentifier: "Header")
        isHeader = true ;
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setElement(_ element : [MKNode])
    {
        if(node == nil)
        {
            node = MKNode.init(element, type: .x)
            node.setCantouchZ(isHeader)
            node.drawView = contentView
            node.draw()
        }
    }
    
    func setReference(_ header : MKCell)
    {
        node.mirrow(header.node)
    }

}
