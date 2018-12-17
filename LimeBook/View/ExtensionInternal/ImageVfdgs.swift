//
//  ImageVfdgs.swift
//  LimeBook
//
//  Created by Lê Dũng on 8/29/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

import AlamofireImage
import Alamofire
extension  UIImageView
{
    func setMedia(_ urlString : String)
    {
        let url = URL.init(string: urlString)
        image = nil ;
        if(url != nil)
        {
            af_setImage(withURL: url!)
        }
    }
    
    func setMediaFile(_ file : MediaFile)
    {
        image = "userbackground.jpg".image();
        if(file.getImage() == nil)
        {
            weak var weakself = self;
            let job = BlockOperation.init {
                
                weakself?.af_setImage(withURL: URL.init(string: file.path)!, placeholderImage: nil, filter: nil, progress: { (progress) in
                    
                }, progressQueue: DispatchQueue.global(), imageTransition: UIImageView.ImageTransition.noTransition, runImageTransitionIfCached: false) { (response) in
                    if(response.result.value != nil)
                    {
                        DispatchQueue.main.async {
                            weakself?.image = (response.result.value )
                            file.content = (response.result.value )
                            
                            let imgData: NSData = NSData(data: UIImageJPEGRepresentation((response.result.value ?? UIImage()), 1)!)
                            // var imgData: NSData = UIImagePNGRepresentation(image)
                            // you can also replace UIImageJPEGRepresentation with UIImagePNGRepresentation.
                            let imageSize: Int = imgData.length
                            print("size of image in KB: %f ", Double(imageSize) / 1024.0)

                        }
                    }
                }
            }
            mediaQueue.mQueue.addOperation(job)
        }
        else
        {
            image = file.getImage()!
        }

    }

}
