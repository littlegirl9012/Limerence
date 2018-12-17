//
//  MediaFile.swift
//  LimeBook
//
//  Created by Lê Dũng on 8/28/18.
//  Copyright © 2018 limerence. All rights reserved.
//
import SDWebImage
import UIKit
import Alamofire

enum MediaType : Int
{
    case image = 2
    case info = 1
    case conference = 3
}



enum MediaBrand : Int
{
    case book = 2
    case info = 1
    case conference = 3
}


class MediaFile: Mi {
    
    @objc dynamic var destination = "";
    @objc dynamic var encoding = "";
    @objc dynamic var fieldname = "";
    @objc dynamic var filename = "";
    @objc dynamic var mimetype = "";
    @objc dynamic var originalname = "";
    @objc dynamic var path = "";
    @objc dynamic var size = 1;
    var isDowload = false ;
    
    var media_type = MediaType.image;
    var content : Any? ;
    
    class func  list(data : [Dictionary<String, Any>]) -> [MediaFile]
    {
        var output  : [MediaFile]  = []
        for item in data
        {
            let unit = MediaFile.init(dictionary: item as NSDictionary)
            output.append(unit)
        }
        return output
    }
    
    override init(dictionary: NSDictionary) {
        super.init(dictionary: dictionary)
    }
    
    
    func downloadContent()
    {
        if(content == nil)
        {
            let operation = BlockOperation.init {
                DispatchQueue.global(qos: .background).async {
                    Alamofire.request(self.path).responseImage { response in
                        if let dataRep = response.result.value {
                            self.content = dataRep
                        }
                    }
                }
            }
            mediaQueue.mQueue.addOperation(operation)
        }
    }
    
    
    func downloadImageContent(complete : @escaping ((UIImage)->Void))
    {
        if(content == nil)
        {
            if(isDowload == true)
            {
                return
            }
            isDowload = true
                SDWebImageDownloader.shared().downloadImage(with: URL.init(string: self.path), options: SDWebImageDownloaderOptions.continueInBackground, progress: { (a1, q1, urrl) in
                    
                }) { (result, data, errror, falue) in
                    self.isDowload = false
                    if(result != nil)
                    {
                        self.content = result
                        result!.logSize()
                        complete(result!)
                    }
                }
        }
        else
        {
            complete(getImage()!)
        }
    }

    func getImage()->UIImage?
    {
        return content as! UIImage?
    }
    
    init(_ path : String, _ type : MediaType) {
        super.init()
        self.path = path
        if(self.path.length == 0 )
        {
            content = "userbackground.jpg".image()
        }
    }
    
    required init() {
        super.init()
    }

}
