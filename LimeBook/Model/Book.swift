//
//  Book.swift
//  LimeBook
//
//  Created by Lê Dũng on 8/28/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit


extension String
{
    
    func emojAttributeText(_ generalSize : Bool)->NSAttributedString
    {
        let attri = NSMutableAttributedString.init(string: self)
        if(contains("emj"))
        {
            for item in interfaceDataStore.emoj
            {
                if(self.contains(item))
                {
                    var n = 0
                    let rang = attri.string.ranges(of:item)
                    for itemRange in rang
                    {
                        var targetName = item.replacingOccurrences(of: "]", with: "")
                        targetName = targetName.replacingOccurrences(of: "[", with: "")
                        let image1Attachment = NSTextAttachment()
                        image1Attachment.image = UIImage(named: targetName)
                        if((length == 7) && !generalSize )
                        {
                            image1Attachment.bounds = CGRect.init(x: 0, y: 0, width: 48, height: 48)
                        }
                        else
                        {
                            image1Attachment.bounds = CGRect.init(x: 0, y: -4, width: 18, height: 18)
                        }
                        let image1String = NSAttributedString(attachment: image1Attachment)
                        attri.replaceCharacters(in: NSRange.init(location: itemRange.lowerBound.encodedOffset - (n*6), length: 7), with: image1String)
                        n = n + 1;
                    }
                }
            }
        }
        return attri ;

    }

    
    func emojAttributeText()->NSAttributedString
    {
        return emojAttributeText(false)
    }
    
}

class BookReact: Mi {
    @objc dynamic var id = 0;
    @objc dynamic var is_like = false;
    @objc dynamic var like_count = 0;
    
    class func  list(data : [Dictionary<String, Any>]) -> [BookReact]
    {
        var output  : [BookReact]  = []
        for item in data
        {
            let unit = BookReact.init(dictionary: item as NSDictionary)
            output.append(unit)
        }
        return output
    }

}

enum BookType : Int
{
    case general = 1
    case buy = 2
    case sell = 3
    case news = 4
    case lend = 5
    case present = 6
    case react = 7
    case question = 8
    case library = 9
    case web = 12


}


class Book: Mi {

    @objc dynamic var feeling_user_id = -1;
    @objc dynamic var feeling_id = -1;

    @objc dynamic var feeling_aliasname = "";
    @objc dynamic var feeling_avatar = "";
    @objc dynamic var feeling_content = "";
    @objc dynamic var feeling_date = "";
    @objc dynamic var feeling_image = "";
    @objc dynamic var feeling_intro = "";
    @objc dynamic var feeling_note = "";
    @objc dynamic var feeling_rate = 0.0;
    @objc dynamic var feeling : [Feelling] = [];
    @objc dynamic var feeling_target : Feelling!;

    
    
    
    @objc dynamic var user_id = -1;
    @objc dynamic var like_count = 0;
    @objc dynamic var comment_count = 0;
    @objc dynamic var title = "";
    
    
    
    @objc dynamic var public_year = "";
    @objc dynamic var note = "";
    @objc dynamic var isbn = "";
    @objc dynamic var code = "";
    @objc dynamic var page_number = "";

    @objc dynamic var image  = "";
    @objc dynamic var image_media  : MediaFile! ;
    @objc dynamic var imageURL  = "";

    @objc dynamic var content = "";
    @objc dynamic var price = 0.0;
    @objc dynamic var rate = 0.0;
    @objc dynamic var province_id = -1;

    @objc dynamic var author = "";
    @objc dynamic var status = 0;
    @objc dynamic var images  : [String] = []
    @objc dynamic var avatar = "";
    @objc dynamic var book_type = 0;
    @objc dynamic var is_like = false;
    
    
    @objc dynamic var  feel : [NSDictionary] = []
    
    
    
    @objc dynamic var  feel_model : [Feelling] = []


    @objc dynamic var  comment : [NSDictionary] = []
    
    
    
