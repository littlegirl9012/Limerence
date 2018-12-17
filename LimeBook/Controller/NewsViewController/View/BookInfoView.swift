//
//  BookInfoView.swift
//  LimeBook
//
//  Created by Lê Dũng on 9/30/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class BookInfoView: GreenView {

    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var author: BookInfoUnitView!
    @IBOutlet weak var name: BookInfoUnitView!
    
    @IBOutlet weak var category: BookInfoUnitView!
    @IBOutlet weak var code: BookInfoUnitView!
    
    @IBOutlet weak var pape: BookInfoUnitView!
    
    @IBOutlet weak var year: BookInfoUnitView!
    
    @IBOutlet weak var isbn: BookInfoUnitView!
    
    @IBOutlet weak var price: BookInfoUnitView!
    
    
    override func initStyle() {
        author.set("", "")
        category.set("", "")
        code.set("", "")
        author.set("", "")
        pape.set("", "")
        year.set("", "")
        isbn.set("", "")
        price.set("", "")

    }
    
    func set(_ book : Book)
    {
        author.set("Tác giả",book.author)
        name.set("Tên sách", book.title)
        category.set("Loại", "")
        code.set("Mã sách", book.code)
        pape.set("Số trang", book.page_number)
        year.set("Năm xuất bản", book.public_year)
        isbn.set("Mã ISBN", book.isbn)
        price.set("Giá bìa", book.price.priceValue())
    }
}
