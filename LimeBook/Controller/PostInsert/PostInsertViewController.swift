//
//  PostInsertViewController.swift
//  LimeBook
//
//  Created by Lê Dũng on 8/25/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class PostInsertViewController: MasterViewController ,LegancyViewDelegate, RadioViewDelegate{

    
    
    
    @IBOutlet weak var reactR: RadioView!
    @IBOutlet weak var btPost: ButtonSuccess!
    @IBOutlet weak var orthersR: RadioView!
    var othersPostView : OthersPostView! //khac
    var reactView : ReactView!
    
    var masterPost : MasterPostView!
    
    @IBOutlet weak var containerView: GCleanView!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        reactR.set(false, "Review - Cảm nhận")
        orthersR.set(false, "khác")

        reactR.delegate = self;
        orthersR.delegate = self;

        containerView.backgroundColor = template.backgroundColor
        navigationView.set(style: .back, title: "Đăng Tin") {
            self.navigationController?.popViewController(animated: false)
        }
        btPost.isHidden = true
        
        let isAcceptLegancy = userInstance.getAcceptLagency()
        if(!isAcceptLegancy)
        {
            let legancyView = LegancyView()
            legancyView.delegate = self;
            view.alertBox(legancyView, ratio: 0.9)
        }
        
    }
    
    @IBOutlet weak var mainView: UIView!
    
    func reloadAll()
    {
        mainView.removeSubsView()
    }
    
    func radioChangeState(_ value: Bool, sender: RadioView) {
        
        
        btPost.isHidden = false;
        view.endEditing(true)
        
        uncheckAll()
        sender.check()
        reloadAll()
        
        if(sender == reactR)
        {
            if(reactView == nil)
            {
                reactView = ReactView.init(frame: CGRect.init())

            }
            actvieView(reactView)
        }
        
        else if(orthersR == sender)
        {
            if( othersPostView == nil)
            {
                othersPostView = OthersPostView.init(frame: CGRect.init()) //khac
            }
            actvieView(othersPostView)
        }
    }
    
    func actvieView(_ value : UIView)
    {
        self.masterPost = (value as! MasterPostView)
        reloadAll()
        mainView.addSubview(value)
        mainView.setLayout(value)
    }
    
    func uncheckAll()
    {
        reactR.uncheck()
        orthersR.uncheck()
    }

    @IBAction func postTouch(_ sender: Any) {
        
        
        view.endEditing(true)
        
        let errorString = self.masterPost.getError()
        if(errorString != nil)
        {
            view.dialog(title: "Thông báo lỗi", desc: errorString!, type: .warning, acceptBlock: {
            }) {
            }
            return;
        }
        
        
        let totalRequest = self.masterPost.getPostPakage()
        if(totalRequest == nil)
        {
            return;
        }
        let imageList = totalRequest?.1
        
        if((imageList?.count)! > 0)
        {
            var imagesUpload : [UIImage] = []
            var mediaFiles : [MediaFile] = []
            
            for item in imageList!
            {
                if(item.isLocal)
                {
                    imagesUpload .append(item.image)
                }
                else
                {
                    mediaFiles.append(MediaFile.init(item.imageURL, .image))
                }
            }

            view.showHud()
            services.uploadMediaLowQuality(MediaBrand.book,images: imagesUpload, success: { (respone) in
                self.view.hideHub()
                if(respone.data is Array<Any>)
                {
                    let mediaFilesResponse = MediaFile.list(data: respone.data as! [Dictionary<String, Any>])
                    mediaFiles.append(contentsOf: mediaFilesResponse)
                    if(self.reactR.isCheck)
                    {
                        self.requestFellingInsert((totalRequest?.0)! as! FeelingInsert_Request, file: mediaFiles)
                    }
                    else
                    {
                        self.request((totalRequest?.0)! as! BookInsert_Request, file: mediaFiles)
                    }
                }
            }, failure: { (error) in
                self.view.hideHub()

            }) { (progress) in
            }
        }
        else
        {
            self.view.hideHub()
            if(self.reactR.isCheck)
            {
                self.requestFellingInsert((totalRequest?.0)! as! FeelingInsert_Request, file: [])
            }
            else
            {
                self.request((totalRequest?.0)! as! BookInsert_Request, file: [])

            }

        }
        
    }
    
    
    //BookInsert
    func request(_ request : BookInsert_Request, file : [MediaFile])
    {
        let endRequest = request
        for item in file
        {
            endRequest.images.append(item.path)
        }
        view.showHud()
        services.bookInsert(request, success: { () in
            self.view.hideHub()
            self.view.dialog(title: "Thông báo", desc: "Đăng bài thành công", type: .infoConfirm, acceptBlock: {
                self.masterPost.clear()
            }, cancelBlock: {
                
            })
        }) { (error) in
            self.view.hideHub()

        }
    }
    
    func requestFellingInsert(_ request : FeelingInsert_Request, file : [MediaFile])
    {
        let endRequest = request
        for item in file
        {
            endRequest.images.append(item.path)
        }
        
        view.showHud()
        services.feelingInsert(request: endRequest, success: {
            self.view.hideHub()
            self.view.dialog(title: "Thông báo", desc: "Đăng bài thành công", type: .infoConfirm, acceptBlock: {
                self.masterPost.clear()
            }, cancelBlock: {
                
            })

        }) { (error) in
            self.view.hideHub()
        }
    }
    
    func LegancyViewDidClose() {
        view.hideAlertBox()
    }
    
}
