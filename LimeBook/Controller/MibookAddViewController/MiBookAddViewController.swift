//
//  MiBookAddViewController.swift
//  LimeBook
//
//  Created by Lê Dũng on 12/1/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class MiBookAddViewController: MasterViewController , BookCategoryViewDelegate{
    @IBOutlet weak var nameField: PostUnitView!
    @IBOutlet weak var authorField: PostUnitView!
    @IBOutlet weak var categoryField: PostUnitView!
    @IBOutlet weak var priceField: PostUnitView!
    @IBOutlet weak var pageField: PostUnitView!
    @IBOutlet weak var yearField: PostUnitView!
    var categorySelect : [Int] = []
    @IBOutlet weak var imgSelectView: ImageSelectView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        weak var weakself = self;
        
        navigationView.set(style: .back, title: "Thêm Mới Sách") {
            weakself?.pop()
        }
        
        
        nameField.setTitleRequired("Tên sách")
        nameField.singleLine()
        
        authorField.setTitleRequired("Tác giả")
        authorField.singleLine()

        categoryField.setTitleRequired("Thể loại")
        yearField.set("Năm phát hành")
        pageField.set("Số Trang")
        priceField.set("Giá bìa")
        
        yearField.singleLine()
        pageField.singleLine()
        priceField.singleLine()
        
        priceField.keyboard(.numberPad)
        yearField.keyboard(.numberPad)
        pageField.keyboard(.numberPad)

        categoryField.action {
            let bookCat = BookCategoryViewController()
            bookCat.delegate = self;
            self.push(bookCat)
        }

    }
    
    func getError()->String?
    {
        if(!imgSelectView.hasImages())
        {
            return  "Vui lòng chọn hình ảnh của sách"
            
        }
        if(nameField.isEmpty())
        {
            return  "Vui lònh nhập tên sách"
        }
        
        
        if(categoryField.isEmpty())
        {
            return  "Vui lòng chọn danh mục sách"
        }
        
        if(authorField.isEmpty())
        {
            return  "Vui lòng nhập tên tác giả"
        }

        return nil
    }
    

    func bookCategoryDidSelect(_ cat: [BookCategory]) {
        self.categorySelect.removeAll()
        
        var nameDisplay = ""
        for item in cat
        {
            self.categorySelect.append(item.id)
            nameDisplay = nameDisplay + item.name + ","
        }
        
        categoryField.setContent(nameDisplay)
        categoryField.showClearButton {
            self.categorySelect.removeAll()
        }
    }

    
    @IBAction func addTouch(_ sender: Any){
        
        view.endEditing(true)
        let error = getError()
        if((error) != nil)
        {
            view.warning(title: "Lỗi", desc: error!)
            return
        }
        
        
        let imageList = imgSelectView.getImage()
        var imagesUpload : [UIImage] = []
        var mediaFiles : [MediaFile] = []
        
        for item in imageList
        {
            imagesUpload .append(item.image)
        }
        
        view.showHud()
        weak var weakself = self;
        services.uploadMediaLowQuality(MediaBrand.book,images: imagesUpload, success: { (respone) in
            if(respone.data is Array<Any>)
            {
                let mediaFilesResponse = MediaFile.list(data: respone.data as! [Dictionary<String, Any>])
                mediaFiles.append(contentsOf: mediaFilesResponse)
                var path : [String] = []
                for item in mediaFiles
                {
                    path.append(item.path)
                }
                
                weakself?.add(path)
            }
        }, failure: { (error) in
            self.view.hideHub()
            
        }) { (progress) in
            
        }

        
    }
    

    
    func add(_ images : [String])
    {
        let request = BookInsert_Request()
        
        request.title = nameField.content()
        request.content = ""
        request.price = priceField.content().doubleValue()
        request.user_id = userInstance.user.id
        request.status = 0
        request.book_type = 9
        request.category_id = self.categorySelect
        request.page_number = pageField.content()
        request.public_year = yearField.content()
        
        request.author = authorField.content()
        request.author_id = -1
        request.images = images
        
        weak var weakself = self;
        services.bookInsert(request, success: {
            weakself?.view.hideHub()
            weakself?.view.warning(title: "Thông báo", desc: "Đăng sách thành công")
            weakself?.clear()
        }) { (error) in
            weakself?.view.hideHub()
        }
    }
    
    func clear()
    {
        nameField.clear()
        authorField.clear()
        categoryField.clear()
        pageField.clear()
        priceField.clear()
        yearField.clear()
        categorySelect.removeAll()
        imgSelectView.clear()
    }

}
