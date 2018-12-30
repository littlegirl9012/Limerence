
enum APIFunction : String
{
    case userDetail =               "user/detail"
    case userConsultant =           "user/consultant"
    case userLogin =                "user/login"
    case userLoginFacebook =        "user/login/facebook"
    case userRegister =             "user/register"
    case userUpdateAA =             "user/update/aa"
    case userUpdateToken =          "user/update/token"
    case userUpdateAvatar =         "user/update/avatar"
    case userUpdateInfo =           "user/update/info"
    case userNear =                 "user/near"
    case userSearch =               "user/search"
    case userInfo =                 "user/info"

    case uploadMedia = "upload/media"
    case bookInsert = "book/insert"
    case bookUpdate = "book/update"
    case bookTypeList = "book_24/type/list"

    case bookLatest     = "book_24/latest"
    case bookSearch     = "book/search"
    case bookTake       = "book/take"
    case bookUserList   = "book/user/list"
    case bookSearchAll  = "book/search/all"
    case bookTrading    = "book/trading"
    case bookFeed       = "book/feed"
    case bookReport     = "book/report"
    case bookUpdateType     = "book/update/type"

    
    
    
    case bookCommentList = "book/comment/list"
    case bookCommentInsert = "book/comment/insert"
    case bookUser = "book_24/user"
    case bookUserSelect = "book/user/select"

    case bookUserAll = "book/user/all"
    case bookDetail = "book_24/detail"
    case bookDelete = "book/delete"
    case bookLocation = "book/location"
    case bookLike = "book/like"

    case notificationSubscribe = "notification/subscribe"
    case notificationList = "notification/list"
    case notificationDelete = "notification/delete"

    case contactList = "contact/list"
    case contactAccept = "contact/accpet"
    case contactDelete = "contact/delete"

    case applicationInfo = "application/get/info"

    case deviceUpdate = "device/update"

    case categoryList = "category/list"
    case bookLibrary = "book/library"
    
    
    
    
    case authorList =               "authorList"
    case authorSearch =             "author/search"

    case feelingInsert = "feeling/insert"
    case feelingList = "feeling/list"
    
    
    
    
    
    case adminBookTikiInsert = "admin/book/tiki/insert"
    
}


