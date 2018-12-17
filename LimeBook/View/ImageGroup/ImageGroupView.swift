//
//  ImageGroupView.swift
//  LimeBook
//
//  Created by Lê Dũng on 8/29/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class ImageGroupView: GreenView {
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    @IBOutlet weak var img0: UIImageView!

    
    var canTouch = false ;
    var mediaFiles : [MediaFile] = []

    
    
    
    override func initStyle() {
        super.initStyle()
//        
//        addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(touchIn)))
        
    }
    
    @objc func touchIn()
    {
        if(canTouch)
        {
            let controller = viewController()
            let imaVC = ImageGroupControler()
            imaVC.image = self.mediaFiles
            controller?.push(imaVC)
        }
    }
    
    func setMedia(_ imagePath : [MediaFile])
    {
        self.mediaFiles.removeAll()
        self.mediaFiles.append(contentsOf: imagePath)
        if(imagePath.count  == 0)
        {
            return
        }
        
        if((img0) != nil)
        {
            
            let media0 = imagePath[0]
            
            let job = BlockOperation.init
            {
//                self.img0.sd_setImage(with: URL(string: media0.path), placeholderImage: "userbackground.jpg".image())
                self.img0.sd_setImage(with: URL(string: media0.path), placeholderImage: "userbackground.jpg".image(), options: .refreshCached)

            }
            mediaQueue.mQueue.addOperation(job)

        }
        
        if(img1 != nil)
        {
            if(imagePath.count > 1)
            {
                let media0 = imagePath[1]
                
                let job = BlockOperation.init
                {
                    self.img1.sd_setImage(with: URL(string: media0.path), placeholderImage: "userbackground.jpg".image())
                }
                mediaQueue.mQueue.addOperation(job)

            }
        }
        
        if(img2 != nil)
        {
            if(imagePath.count > 2)
            {
                let media0 = imagePath[2]
                
                let job = BlockOperation.init
                {
                    self.img2.sd_setImage(with: URL(string: media0.path), placeholderImage: "userbackground.jpg".image())
                }
                mediaQueue.mQueue.addOperation(job)
            }

        }

        if(img3 != nil)
        {
            if(imagePath.count > 3)
            {
                let media0 = imagePath[3]
                
                let job = BlockOperation.init
                {
                    self.img3.sd_setImage(with: URL(string: media0.path), placeholderImage: "userbackground.jpg".image())
                }
                mediaQueue.mQueue.addOperation(job)
            }

        }
        
    }

    
}
