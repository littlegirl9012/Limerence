//
//  BookTradingView.swift
//  MiBook
//
//  Created by Lê Dũng on 12/9/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit
protocol BookTradingViewDelegate : class {
    func bookTradingAddSuccess()
}

class BookTradingView: GreenView {
    
    weak var delegate : BookTradingViewDelegate?
    
    @IBOutlet weak var catField: TradingUnitView!
    @IBOutlet weak var stateView: TradingUnitView!
    @IBOutlet weak var priceField: TradingUnitView!
    @IBOutlet weak var sellPriceField: TradingUnitView!
    @IBOutlet weak var sellerField: TradingUnitView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbAuthor: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var btAdd: UIButton!
    @IBOutlet weak var btClose: UIButton!

    
    var book : Book!
    override func initStyle() {
        catField.setTitle("Danh mục")
        stateView.setTitle("Tình trạng")
        priceField.setTitle("Giá bìa")
        sellPriceField.setTitle("Giá bán lại")
        sellerField.setTitle("Người bán")
        
        btAdd.setTitleColor(template.primaryColor, for: .normal)
        btClose.setTitleColor(template.dangerColor, for: .normal)

    }
    deinit {
        print("Deinit Trading View");
    }

    func setBook(_ value : Book)
    {
        self.book = value ;
        catField.setContent("-")
        stateView.setContent("Sách cũ")
        priceField.setContent("-")
        sellPriceField.setContent(book.price.priceValue())
        sellerField.setContent(book.aliasname)
        lbTitle.text = book.title
        lbAuthor.text = book.author
        imgView.setSD(book.image)
    }
    @IBAction func addTouch(_ sender: Any)
    {
        delegate?.bookTradingAddSuccess()
        cart.addProduct(self.book)
    }
    @IBAction func closeTouch(_ sender: Any) {
        superview!.hideAlertBox()
    }
    
}
