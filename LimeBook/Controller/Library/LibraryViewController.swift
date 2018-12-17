//
//  LibraryViewController.swift
//  LimeBook
//
//  Created by Lê Dũng on 9/24/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class LibraryViewController: MasterViewController , UITableViewDelegate,UITableViewDataSource, LibCategoryViewDelegate, LoadmoreViewDelegate , UIScrollViewDelegate{
    
    @IBOutlet weak var btRight: UIButton!
    var books :  [Book] = []
    var categoryID = -1
    
    var loadMore = LoadmoreView()
    
    
    @IBOutlet weak var tbView: UITableView!
    
    
    @IBOutlet weak var catView: LibCategoryView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        weak var weakself = self
        self.navigationView.set(style: .back, title: "Thư Viện MiBook") {
            weakself?.pop()
        }
        
        
        loadLatestLibrary(0)
        loadMore.delegate = self;
        loadMore.clipsToBounds = true

        tbView.setIdentifier("LibraryCell")
        navigationView.bringSubview(toFront: btRight)
        catView.refreshData()
        catView.delegate  = self;
        
        
        loadMore.setTitle("Tải thêm")
        let header = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0.5))
        let footer = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0.5))

        tbView.tableHeaderView = header
        tbView.tableFooterView = footer

        tbView.backgroundColor = template.backgroundColor
    }
    
    deinit {
        print("-----------------------------DeinitView")
    }
    
    
    func loadLatestLibrary(_ loadType : Int)
    {
        UIImageView.af_sharedImageDownloader.imageCache?.removeAllImages()

        let request = BookLibrary_Request()
        request.category_id = self.categoryID
        request.load_type = loadType
        if(books.count == 0)
        {
            request.last_id = -1;
        }
        else
        {
            if(loadType == 0)
            {
                request.last_id = (self.books.first?.id)!
            }
            else
            {
                request.last_id = (self.books.last?.id)!
            }
        }
        
        weak var weakself = self

        services.bookLibrary(request, success: { (response) in
            if(response.count > 0)
            {
                if(loadType == 0)
                {
                    weakself?.books.insert(contentsOf: response, at: 0)
                }
                else
                {
                    weakself?.books.append(contentsOf: response)
                }
                weakself?.tbView.reloadData()
            }
        }) { (error) in
            
        }

    }
    @IBAction func categotyTouch(_ sender: Any) {
        catView.toggle()
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("Cellforrow : \(indexPath.row)")
        let cell = tbView.dequeueReusableCell(withIdentifier: "LibraryCell") as! LibraryCell
        cell.set(book: self.books[indexPath.row], indexPath: indexPath)
        return cell;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.books.count
    }
    
    func libCategoryViewDidSelect(_ value: BookCategory)
    {
        catView.toggle()
        self.books.removeAll()
        self.tbView.reloadData()

        self.categoryID = value.id
        loadLatestLibrary(0)
        navigationView.setTitle(value.name)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return self.loadMore
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        if(self.books.count > 0)
        {
            return 40
        }
        return 0
    }
    
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        catView.close()
    }
    func loadmoreDidSelect() {
        loadLatestLibrary(1)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detail = LibraryDetailViewController()
        detail.book = books[indexPath.row];
        push(detail)
        
    }
    
}
