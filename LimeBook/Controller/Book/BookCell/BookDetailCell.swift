//
//  BookDetailCell.swift
//  LimeBook
//
//  Created by Lê Dũng on 9/6/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit


protocol BookUnitViewDelegate : class {
    func bookUnitUserTouch(_ id : Int)
}

class BookUnitCell: UITableViewCell {
    
    weak var delegate : BookUnitViewDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func set(_ book : Book)
    {
        
    }

}


class BookDetailCell: BookUnitCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lbState: UILabel!
    
    @IBOutlet weak var stateView: UIView!
    @IBOutlet weak var imgContent: ImageDisplayView!

    override func awakeFromNib() {
        super.awakeFromNib()

        contentView.backgroundColor = template.backgroundColor
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBOutlet weak var lbPrice: UILabel!
    
    @IBOutlet weak var lbAuthor: UILabel!
    @IBOutlet weak var lbName: UILabel!
    override func set(_ book: Book) {
        stateView.drawRadius(3)
        imgContent.dropShadow()
        mainView.dropShadow()
        lbName.text = book.title.uppercased()
        lbAuthor.text = book.author.capitalizingFirstLetter()
        stateView.isHidden = !book.isShowViewState()
        stateView.backgroundColor = book.stateColor()
        lbState.text = book.stateTitle()
        
        imgContent.set(book.media_model)
        
        lbPrice.isHidden  = !(book.book_type_n == .sell)
        lbPrice.text  = book.price.priceValue()
        
    }
}
