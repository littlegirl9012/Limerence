//
//  BookAddView.swift
//  LimeBook
//
//  Created by Lê Dũng on 9/8/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class BookAddView: MasterPostView , ContactSelectDelegate , BookTypeViewDelegate, BookCategoryViewDelegate{
    

    @IBOutlet var btAdd: UIButton!
    
    @IBOutlet var name: PostUnitView!
    @IBOutlet var author: PostUnitView!
    @IBOutlet var des: PostUnitView!
    @IBOutlet var cat: PostUnitView!
    
    
    var userLend : User!
    var categorySelect : [Int] = []
    var lend: PostUnitView = PostUnitView()
    var price: PostUnitView = PostUnitView()
    var bookType = BookType.general
    
    var book : Book!
    
    
    
    @IBOutlet var typeView: BookTypeView!
    @IBOutlet weak var imgSelectView: ImageSelectView!

    @IBOutlet var exten: UIView!
    
    
    override func initStyle() {
        typeView.delegate = self;
        name.singleLine()
        author.singleLine()
        lend.singleLine()
        price.singleLine()
        
        cat.set("Danh mục")
        name.set("Tên sách")
        author.set("Tác giả")
        des.set("Ghi chú")
        lend.set("Người mượn")
        price.set("Giá bán lại")
        price.keyboard(.numberPad)
        

        cat.action {
            self.endEditAll()
            let bookCat = BookCategoryViewController()
            bookCat.delegate = self;
            self.viewController()?.push(bookCat)
        }
        
        lend.action {
            self.endEditAll()

            let contact = ContactSelectViewController()
            contact.delegate = self;
            
            self.viewController()?.push(contact)
        }
        
    }
    
    
    func fill(_ book : Book)
    {
        self.book = book;
        
        
        
        
        name.setContent(book.title)
        author.setContent(book.author)
        des.setAttribute(book.attibuteConent)
        price.setContent(book.price.stringValue())
        imgSelectView.fillImage(book.images)
        
        
        
        var catName = ""
        
        for item in book.categoryMode
        {
            self.categorySelect.append(item.id)
            catName = catName + item.name + ", "
        }
        
        cat.setContent(catName)
        
        if(book.book_type_n == .general)
        {
            removeSubExten()
        }
        
        
        if(book.lend_model.count > 0)
        {
            userLend = book.lend_model[0];
            lend.setContent(userLend.aliasname)
        }
        
        
        
        typeView.setBook(book.book_type_n)
        
        switch book.book_type_n {
        case .general:
            removeSubExten()
            break;
        case .sell:
            active(price)
            break;
        case .lend:
            active(lend)
            break;
        default:
            break;
        }

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
    
    
    
    func bookTypeDidSelect(_ bookType: BookType)
    {
        switch bookType {
        case .general:
            removeSubExten()
            break;
        case .sell:
            active(price)
            break;
        case .lend:
            active(lend)
            break;
            
        default:
            break;
        }
        
        self.bookType = bookType
    }
    
    func contactSelect(_ user: User) {
        
        self.endEditAll()
        self.userLend = user;
        self.lend.setContent(self.userLend.aliasname)
        self.lend.showClearButton {
            self.userLend = nil
        }
    }

    
    
    func endEditAll()
    {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            self.endEditing(true)
            
        }
    }
    
    
    
    override func getPostPakage()->(BookInsert_Request,[ImageSelect])?
    {
        let request = BookInsert_Request()
        
        if(self.book != nil)
        {
            request.book_id = self.book.id
        }
        request.title = name.content()
        request.content = des.content()
        request.price = price.content().doubleValue()
        request.user_id = userInstance.user.id
        request.author = ""
        request.status = 0
        request.book_type = typeView.bookType.rawValue
        request.author = author.content()
        request.category_id = self.categorySelect
        if(userLend != nil)
        {
            request.lend_id  = userLend.id
        }
        return(request,imgSelectView.images)
    }
    
    override func getError()->String?
    {
        
        var errorString : String?
        
        if(!imgSelectView.hasImages())
        {
            errorString = "Vui lòng chọn hình ảnh của sách"
        }

        
        if(name.isEmpty())
        {
            errorString = "Vui lònh nhập tên sách"
        }
        
        
        if(des.isEmpty())
        {
        }
        
        
        if(cat.isEmpty())
        {
            errorString = "Vui lòng chọn danh mục sách"
        }
        
        if((self.bookType == .sell) && (self.price.isEmpty()))
        {
            errorString = "Vui lòng thêm giá bán"
        }
        
        if((self.bookType == .lend) && (self.userLend == nil))
        {
            errorString = "Vui lòng chọn người mượn"
        }

        
        
        return errorString
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
        lend.clear()
        name.clear()
        price.clear()
        des.clear()
        author.clear()
        price.hideClearButton()
        lend.hideClearButton()
        imgSelectView.clear()
    }

}
