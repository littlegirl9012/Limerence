//
//  MediaQueue.swift
//  LimeBook
//
//  Created by Lê Dũng on 9/23/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit
let  mediaQueue = MediaQueue.sharedInstance()
class MediaQueue: NSObject {

    static var instance: MediaQueue!
    var mQueue =  OperationQueue.init()
    var messageQueue =  DispatchQueue.init(label: "messageQueue")

    
    
    
    
    
    class func sharedInstance() -> MediaQueue
    {
        if(self.instance == nil)
        {
            self.instance = (self.instance ?? MediaQueue())
            self.instance.queueConfig()
        }
        return self.instance
    }

    func queueConfig()
    {
        mQueue.maxConcurrentOperationCount = 100 ;
    }
}
