//
//  BoodAddViewController.swift
//  LimeBook
//
//  Created by Lê Dũng on 9/7/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class BookAddViewController: MasterViewController{
    
    @IBOutlet weak var btInsert: ButtonSuccess!
    @IBOutlet weak var btTrash: UIButton!
    
    
    
    @IBOutlet weak var addView: BookAddView!
    
    var isEdit = false;
    var book : Book!
    override func viewDidLoad() {
        super.viewDidLoad()
        var titleN = "Thêm Vào Tủ Sách Online"

        if(isEdit)
        {
            titleN = "Thay đổi thông tin"
            addView.fill(book)
            self.btTrash.image("Trash".image(), UIColor.white)
            self.btInsert.set(title: "Lưu thay đổi")
            
        }
        self.navigationView.set(style: .back, title: titleN) {
            self.pop()
        }
        
        btTrash.isHidden = !isEdit
        
        self.navigationView.bringSubview(toFront: btTrash)

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
    
    
    @IBAction func userTouch(_ sender: Any) {
        
        let errorString = addView.getError()
        if(errorString != nil)
        {
            view.dialog(title: "Lỗi", desc: errorString!, type: .warning, acceptBlock: {
                
            }) {
                
            }
            return
        }
        addNew()
    }
    
    func edit()
    {
    }
    
    func addNew()
    {
        let errorString = self.addView.getError()
        if(errorString != nil)
        {
            view.dialog(title: "Thông báo lỗi", desc: errorString!, type: .warning, acceptBlock: {
            }) {
            }
            return;
        }
        
        let totalRequest = self.addView.getPostPakage()
        let imageList = totalRequest?.1
        
        
        if((imageList?.count)! > 0)
        {
            var imagesUpload : [UIImage] = []
            var mediaFiles : [MediaFile] = []
            
            for item in imageList!
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
            services.uploadMediaLowQuality(MediaBrand.book, images: imagesUpload, success: { (respone) in
                self.view.hideHub()
                if(respone.data is Array<Any>)
                {
                    let mediaFilesResponse = MediaFile.list(data: respone.data as! [Dictionary<String, Any>])
                    mediaFiles.append(contentsOf: mediaFilesResponse)
                    if(self.isEdit)
                    {
                        self.requestEdit((totalRequest?.0)!, file: mediaFiles)
                    }
                    else
                    {
                        self.request((totalRequest?.0)!, file: mediaFiles)
                    }
                }
            }, failure: { (error) in
                self.view.hideHub()

            }) { (progress) in
            }
        }
        else
        {
            if(self.isEdit)
            {
                self.requestEdit((totalRequest?.0)!, file: [])
                
            }
            else
            {
                self.request((totalRequest?.0)!, file: [])
                
            }
        }

    }
    
    
    func request(_ request : BookInsert_Request, file : [MediaFile])
    {
        let endRequest = request
        for item in file
        {
            endRequest.images.append(item.path)
        }
        
        view.showHud()
        services.bookInsert(request, success: { () in
            self.view.hideHub()
            self.view.dialog(title: "Thông báo", desc: "Đăng bài thành công", type: .infoConfirm, acceptBlock: {
                self.addView.clear()
            }, cancelBlock: {
                
            })
        }) { (error) in
            self.view.hideHub()
        }
    }
    
    func requestEdit(_ request : BookInsert_Request, file : [MediaFile])
    {
        let endRequest = request
        for item in file
        {
            endRequest.images.append(item.path)
        }
        
        view.showHud()
        services.bookUpdate(request, success: { () in
            self.view.hideHub()
            self.view.dialog(title: "Thông báo", desc: "Cập nhật thành công.", type: .infoConfirm, acceptBlock: {
                self.addView.clear()
            }, cancelBlock: {
                
            })
        }) { (error) in
            self.view.hideHub()
        }
    }

}

