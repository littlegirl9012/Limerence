//
//  NewsViewController.swift
//  LimeBook
//
//  Created by Lê Dũng on 8/18/18.
//  Copyright © 2018 limerence. All rights reserved.
//
//change status 

import UIKit

class NewsViewController: MasterViewController,LoadmoreViewDelegate, UITableViewDelegate, UITableViewDataSource,NewsCategoryViewDelegate, BookUnitViewDelegate {
    func bookDidSelectRate(_ indexPath: IndexPath) {
        let detail = BookDetailViewController()
        detail.book = self.books[indexPath.row]
        push(detail)
    }
    
    @IBOutlet weak var btNote: UIButton!

    @IBOutlet weak var menu: NewsCategoryView!
    @IBOutlet weak var btCat: UIButton!
    @IBOutlet weak var btAdd: UIButton!
    var loadmoreView = LoadmoreView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 40))
    @IBOutlet weak var btMenu: UIButton!
    var books  : [Book] = []
    var  query_id : [Int] = [-1]
    
    
    @IBOutlet weak var tbView: GreenTableView!
    var isLoading = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btNote.setTitleColor(template.primaryColor, for: .normal)
        btNote.drawRadius(4, color: template.primaryColor, thickness: 1)
        btNote.isHidden = true ;
        tbView.setIdentifier("NewsDetailCell")
        tbView.setIdentifier("NewsDetailCell_0")
        tbView.setIdentifier("NewsDetailCell_1")
        tbView.setIdentifier("NewsDetailCell_2")
        tbView.setIdentifier("NewsDetailCell_3")
        tbView.setIdentifier("NewsDetailCell_4")

        tbView.setIdentifier("NewsDetailCellBook")
        tbView.setIdentifier("NewsDetailCellBook_0")
        tbView.setIdentifier("NewsDetailCellBook_1")
        tbView.setIdentifier("NewsDetailCellBook_2")
        tbView.setIdentifier("NewsDetailCellBook_3")
        tbView.setIdentifier("NewsDetailCellBook_4")

        simpleNavi.set("Bản tin MiBook")
        
        self.simpleNavi.bringSubview(toFront: self.btAdd)
        self.simpleNavi.bringSubview(toFront: self.btMenu)
        self.simpleNavi.bringSubview(toFront: self.btCat)

        tbView.backgroundColor = template.backgroundColor

        self.loadmoreView.delegate = self;
        loadmoreView.bgColor(.clear)
        self.loadmoreView.setTitle("Tải thêm")
        
        let footer = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 1))
        footer.backgroundColor = UIColor.clear
        tbView.tableFooterView = footer
        
        let header = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 1, height: 8))
        tbView.tableHeaderView = header
        header.backgroundColor = template.backgroundColor

        
        menu.toggleHiden()
        menu.delegate = self;
    }
    @IBAction func menuTouch(_ sender: Any)
    {
        menu.toggleHiden()
    }
    
    func commentViewRequestUserInterfaceFocusView(_ sender: Any?) {
        let textVoew = sender as! UITextView
        let rectOfCellInSuperview = tbView.convert(textVoew.frame, to: self.tbView!)
        
        
        self.tbView.contentOffset = CGPoint.init(x:0 , y:   rectOfCellInSuperview.maxY + 240)
        
    }
    @IBAction func searchTouch(_ sender: Any)
    {
        push(NewsSearchViewController())
    }
    
    @IBAction func postTouch(_ sender: Any)
    {
        let posst = PostInsertViewController()
        self.push(posst)
    }
    
    @IBAction func nodeTouch(_ sender: Any)
    {
        let posst = PostInsertViewController()
        self.push(posst)

    }
    func loadData(loadType : Int)
    {

        if(isLoading)
        {
            return
        }

        let request = BookLatest_Request()
        request.query_id = self.query_id;
        request.load_type = loadType
        if(books.count == 0)
        {
            
        }
        else
        {
            if(loadType == 0)
            {
                request.last_date = (self.books.first?.date)!
            }
            else
            {
                request.last_date = (self.books.last?.date)!
            }
        }

        self.isLoading = true
        
        weak var weakself = self;
        services.bookFeed(request, success: { (response) in
            
            if(response.count > 0)
            {
                if(loadType == 0)
                {
                    weakself?.books.insert(contentsOf: response, at: 0)
                   
                    weakself?.books = self.books.unique{$0.id}
                    weakself?.tbView.reloadData()

                }
                else
                {
                    var counting = self.books.count
                    weakself?.books.append(contentsOf: response)
                    
                    if(response.count > 0)
                    {
                        var indexPaths : [IndexPath] = []
                        for _ in response
                        {
                            let indexPath = IndexPath.init(row: counting, section: 0)
                            counting = counting + 1 ;
                            indexPaths.append(indexPath)
                        }
                        weakself?.tbView.beginUpdates()
                        weakself?.tbView.insertRows(at: indexPaths, with: .fade)
                        weakself?.tbView.endUpdates()
                    }
                }
            }
            weakself?.isLoading = false
            weakself?.btNote.isHidden = ((weakself?.books.count)! > 0)
        }) { (error) in
            weakself?.isLoading = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.books.removeAll()
        self.tbView.reloadData()
        loadData(loadType: 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let book = self.books[indexPath.row]
        
        let identifer = NewsDetailCell.getIdentifierBook(book)
        
        let cell = tbView.dequeueReusableCell(withIdentifier: identifer) as! NewsDetailCell
        cell.set(book)
        cell.delegate = self;
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    }
    
    func bookUnitUserTouch(_ id: Int) {
        
        let index = self.books.index{$0.user_id == id}
        let book = self.books[index!]
        let user = User()
        user.aliasname = book.aliasname
        user.id = book.user_id
        let chat = ChatViewController()
        chat.target = user
        push(chat)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return books.count
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let book = self.books[indexPath.row]
        if(book.book_type_n == .web)
        {
            let detail = NewsDetailWebViewController()
            detail.book = book
            push(detail)
        }
        else
        {
            let detail = NewsDetailViewController()
            detail.book = book
            push(detail)
        }
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if(self.books.count == 0)
        {
            return nil
        }
        return loadmoreView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 40
    }

    func loadmoreDidSelect()
    {
        if(!self.isLoading)
        {
            loadData(loadType: 1)
        }
    }

    func newsCategoryDidSelect(_ value: [Int]) {
        self.books.removeAll()
        self.tbView.reloadData()
        query_id.removeAll()
        query_id.append(contentsOf: value)
        loadData(loadType: 0)
    }
    
    override func didReceiveMemoryWarning()
    {
    }
}