    @objc dynamic var  comment_model : [Comment] = []
    @objc dynamic var  media : [NSDictionary] = []
    @objc dynamic var  media_model : [MediaFile] = []
    @objc dynamic var  category : [NSDictionary] = []
    @objc dynamic var  categoryMode : [BookCategory] = []
    @objc dynamic var  lend : [NSDictionary] = []
    @objc dynamic var  lend_model : [User] = []
    @objc dynamic var  id = -1;
    @objc dynamic var  date = "";
    @objc dynamic var  dateDisplay = "";
    @objc dynamic var  wp_link = "";
    @objc dynamic var  wp_id = -1;

    @objc dynamic var atributeTitle : NSMutableAttributedString!
    @objc dynamic var attibuteConent : NSMutableAttributedString!
    @objc dynamic var attibuteShortContent : NSMutableAttributedString!

    @objc dynamic var aliasname = "";
    @objc dynamic var isShowFull = false;
    @objc dynamic var canShowFull = false;

    
    @objc dynamic var isDrawExtenal = false;
    @objc dynamic var isDrawExtenalComment = false;
    @objc dynamic var isDrawFelling = false;
    
    @objc dynamic var isLoadingData = false;
    @objc dynamic var canDraw = true ;
    @objc dynamic var isShowFullText = false;
    @objc dynamic var needToDrawFirstFeel = true;
    @objc dynamic var isDrawFeelingList = false;
    @objc dynamic var htmlContent = String();

    var book_type_n = BookType.general;

    
    func closeAll()
    {
        isDrawExtenal = false;
        isDrawFelling = false;
        isDrawExtenalComment = false
    }
    
    
    override init(dictionary: NSDictionary) {
        super.init(dictionary: dictionary)
    }
    
    required public init() {
        super.init()
    }
    
    
    
    func toggleDrawFeeling()
    {
        isDrawFeelingList = !isDrawFeelingList
    }
    
    
    func loadFeeling(success : @escaping (()->Void))
    {
        let request = FeelingList_Request()
        request.book_id = id
        services.feelingList(request: request, success: { (response) in
            if(response.count > 0)
            {
                for item in response
                {
                    if(item.id != self.feeling_id)
                    {
                        item.author = self.author
                        item.fillAttribute()

                        self.feeling.append(item)
                    }
                }
                success()
            }
        }) { (error) in
        }
    }

    
    func copyZ(with zone: NSZone? = nil) -> Book {
        let dictionaryTemp = dictionary()
        return  Book.init(dictionary:  dictionaryTemp as NSDictionary)
    }

    
    
    func isShowViewState()->Bool
    {
        return !(book_type_n == .general)
    }
    
    func stateColor() -> UIColor
    {
        switch book_type_n {
        case .lend: return template.lendColor
        case .sell: return template.sellColor
        case .general: return UIColor.clear
        default: Void();
        }
        
        return .clear
    }
    
    
    func stateTitle() -> String
    {
        switch book_type_n {
        case .lend: return "Cho Mượn"
        case .sell: return "Đăng Bán"
        case .general: return ""
        case .question: return ""

            
        default: Void();
        }
        
        return ""
    }
    deinit {
        print("book deinit------------------A")
    }

    
    func toggleShowMode()
    {
        if(canShowFull)
        {
            isShowFull = !isShowFull
        }
    }
    
    func getAttributeDetail()->NSAttributedString
    {
        if(canShowFull)
        {
            if(isShowFull)
            {
                return attibuteConent
            }
            else
            {
                return attibuteShortContent
            }
        }
        else
        {
            return attibuteConent

        }
    }
    
    func updateReact(_ react : BookReact)
    {
        self.like_count = react.like_count
        self.is_like = react.is_like
    }
    
    func loadMedia()
    {
        for item in media_model
        {
            item.downloadContent()
        }
    }
    
    
    func clearMediaContent()
    {
        for item in media_model
        {
            item.content = nil;
        }
    }
    
