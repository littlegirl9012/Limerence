//
//  FeelingListView.swift
//  LimeBook
//
//  Created by Lê Dũng on 10/11/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

protocol FeelingListViewDelegate {
    func feelingListViewDidTouch(_ feel : Feelling)
}

class FeelingListView: GreenView , UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    var delegate : FeelingListViewDelegate!
    @IBOutlet weak var clView: UICollectionView!

    var fList : [Feelling] = []
    
    var book : Book!
    
    func loadData()
    {
        let request = FeelingList_Request()
        request.book_id = self.book.id
        services.feelingList(request: request, success: { (response) in
            self.fList.removeAll()
            self.fList.append(contentsOf: response)
            self.clView.reloadData()
        }) { (error) in
            
        }
    }
    
    override func initStyle() {
        
        clView.setIdentifier("FeelingListCell")
        clView.delegate = self;
        self.clView.dataSource = self;
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = clView.dequeueReusableCell(withReuseIdentifier: "FeelingListCell", for: indexPath) as! FeelingListCell
        cell.set(fList[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 56, height: 56)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate.feelingListViewDidTouch(fList[indexPath.row])
    }
}
