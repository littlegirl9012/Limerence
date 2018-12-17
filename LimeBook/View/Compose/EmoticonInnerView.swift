//
//  EmoticonInnerView.swift
//  LimeBook
//
//  Created by Lê Dũng on 8/20/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit
public class Emoj: NSTextAttachment {
    
    @objc  var emojTag = "sss:)"
    public var name  = ""
    public var eType = -1
    
}

protocol EmoticonInnerDelegate {
    func emoticonDidSelect(_ attach : EmojiTextAttachment)
}

class EmoticonInnerView: GreenView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var clView: UICollectionView!
    
    var delegate : EmoticonInnerDelegate!
    var emojs : [EmojiTextAttachment] = []
    override func initStyle() {
        
        
        for i in 0...53
        {
            var  image : UIImage!
            let emoj = EmojiTextAttachment()
            if(i < 10 )
            {
                emoj.emojTag = "["+("emj" + "0" + String(i))+"]"
                image = ("emj" + "0" + String(i)).image()
            }
            else
            {
                emoj.emojTag = "["+("emj" + String(i))+"]"
                image = ("emj" + String(i)).image()
            }
            emoj.image = image
            emojs.append(emoj)
            emoj.bounds = CGRect.init(x: 0, y: 0, width: 16, height: 16)
            
        }
        
        clView.setIdentifier("EmojCell")
        clView.delegate = self;
        clView.dataSource = self;
        clView.reloadData()
        
        view.backgroundColor = "D5D5Db".hexColor()

    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = clView.dequeueReusableCell(withReuseIdentifier: "EmojCell", for: indexPath) as! EmojCell
        cell.set(emojs[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize.init(width: 50, height: 50);
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return emojs.count;

    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let newsF = EmojiTextAttachment.init()
        newsF.emojTag = emojs[indexPath.row].emojTag
        
        var imageTag = newsF.emojTag.replacingOccurrences(of: "[", with: "")
        imageTag = imageTag.replacingOccurrences(of: "]", with: "")

        newsF.image = imageTag.image()
        delegate.emoticonDidSelect(newsF)
    }
}