    func fillData()
    {
        content = content.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        content = content.replacingOccurrences(of: "\r", with: "");
        content = content.replacingOccurrences(of: "\n\n", with: "\n");
        content = content.replacingOccurrences(of: "\n\n", with: "\n");

        image_media = MediaFile.init(image, .image)
        if(book_type > 0)
        {
            book_type_n = BookType.init(rawValue:  book_type)!
        }
        dateDisplay =  date.date8601().stringValue()
        imageURL =  image
        categoryMode = BookCategory.list(data: category as! [Dictionary<String, Any>])
        lend_model = User.list(data: lend as! [Dictionary<String, Any>])
        feel_model = Feelling.list(data: feel as! [Dictionary<String, Any>])

        var wordCounting = content.split(separator: " ");
        var isShort = false;
        if(wordCounting.count > 60)
        {
            while wordCounting.count > 60
            {
                wordCounting.removeLast()
            }
            isShort = true
        }
        
        if(isShort)
        {
            content = wordCounting.joined(separator: " ") + "...";

        }
        
        
        
        attibuteConent = attributeText(content)
        if(images.count == 0)
        {
            images.append(image)
        }

        for item in images
        {
            let media = MediaFile.init(item, .image)
            media_model.append(media)
        }
        
        var prefix : NSMutableAttributedString = NSMutableAttributedString()
        if(book_type_n == .buy)
        {
            let str = "MUA SÁCH: "
            let attribute = [NSAttributedStringKey.foregroundColor: template.buyColor,NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 16)]
            prefix =  NSMutableAttributedString(string: str, attributes: attribute)
        }
        
        if(book_type_n == .sell)
        {
            let str = "BÁN SÁCH "
            let attribute = [NSAttributedStringKey.foregroundColor: template.sellColor,NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 16)]
            prefix =  NSMutableAttributedString(string: str, attributes: attribute)
        }
        
        if(book_type_n == .news)
        {
            let str = ""
            let attribute = [NSAttributedStringKey.foregroundColor: template.newsColor]
            prefix =  NSMutableAttributedString(string: str, attributes: attribute)
        }
        
        if(book_type_n == .question)
        {
            let str = ""
            let attribute = [NSAttributedStringKey.foregroundColor: template.questionColor]
            prefix =  NSMutableAttributedString(string: str, attributes: attribute)
        }

        if(book_type_n == .sell)
        {
            atributeTitle = attributeTextBold(title.uppercased() + " - ")
            let pri = price.priceValue()
            let priribute = [NSAttributedStringKey.foregroundColor: template.sellColor]
            let preText =  NSMutableAttributedString(string: pri, attributes: priribute)
            atributeTitle.append(preText)
        }
        else
        {
            atributeTitle = attributeTextBold(title.uppercased())

        }
        atributeTitle.insert(prefix, at: 0);
        attibuteConent = LimeAttributedString.attribute(string: content, italic: false, emotion: true)
    }
    
    class func  list(data : [Dictionary<String, Any>]) -> [Book]
    {
        var output  : [Book]  = []
        for item in data
        {
            let unit = Book.init(dictionary: item as NSDictionary)
            if((item as NSDictionary).value(forKey: "content") != nil)
            {
                let htmlContent = (item as NSDictionary).value(forKey: "content")
                if(htmlContent is String)
                {
                    unit.htmlContent = (item as NSDictionary).value(forKey: "content") as! String
                }
            }
            unit.title = unit.title.uppercased()
            unit.fillData()
            output.append(unit)
        }
        return output
    }
    
    
    class func  simpleList(data : [Dictionary<String, Any>]) -> [Book]
    {
        var output  : [Book]  = []
        for item in data
        {
            let unit = Book.init(dictionary: item as NSDictionary)
            output.append(unit)
        }
        return output
    }

    
    
    func attributeText(_ value : String) -> NSMutableAttributedString
    {
        
        let attri = NSMutableAttributedString.init(string: value)
        
        let paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.lineHeightMultiple = 0.8
//        paragraphStyle.lineSpacing = 0.8
        paragraphStyle.alignment = .natural
        attri.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attri.length))
        attri.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 16), range: NSMakeRange(0, attri.length))
        return attri ;
    }
    
    func attributeTextBold(_ value : String) -> NSMutableAttributedString
    {
        
        let attri = NSMutableAttributedString.init(string: value)
        
        let paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.lineHeightMultiple = 0.8
//        paragraphStyle.lineSpacing = 0.8
        paragraphStyle.alignment = .natural
        attri.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attri.length))
        attri.addAttribute(NSAttributedStringKey.font, value: UIFont.boldSystemFont(ofSize: 16), range: NSMakeRange(0, attri.length))
        return attri ;
    }

    
}


