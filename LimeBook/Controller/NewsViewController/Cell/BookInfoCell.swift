//
//  BookInfoCell.swift
//  LimeBook
//
//  Created by Lê Dũng on 9/30/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit
class BookInfoCell: BookMasterCell{

    
    @IBOutlet weak var firstFeeling: FeelingCell!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = template.backgroundColor
        selectionStyle = .none
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override func set(_ book : Book, _ indexPath : IndexPath)
    {
        super.set(book, indexPath)
        self.updateData()
        if(book.canDraw)
        {
            self.drawProcess()
        }
    }
    
    
    func updateData()
    {
        
        bookInfoView.set(self.book)
        lbName.text = book.title
        if(!self.book.isDrawFelling)
        {
            feelingView.clearSequence()
        }
        else
        {
            self.feelingView.setSequence(self.book.feeling)
        }
        self.firstFeeling.set(self.book.feeling_target)
    }
    
    @IBAction func rateTouch(_ sender: Any) {
        if(self.book.isDrawFelling)
        {
            self.book.needToDrawFirstFeel = false;
            self.book.isDrawFelling = false
            self.feelingView.clearSequence()
            self.delegate.bookInfoUpdateScrollToTop(self.indexPath)
        }
        else
        {
            self.book.needToDrawFirstFeel = false;
            self.book.isDrawFelling = true
            self.book.feeling.removeAll()
            self.book.loadFeeling {
                self.book.isDrawFelling = true;
                self.feelingView.setSequence(self.book.feeling)
                self.delegate.bookInfoUpdateScrollToTop(self.indexPath)
            }
        }
    }

}
