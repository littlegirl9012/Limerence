//
//  ComposeImageView.swift
//  MiBook
//
//  Created by Lê Dũng on 2/10/19.
//  Copyright © 2019 limerence. All rights reserved.
//

import UIKit

protocol ComposeImageViewDelegate : class {
    func ComposeImageViewSend(_ image : UIImage?)
    func ComposeImageViewCancel()
}

class ComposeImageView: GreenView {
    
    weak var delegate : ComposeImageViewDelegate?
    var image : UIImage?{
        set{
            imgView.image = newValue
        }
        get{
            return imgView.image
        }
    }
    @IBOutlet weak var btCancel: UIButton!
    @IBOutlet weak var btSend: UIButton!
    
    @IBOutlet weak var imgView: UIImageView!
    
    override func initStyle() {
        
    }

    @IBAction func accept(_ sender: Any) {
        delegate?.ComposeImageViewSend(image)
    }
    @IBAction func cancelTouch(_ sender: Any) {
        delegate?.ComposeImageViewCancel()
        
    }
    
    deinit {
        print("ComposeImageView-----Deinit")
    }
}
