//
//  DrawCell.swift
//  MiBook
//
//  Created by Lê Dũng on 1/8/19.
//  Copyright © 2019 limerence. All rights reserved.
//

import UIKit

class DrawCell: MKCell {

    func updateHeader()
    {
        let customView = UIView.init()
        customView.backgroundColor = UIColor.red
        let A1 = MKNode.init(customView)///
        let A2 = MKNode.init("header 2")///
        let A3 = MKNode.init("header 3")///
        let A = MKNode.init([A1,A2,A3], type: .z)
        let B = MKNode.init("B")

        setElement([A,B])
    }
    
    func setObject()
    {
        let A1 = MKNode.init("content 1")///
        let A2 = MKNode.init("content 2")///
        let A3 = MKNode.init("content 3")///
        let A = MKNode.init([A1,A2,A3], type: .z)
        let B = MKNode.init("B")
        setElement([A,B])
    }
    
}