class BookInsert_Request: Mi
{
    @objc dynamic var user_id = -1;
    @objc dynamic var book_id = -1;
    @objc dynamic var lend_id = -1;
    @objc dynamic var title = "";
    @objc dynamic var content = "";
    @objc dynamic var price = 0.0;
    @objc dynamic var author = "";
    @objc dynamic var author_id = -1;
    @objc dynamic var rete = 0.0;

    @objc dynamic var isbn = "";
    @objc dynamic var code = "";
    @objc dynamic var note = "";
    @objc dynamic var page_number = "";
    @objc dynamic var public_year = "";
    @objc dynamic var feeling = "";
    @objc dynamic var reference = -1;
    @objc dynamic var status = 0;
    @objc dynamic var images  : [String] = [];
    @objc dynamic var book_type = 0
    @objc dynamic var category_id  : [Int] = [];
    @objc dynamic var insert_mibook = 0
    @objc dynamic var insert_store = 0

}
class BookLocation_Request: Mi
{
    @objc dynamic var user_id = -1;
    @objc dynamic var latitude = 0.0;
    @objc dynamic var logitude = 0.0;
    @objc dynamic var distance = 0.0;
}
class BookLike_Request: Mi
{
    @objc dynamic var user_id = -1;
    @objc dynamic var book_id = -1;
    @objc dynamic var is_like = true;
}


class BookLibrary_Request: Mi
{
    @objc dynamic var last_id = -1;
    @objc dynamic var category_id = -1;
    @objc dynamic var load_type = 0; //0 first -> insert , 1/ loadmore
}

class BookGeneral_Request: Mi
{
    @objc dynamic var book_id = -1;
}

class BookUserSelect_Request: Mi
{
    @objc dynamic var user_id = -1;
}


class BookCommentList_Request: BookGeneral_Request
{
    @objc dynamic var comment_type = 1;
    @objc dynamic var target_id = 1;

}

class BookCommentInsert_Request: BookGeneral_Request
{
    @objc dynamic var target_id = -1;
    @objc dynamic var user_id = -1;
    @objc dynamic var parent_id = -1;
    @objc dynamic var content = "";

}

class BookUniversity_Request: Mi
{
    @objc dynamic var university_id = -1;
}


class BookFeed_Request: Mi
{
    @objc dynamic var last_date : String = "" // truyền ngày của object cuối cùng, sever trả về sao, đưa lên y chang vậy, ko chế biế //
    @objc dynamic var load_type = 0; //1 là load old, 0 là load news
    @objc dynamic var user_id = userInstance.user.id;
}

class BookUser_Request: Mi
{
    @objc dynamic var last_id = 0;
    @objc dynamic var user_id = -1;
    @objc dynamic var book_type = -1;
}

class BookTake_Request: Mi
{
    @objc dynamic var user_id = userInstance.user.id;
    @objc dynamic var book_id = -1;
    
}
class BookUserList_Request: Mi
{
    @objc dynamic var user_id = userInstance.user.id;
    @objc dynamic var book_id = -1;
}
class BookTrading_Request: Mi
{
    @objc dynamic var last_date = "";
    @objc dynamic var load_type = 0;
    
}


class BookUserAll_Request: Mi
{
    @objc dynamic var last_id = -1;
    @objc dynamic var user_id = -1;

}
class BookDelete_Request: Mi
{
    @objc dynamic var book_id = -1;
    @objc dynamic var user_id = -1;
}
class BookDetail_Request: Mi
{
    @objc dynamic var book_id = -1;
    @objc dynamic var user_id = -1;
}

