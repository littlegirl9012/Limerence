//
//  BookTakeView.swift
//  LimeBook
//
//  Created by Lê Dũng on 11/17/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit
enum BookTakeType
{
    case review
    case take
}
protocol BookTakeDelegate : class
{
    func bookTakeAgree(_ value : Book)
    func bookTakeClose()
}

class BookTakeView: GreenView {

    weak var delegate : BookTakeDelegate?
    weak var book : Book!
    override func initStyle() {
        view.backgroundColor = UIColor.white
        drawRadius(4)
    }
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lbAuthor: UILabel!
    @IBOutlet weak var lbTitle: UILabel!
    @IBAction func acceptTouch(_ sender: Any) {
        delegate?.bookTakeAgree(self.book)
    }
    
    
    func set(_ value : Book)
    {
        self.book = value
        self.imgView.setSD(value.image)
        self.lbTitle.text = value.title
        self.lbAuthor.text = value.author
    }
    
    @IBAction func cancelTouch(_ sender: Any)
    {
        delegate?.bookTakeClose()
    }
    
    deinit {
        print("---------------Deinit)")
    }
}
