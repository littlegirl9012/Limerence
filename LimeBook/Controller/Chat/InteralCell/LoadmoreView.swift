//
//  LoadmoreView.swift
//  LimeBook
//
//  Created by Lê Dũng on 9/1/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

protocol LoadmoreViewDelegate : class
{
    func loadmoreDidSelect()
    
}
class LoadmoreView: GreenView {
    @IBOutlet weak var lbTitle: UILabel!
    
    @IBOutlet weak var contentView: UIView!
    
    weak var delegate : LoadmoreViewDelegate?
    override func initStyle() {
        contentView.drawRadius(12)
        view.backgroundColor = UIColor.white
    }
    
    
    func bgColor(_ value : UIColor)
    {
        view.backgroundColor = value

    }
    
    @IBAction func touchIn(_ sender: Any) {
        delegate?.loadmoreDidSelect()
    }
    
    func setTitle(_ value : String)
    {
        lbTitle.text = value;
    }
    

}
