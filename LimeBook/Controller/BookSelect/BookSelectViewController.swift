//
//  BookSelectViewController.swift
//  LimeBook
//
//  Created by Lê Dũng on 9/26/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit


enum BookSelectType : Int
{
    case take = 0
    case search = 1
    case feel = 2
}
protocol BookSelectViewControllerDelegate {
    func bookSelectViewDidSelect(_ book : Book)
}

class BookSelectViewController: MasterViewController, UITableViewDelegate, UITableViewDataSource, NavigationViewDelegate, BookTakeDelegate, BookSelectFooterViewDelegate, BookSelectSearchViewDelegate {
    
    
    func navigationViewClearTouch() {
        booksDisplay.removeAll()
        tbView.reloadData()
        navigationView.tfSearcg.text = ""
    }
    
    
    var selectType  = BookSelectType.take ;
    var delegate : BookSelectViewControllerDelegate!
    @IBOutlet weak var tbView: UITableView!

    var books : [Book] = []
    var booksDisplay : [Book] = []
    var keyword = ""
    
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
        keyword = searchText
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
        if(selectType == .take)
        {
            let takeView = BookTakeView()
            takeView.delegate = self;
            takeView.set(self.booksDisplay[indexPath.row])
            view.alertBox(takeView, ratio: 0.86)
        }
        else if (selectType == .feel)
        {
            delegate.bookSelectViewDidSelect(self.booksDisplay[indexPath.row])
            pop()
        }
        else if (selectType == .search)
        {
            let takeView = BookSelectSearchView()
            takeView.delegate = self;
            takeView.set(self.booksDisplay[indexPath.row])
            view.alertBox(takeView, ratio: 0.9)
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
        let book = self.booksDisplay[indexPath.row]
        book.keyword = keyword
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
            }, cancelBlock: {
                
            })
        }) { (error) in
            
        }
    }

    func BookSelectSearchViewTake(_ book: Book) {
        view.hideAlertBox()
        bookTakeAgree(book)
    }
    
    func BookSelectSearchViewCompare(_ book: Book) {
        view.hideAlertBox()
        let compare = BookCompareViewController()
        compare.book = book
        push(compare)
    }
    
    func BookSelectSearchViewOwner(_ book: Book) {
        let bookOwner = BookOwnerViewController()
        bookOwner.book = book
        push(bookOwner)
        view.hideAlertBox()
    }
    
    func BookSelectSearchViewDetail(_ book: Book) {
        let detail = NewsDetailViewController()
        detail.book = book
        push(detail)
        view.hideAlertBox()
    }
    
    func BookSelectSearchViewClose() {
        view.hideAlertBox()
    }

}
