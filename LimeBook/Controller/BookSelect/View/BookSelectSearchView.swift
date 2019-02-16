//
//  BookSelectSearchView.swift
//  MiBook
//
//  Created by Lê Dũng on 2/11/19.
//  Copyright © 2019 limerence. All rights reserved.
//

import UIKit

class ButtonSelectSearch : UIButton
{
    override func awakeFromNib() {
        setTitleColor(template.primaryColor, for: .normal)
    }
}



protocol BookSelectSearchViewDelegate : class
{
    func BookSelectSearchViewTake(_ book : Book)
    func BookSelectSearchViewCompare(_ book : Book)
    func BookSelectSearchViewOwner(_ book : Book)
    func BookSelectSearchViewDetail(_ book : Book)
    func BookSelectSearchViewClose()
}

class BookSelectSearchView: GreenView {

    @IBOutlet weak var imgView: BookImageView!
    @IBOutlet weak var lbAuthor: UILabel!
    @IBOutlet weak var lbTitle: UILabel!
    
    weak var delegate  : BookSelectSearchViewDelegate?
    @IBOutlet weak var btClose: ButtonSelectSearch!
    @IBOutlet weak var btDetail: ButtonSelectSearch!
    @IBOutlet weak var btOwner: ButtonSelectSearch!
    @IBOutlet weak var btPrice: ButtonSelectSearch!
    @IBOutlet weak var btAdd: ButtonSelectSearch!
    override func initStyle() {
        btClose.setTitleColor(template.dangerColor, for: .normal)
        
        drawRadius(4)
    }

    
    var book : Book!
    func set(_ book : Book)
    {
        self.book = book;
        lbTitle.textR = book.title
        lbAuthor.textR = book.author
        imgView.set(book.image)
    }
    
    @IBAction func takeTouch(_ sender: Any)
    {
        delegate?.BookSelectSearchViewTake(book)
    }
    
    @IBAction func compareTouch(_ sender: Any)
    {
        delegate?.BookSelectSearchViewCompare(book)

    }
    
    @IBAction func ownerTouch(_ sender: Any)
    {
        delegate?.BookSelectSearchViewOwner(book)

    }
    @IBAction func detailTouch(_ sender: Any)
    {
        delegate?.BookSelectSearchViewDetail(book)

    }
    @IBAction func closeTOuch(_ sender: Any) {
        delegate?.BookSelectSearchViewClose()
    }
    
}
