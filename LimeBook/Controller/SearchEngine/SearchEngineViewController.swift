//
//  SearchEngineViewController.swift
//  LimeBook
//
//  Created by Lê Dũng on 9/3/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit


enum SearchEngineType : Int
{
    case user = 0
    case conversation = 1
    case contact = 2
    case book = 3;
    
}

class SearchEngineUnit : NSObject
{
    var name = ""
    var value : [Any] = []
    var searchType = SearchEngineType.user
    
    init(_ name : String , value : [Any]) {
        super.init()
        self.name = name
        self.value.removeAll()
        self.value.append(contentsOf: value)
    }
    
    
    func headerHeight() -> CGFloat
    {
        return (value.count > 0) ? 40.0 : 0
    }
    
    func headerFooter() -> CGFloat
    {
        return (value.count > 0) ? 12 : 0
    }


}

class SearchEngineViewController: MasterViewController , UITableViewDelegate,UITableViewDataSource{
    
    
    
    
    
    var searchResult : [SearchEngineUnit] = []
    
    
    @IBOutlet weak var tbView: UITableView!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tbView.delegate = self;
        tbView.dataSource = self;
        tbView.setIdentifier("BooksCell")
        tbView.setIdentifier("UserCell")
        tbView.setIdentifier("ConversationCell")

        

    }
    
    func search(_ value : String)
    {
        searchResult.removeAll()
        
        let converR = searchConversation(value)
        
        if(converR.value.count > 0)
        {
            searchResult.append(converR)

        }
        
        
        let contactR = searchContact(value)
        if(contactR.value.count > 0)
        {
            searchResult.append(contactR)
        }

        tbView.reloadData()
    }
    
    
    func searchConversation(_ value : String) -> SearchEngineUnit
    {
        let filtered = confernceDataStore.conversations.filter { $0.name.lossyValue().contains(value.lossyValue()) }
        print(filtered)
        let converObject = SearchEngineUnit.init("Trò chuyện", value: filtered)
        converObject.searchType = .conversation
        return converObject
    }
    
    func searchContact(_ value : String) -> SearchEngineUnit
    {
        let filtered = contactDataStore.contacts.filter { $0.aliasname.lossyValue().contains(value.lossyValue()) }
        let converObject = SearchEngineUnit.init("Danh bạ", value: filtered)
        return converObject
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return  searchResult[section].value.count
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return searchResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let unit = searchResult[indexPath.section]
        
        
        
        
        switch unit.searchType {
        case .user:
            let cell = tbView.dequeueReusableCell(withIdentifier: "UserCell") as! UserCell
            let userUnit = unit.value[indexPath.row] as! User
            cell.set(userUnit)
            return cell
        case .conversation:
            
            let cell = tbView.dequeueReusableCell(withIdentifier: "ConversationCell") as! ConversationCell
            let conversation = unit.value[indexPath.row] as! Conversation
            cell.set(conversation)
            return cell

        case .contact:
            break;
        case .book:
            break;

        }
       
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.searchResult[section].headerHeight()
    }

    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = MasterHeaderView.init(frame: CGRect.init())
        
        header.set(searchResult[section].name)
        return header
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    
        return MasterFooterView()
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return self.searchResult[section].headerFooter()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        let unitSearch = searchResult[indexPath.section];
        
        switch unitSearch.searchType
        {
        case .user:
            
            let chat = ChatViewController()
            chat.target = unitSearch.value[indexPath.row] as! User
            push(chat)
            break;
        case .conversation:
            
            break
        case .contact:
            break;
        case .book:
            break;
            
        }

        
        
        
        
    }
}