class BookUpdateType_Request: Mi
{
    @objc dynamic var book_id = -1;
    @objc dynamic var user_id = -1;
    @objc dynamic var images  : [String] = [];
    @objc dynamic var price = 0.0;
    @objc dynamic var content = "";
    @objc dynamic var book_type = 1;

}


extension Services
{
    func bookInsert(_ request : BookInsert_Request, success :@escaping (()->Void), failure: @escaping ((String)->Void))
    {
        services.request(api: .bookInsert, param: request.dictionary(), success: { (response) in
            success()
        }) { (error) in
            failure("Lỗi")
        }
    }
    
    func bookUpdate(_ request : BookInsert_Request, success :@escaping (()->Void), failure: @escaping ((String)->Void))
    {
        services.request(api: .bookUpdate, param: request.dictionary(), success: { (response) in
            success()
        }) { (error) in
            failure("Lỗi")
        }
    }

    
    func bookLatest(_ request : BookFeed_Request, success :@escaping (([Book])->Void), failure: @escaping ((String)->Void))
    {
        services.request(api: .bookLatest, param: request.dictionary(), success: { (response) in
            success(Book.list(data: response.data as! [Dictionary<String, Any>]))
        }) { (error) in
            failure("")
        }
    }

    
    
    func bookCommentList(_ request : BookCommentList_Request, success :@escaping (([Comment])->Void), failure: ((String)->Void))
    {
        services.request(api: .bookCommentList, param: request.dictionary(), success: { (response) in
            success(Comment.list(data: response.data as! [Dictionary<String, Any>]))
        }) { (error) in
            
        }
    }
    
    func bookCommentInsert(_ request : BookCommentInsert_Request, success :@escaping (([Comment])->Void), failure: ((String)->Void))
    {
        services.request(api: .bookCommentInsert, param: request.dictionary(), success: { (response) in
            success(Comment.list(data: response.data as! [Dictionary<String, Any>]))
        }) { (error) in
            
        }
    }

    
    func bookUser(_ request : BookUser_Request, success :@escaping (([Book])->Void), failure: ((String)->Void))
    {
        services.request(api: .bookUser, param: request.dictionary(), success: { (response) in
            success(Book.list(data: response.data as! [Dictionary<String, Any>]))
        }) { (error) in
            
        }
    }
    func bookUserAll(_ request : BookUser_Request, success :@escaping (([Book])->Void), failure: ((String)->Void))
    {
        services.request(api: .bookUserAll, param: request.dictionary(), success: { (response) in
            success(Book.list(data: response.data as! [Dictionary<String, Any>]))
        }) { (error) in
            
        }
    }

    
    func bookDetail(_ request :  BookDetail_Request, success :@escaping ((Book)->Void), failure: ((String)->Void))
    {
        services.request(api: .bookDetail, param: request.dictionary(), success: { (response) in
            let book = Book.init(dictionary: response.data as! NSDictionary)
            book.fillData()
            book.comment_model = Comment.list(data: book.comment as! [Dictionary<String, Any>])
            success(book)
        }) { (error) in
            
        }
    }

    
    func bookDelete(_ request :  BookDelete_Request, success :@escaping (()->Void), failure: ((String)->Void))
    {
        services.request(api: .bookDelete, param: request.dictionary(), success: { (response) in
            success()
        }) { (error) in
            
        }
    }
    
    func bookLocation(_ request :  BookLocation_Request, success :@escaping (([Book])->Void), failure: ((String)->Void))
    {
        services.request(api: .bookLocation, param: request.dictionary(), success: { (response) in
            success(Book.list(data: response.data as! [Dictionary<String, Any>]))
        }) { (error) in
            
        }
    }
    
    
    func bookLike(_ request :  BookLike_Request, success :@escaping ((BookReact)->Void), failure: ((String)->Void))
    {
        services.request(api: .bookLike, param: request.dictionary(), success: { (response) in
            let list = BookReact.list(data: response.data as! [Dictionary<String, Any>])
            if(list.count > 0)
            {
                success(list[0])
            }
        }) { (error) in
            
        }
    }


    
    func bookLibrary(_ request :  BookLibrary_Request, success :@escaping (([Book])->Void), failure: ((String)->Void))
    {
        DispatchQueue.global(qos: .background).async {
            services.request(api: .bookLibrary, param: request.dictionary(), success: { (response) in
                success(Book.list(data: response.data as! [Dictionary<String, Any>]))
            }) { (error) in
                
            }
        }
    }
    func bookUserSelect(_ request :  BookLibrary_Request, success :@escaping (([Book])->Void), failure: ((String)->Void))
    {
        DispatchQueue.global(qos: .background).async {
            services.request(api: .bookUserSelect, param: request.dictionary(), success: { (response) in
                success(Book.list(data: response.data as! [Dictionary<String, Any>]))
            }) { (error) in
                
            }
        }
    }


