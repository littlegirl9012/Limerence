//
//  BookDetailViewController.swift
//  LimeBook
//
//  Created by Lê Dũng on 10/8/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class BookDetailViewController: MasterViewController,BookTypeViewDelegate{

    
    @IBOutlet weak var menuView: BookTypeView!
    let request = BookUpdateType_Request()

    @IBOutlet weak var btDelete: UIButton!
    var tradingView : BookDetailTradingView = BookDetailTradingView.init()
    var imagePath :  [String] = []
    @IBOutlet weak var imgSelectView: ImageSelectView!
    @IBOutlet weak var drawView: UIView!
    @IBOutlet weak var lbCat: UILabel!
    @IBOutlet weak var lbAuthor: UILabel!
    @IBOutlet weak var lbName: UILabel!
    var book : Book!
    override func viewDidLoad() {
        super.viewDidLoad()

        menuView.delegate = self;
        navigationView.set(style: .back, title: book.title) {
            self.pop()
        }
        lbName.text = book.title
        lbAuthor.text = book.author
        self.btDelete.image("Trash".image(), UIColor.white)
        
        imgSelectView.fillImage(book.images)
        menuView.setBook(self.book.book_type_n)
        bookTypeDidSelect(self.book.book_type_n)
        
        if(book.book_type_n == .sell)
        {
            tradingView.tvContent.text = self.book.content
            tradingView.tfPrice.text = book.price.priceValue()
        }
        
    }
    
    func bookTypeDidSelect(_ bookType: BookType) {
        
        drawView.removeSubsView()
        if(bookType == .sell)
        {
            drawView.addSubview(tradingView)
            drawView.setLayout(tradingView)
        }
        request.book_type = bookType.rawValue
    }
    
    
    @IBAction func deleteTouch(_ sender: Any) {
        
        view.dialog(title: "Xác nhận", desc: "Bạn có muốn xoá quyển sách này không", type: .warningConfirm, acceptBlock: {
            self.deleteBook()
        }) {
            
        }
        
    }
    
    func deleteBook()
    {
        let bookDelete = BookDelete_Request()
        bookDelete.user_id = userInstance.user.id
        bookDelete.book_id = book.id
        
        services.bookDelete(bookDelete, success: {
            self.pop()
            var vcs = self.navigationController?.viewControllers;
            vcs?.removeLast()
            vcs?.removeLast()
            self.navigationController?.viewControllers = vcs!
        }) { (error) in
            
        }
    }
    

    @IBAction func updateTouch(_ sender: Any) {
        updateImage()
    }
    
    func updateImage()
    {
        let imageList : [ImageSelect] = imgSelectView.images
        if((imageList.count) > 0)
        {
            var imagesUpload : [UIImage] = []
            var mediaFiles : [MediaFile] = []
            
            for item in imageList
            {
                if(item.isLocal)
                {
                    imagesUpload .append(item.image)
                }
                else
                {
                    mediaFiles.append(MediaFile.init(item.imageURL, .image))
                }
            }
            view.showHud()
            weak var weakself = self;
            services.uploadMediaLowQuality(MediaBrand.book, images: imagesUpload, success: { (respone) in
                self.view.hideHub()
                if(respone.data is Array<Any>)
                {
                    let mediaFilesResponse = MediaFile.list(data: respone.data as! [Dictionary<String, Any>])
                    mediaFiles.append(contentsOf: mediaFilesResponse)
                    for item in mediaFiles
                    {
                        weakself?.imagePath.append(item.path)
                        weakself?.updateBook()
                    }
                    
                }
            }, failure: { (error) in
                self.view.hideHub()
                
            }) { (progress) in
            }
        }
        else
        {
            
        }
    }
    
    func updateBook()
    {
        request.book_id = self.book.id
        request.user_id = userInstance.user.id
        request.images = imagePath
        if(request.book_type == BookType.sell.rawValue)
        {
            request.price = tradingView.tfPrice.text?.doubleValue() ?? 0.0
            request.content = tradingView.tvContent.text
        }
        else
        {
            request.price = 0
            request.content = ""
        }
        
        services.bookUpdateType(request, success: {
            
        }) { (error) in
            
        }

    }
}
