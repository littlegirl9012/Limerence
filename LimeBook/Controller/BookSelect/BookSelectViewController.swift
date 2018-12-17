//
//  BookSelectViewController.swift
//  LimeBook
//
//  Created by Lê Dũng on 9/26/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

protocol BookSelectViewControllerDelegate {
    func bookSelectViewDidSelect(_ book : Book)
}

class BookSelectViewController: MasterViewController, UITableViewDelegate, UITableViewDataSource, NavigationViewDelegate, BookTakeDelegate, BookSelectFooterViewDelegate {

    
    
    func navigationViewClearTouch() {
        booksDisplay.removeAll()
        tbView.reloadData()
        navigationView.tfSearcg.text = ""
    }
    
    
    var isTake = false ;
    var delegate : BookSelectViewControllerDelegate!
    @IBOutlet weak var tbView: UITableView!

    var books : [Book] = []
    var booksDisplay : [Book] = []
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tbView.setIdentifier("BookSelectCell")
        navigationView.set(style: .back, title: "Chọn Sách") {
            self.pop()
        }
        
        navigationView.enableSearch(true)
        navigationView.delegate = self;
        
        notifyInstance.addM(self, .bookSearch, selector: #selector(bookSearchResult))
        navigationView.setSearchPlaholder("Nhập tên sách")
        navigationView.focus()
        UIImageView.af_sharedImageDownloader.imageCache?.removeAllImages()
    }
    
    func bookSelectFooterViewAdd() {
        push(MiBookAddViewController())
    }

    @objc func bookSearchResult(notify  : NSNotification)
    {
        let bookList = notify.object as! [Book]
        self.booksDisplay.removeAll()
        self.booksDisplay.append(contentsOf: bookList)
        self.tbView.reloadData()
    }
    
    func navigationViewSearching(_ searchText: String) {
        if(searchText.trim().length == 0)
        {
            self.booksDisplay.removeAll()
            self.tbView.reloadData()
            return
        }
        
        
        let request = BookSearch_Request()
        request.keyword = searchText.trim()
        if(messageInstance.isConnected())
        {
            messageInstance.bookSearch(request)
        }
        else
        {
            weak var weakself = self;

            services.bookSearch(request, success: { (response) in
                weakself?.booksDisplay.removeAll()
                weakself?.booksDisplay.append(contentsOf: response)
                weakself?.tbView.reloadData()
            }) { (error) in
                
            }
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        
    
        view.endEditing(true)
        if(isTake)
        {
            let takeView = BookTakeView()
            takeView.delegate = self;
            takeView.set(self.booksDisplay[indexPath.row])
            view.alertBox(takeView, ratio: 0.86)

        }
        else
        {
            delegate.bookSelectViewDidSelect(self.booksDisplay[indexPath.row])
            pop()

        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        messageInstance.reconnect()

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return booksDisplay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbView.dequeueReusableCell(withIdentifier: "BookSelectCell") as! BookSelectCell
        cell.set(self.booksDisplay[indexPath.row])
        return cell
    }


    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let fView = BookSelectFooterView()
        fView.delegate = self;
        return fView
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 48
    }
    func bookTakeClose() {
        view.hideAlertBox()
    }
    
    func bookTakeAgree(_ value: Book)
    {
        view.hideAlertBox()

        let request = BookTake_Request()
        request.book_id = value.id
        request.user_id = userInstance.user.id
        weak var weakself = self;
        services.bookTake(request, success: {
            weakself?.view.dialog(title: "Thông báo", desc: "Thêm vào tủ sách thành công", type: .info, acceptBlock: {
                weakself?.pop()
            }, cancelBlock: {
                
            })
        }) { (error) in
            
        }
    }


}
