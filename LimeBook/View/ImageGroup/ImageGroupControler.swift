//
//  ImageGroupControler.swift
//  LimeBook
//
//  Created by Lê Dũng on 8/31/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class ImageGroupControler: UIViewController, UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var btShare: UIButton!
    
    @IBOutlet weak var btDownload: UIButton!
    @IBOutlet weak var btBack: UIButton!
    
    @IBOutlet weak var paging: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var clView: UICollectionView!
    var image : [MediaFile] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        clView.setIdentifier("ImageGroupCell")
        btBack.image("DefaultBack".image(), template.highlightTextColor)
        btShare.image("share".image(), template.highlightTextColor)
        btDownload.image("folder".image(), template.highlightTextColor)

        clView.reloadData()
        
        
        paging.numberOfPages = image.count
        paging.currentPageIndicatorTintColor = template.primaryColor
        paging.pageIndicatorTintColor = template.subTextColor

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func backTouch(_ sender: Any) {
        pop()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = clView.dequeueReusableCell(withReuseIdentifier: "ImageGroupCell", for: indexPath) as! ImageGroupCell
        cell.set(image[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return image.count
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: device.screenSize.width, height: clView.frame.size.height)
    }
    
    
    
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var visibleRect = CGRect()
        
        visibleRect.origin = clView.contentOffset
        visibleRect.size = clView.bounds.size
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        guard let indexPath = clView.indexPathForItem(at: visiblePoint) else { return }
        paging.currentPage = indexPath.row
        print(indexPath)
    }

    
    
}
