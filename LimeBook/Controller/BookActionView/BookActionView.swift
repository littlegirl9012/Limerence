//
//  BookActionVIew.swift
//  LimeBook
//
//  Created by Lê Dũng on 11/9/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

protocol BookActionViewDelegate : class {
    func bookActionTake()
    func bookActionUserList()
}
class BookActionView: GreenView {

    @IBOutlet weak var btExit: UIButton!
    @IBOutlet weak var btList: UIButton!
    @IBOutlet weak var btAdd: UIButton!
    @IBOutlet weak var lbAuthor: UILabel!
    @IBOutlet weak var lbTitle: UILabel!
    
    weak var delegate : BookActionViewDelegate?
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBOutlet weak var imgView: ImageDisplayView!
    override func initStyle() {
        view.backgroundColor = UIColor.white
        drawRadius(4)
    }
    
    func set(_ book : Book)
    {
        lbTitle.text = book.title
        
        btAdd.setTitleColor(template.primaryColor, for: .normal)
        btList.setTitleColor(template.primaryColor, for: .normal)
        btExit.setTitleColor(template.sellColor, for: .normal)

    }
    
    
    @IBAction func addTouch(_ sender: Any)
    {
        delegate?.bookActionTake()
        superview!.hideAlertBox()

    }
    
    @IBAction func userTouch(_ sender: Any)
    {
        delegate?.bookActionUserList()
        superview!.hideAlertBox()
    }
    
    @IBAction func closeTouch(_ sender: Any)
    {
        superview!.hideAlertBox()
    }
}