    func bookSearch(_ request :  BookSearch_Request, success :@escaping (([Book])->Void), failure: ((String)->Void))
    {
        DispatchQueue.global(qos: .background).async {
            services.request(api: .bookSearch, param: request.dictionary(), success: { (response) in
                success(Book.list(data: response.data as! [Dictionary<String, Any>]))
            }) { (error) in
                
            }
        }
    }
    
    func bookReport(_ request :  BookReport_Request, success :@escaping (()->Void), failure: ((String)->Void))
    {
        DispatchQueue.global(qos: .background).async {
            services.request(api: .bookReport, param: request.dictionary(), success: { (response) in
                success()
            }) { (error) in
                
            }
        }
    }

    
    
    func bookSearchAll(_ request :  BookSearch_Request, success :@escaping (([Book])->Void), failure: ((String)->Void))
    {
        DispatchQueue.global(qos: .background).async {
            services.request(api: .bookSearchAll, param: request.dictionary(), success: { (response) in
                success(Book.list(data: response.data as! [Dictionary<String, Any>]))
            }) { (error) in
                
            }
        }
    }

    
    
    func bookTake(_ request :  BookTake_Request, success :@escaping (()->Void), failure: ((String)->Void))
    {
        DispatchQueue.global(qos: .background).async {
            services.request(api: .bookTake, param: request.dictionary(), success: { (response) in
                success()
            }) { (error) in
                
            }
        }
    }

    func bookUserList(_ request :  BookUserList_Request, success :@escaping (([User])->Void), failure: ((String)->Void))
    {
        DispatchQueue.global(qos: .background).async {
            services.request(api: .bookUserList, param: request.dictionary(), success: { (response) in
                success(User.list(data: response.data as! [Dictionary<String, Any>]))
            }) { (error) in
                
            }
        }
    }
    
    func bookTrading(_ request :  BookTrading_Request, success :@escaping (([Book])->Void), failure: ((String)->Void))
    {
        DispatchQueue.global(qos: .background).async {
            services.request(api: .bookTrading, param: request.dictionary(), success: { (response) in
                success(Book.list(data: response.data as! [Dictionary<String, Any>]))
            }) { (error) in
                
            }
        }
    }
    func bookFeed(_ request :  BookFeed_Request, success :@escaping (([Book])->Void), failure: ((String)->Void))
    {
        DispatchQueue.global(qos: .background).async {
            services.request(api: .bookFeed, param: request.dictionary(), success: { (response) in
                success(Book.list(data: response.data as! [Dictionary<String, Any>]))
            }) { (error) in
                
            }
        }
    }

    func bookUpdateType(_ request :  BookUpdateType_Request, success :@escaping (()->Void), failure: ((String)->Void))
    {
        DispatchQueue.global(qos: .background).async {
            services.request(api: .bookUpdateType, param: request.dictionary(), success: { (response) in
                success()
            }) { (error) in
                
            }
        }
    }
    
    
    func bookUniversity(_ request :  BookUniversity_Request, success :@escaping (([Book])->Void), failure: ((String)->Void))
    {
        DispatchQueue.global(qos: .background).async {
            services.request(api: .bookUniversity, param: request.dictionary(), success: { (response) in
                success(Book.list(data: response.data as! [Dictionary<String, Any>]))
            }) { (error) in
                
            }
        }
    }

}
