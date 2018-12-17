//
//  BookAddView.swift
//  LimeBook
//
//  Created by Lê Dũng on 9/8/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class BookLibraryView: MasterPostView, AuthorSelectViewDelegate , RadioViewDelegate, BookCategoryViewDelegate{
    
    @IBOutlet weak var feel: PostUnitView!
    @IBOutlet var btAdd: UIButton!
    @IBOutlet var name: PostUnitView!
    @IBOutlet var author: PostUnitView!
    @IBOutlet var cat: PostUnitView!
    @IBOutlet weak var yearPublic: PostUnitView!
    @IBOutlet weak var ratingView: RatingView!
    
    @IBOutlet weak var note: PostUnitView!
    @IBOutlet weak var price: PostUnitView!
    @IBOutlet weak var qrcode: PostUnitView!
    @IBOutlet weak var isbn: PostUnitView!
    @IBOutlet weak var pageNumber: PostUnitView!
    
    
    var userLend : User!
    var authouSelect : Author!
    var categorySelect : [Int] = []
    var bookType = BookType.general
    var book : Book!
    
    @IBOutlet weak var radioStore: RadioView!
    
    @IBOutlet weak var imgSelectView: ImageSelectView!

    @IBOutlet var exten: UIView!
    @IBOutlet weak var noteView: PostNoteView!
    
    
    override func initStyle() {
        
        
        noteView.set("Nếu sách bạn đăng đã có trên thư viện MiBook thì bài đăng sẽ KHÔNG được duyệt.")
        
        name.singleLine()
        author.singleLine()
        pageNumber.singleLine()
        qrcode.singleLine()
        isbn.singleLine()
        price.singleLine()
        yearPublic.singleLine()
        
        
        cat.setTitleRequired("Danh mục")
        name.setTitleRequired("Tên sách")
        author.setTitleRequired("Tác giả")
        defaultTitle()
        ratingView.set("Điểm số")
        yearPublic.keyboard(.numberPad)
        price.keyboard(.numberPad)
        qrcode.keyboard(.numberPad)
        isbn.keyboard(.numberPad)
        pageNumber.keyboard(.numberPad)

//        radioStore.set("select_box".image(), _imgUncheck: "unselect_box".image())
//        radioStore.set(false, "Thêm sách vào tủ của bạn")
//        radioStore.delegate = self;

        feel.set("Giới thiệu sách - Cảm nhận của bạn")
        
        
        cat.action {
            self.endEditAll()
            let bookCat = BookCategoryViewController()
            bookCat.delegate = self;
            self.viewController()?.push(bookCat)
        }
        
        author.setRighAction("feather".image())
        {
            self.endEditAll()
            let author = AuthorSelectViewController()
            author.delegate = self;
            self.viewController()?.push(author)
        }
    }
    
    func defaultTitle()
    {
        pageNumber.set("Số trang")
        qrcode.set("Mã số sách")
        isbn.set("Mã số ISBN sách")
        yearPublic.set("Năm xuất bản")
        price.set("Giá bìa")
        note.set("Trích đoạn hay trong sách")
    }
    func requiredTitle()
    {
        pageNumber.setTitleRequired("Số trang")
        isbn.setTitleRequired("Mã số ISBN sách")
        yearPublic.setTitleRequired("Năm xuất bản")
        note.set("Trích đoạn hay trong sách")
    }

    
    func removeSubExten()
    {
        exten.removeSubsView()
    }
    
    func active(_ sview : UIView)
    {
        removeSubExten()
        exten.addSubview(sview)
        exten.setLayout(sview)
    }
    
    
    func radioChangeState(_ value: Bool, sender: RadioView) {
        defaultTitle()
    }
    
    
    func endEditAll()
    {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            self.endEditing(true)
        }
    }
    
    
    func authorDidSelect(_ value: Author) {
        self.authouSelect = value
        author.tfContent.text = value.aliasname
    }
    
    
    override func getPostPakage()->(BookInsert_Request,[ImageSelect])?
    {
        let request = BookInsert_Request()
        
        if(self.book != nil)
        {
            request.book_id = self.book.id
        }
        request.title = name.content()
        request.content = ""
        request.price = price.content().doubleValue()
        request.user_id = userInstance.user.id
        request.status = 0
        request.book_type = 9
        request.category_id = self.categorySelect
        request.rete = Double(ratingView.rateView.value)
        request.feeling = feel.content()
        request.note = note.content()
        request.page_number = pageNumber.content()
        request.isbn = isbn.content()
        request.code = qrcode.content()
        request.public_year = yearPublic.content()

        request.author = author.content()
        request.author_id = -1
        if(authouSelect != nil)
        {
            request.author = authouSelect.name
            request.author_id = authouSelect.id
        }
    
        
        if(userLend != nil)
        {
            request.lend_id  = userLend.id
        }
        return(request,imgSelectView.images)
    }
    
    override func getError()->String?
    {
        if(!imgSelectView.hasImages())
        {
            return  "Vui lòng chọn hình ảnh của sách"
            
        }
        if(name.isEmpty())
        {
            return  "Vui lònh nhập tên sách"
        }
        
        
        if(cat.isEmpty())
        {
            return  "Vui lòng chọn danh mục sách"
        }
        
        
        return nil
    }
    
    func bookCategoryDidSelect(_ cat: [BookCategory]) {
        self.categorySelect.removeAll()
        self.endEditAll()
    
        var nameDisplay = ""
        for item in cat
        {
            self.categorySelect.append(item.id)
             nameDisplay = nameDisplay + item.name + ","
        }
        
        self.cat.setContent(nameDisplay)
        self.cat.showClearButton {
            self.categorySelect.removeAll()
        }
    }

    override func clear()
    {
        cat.clear()
        name.clear()
        author.clear()
        imgSelectView.clear()
    }

}
