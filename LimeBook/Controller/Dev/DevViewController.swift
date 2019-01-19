//
//  DevViewController.swift
//  MiBook
//
//  Created by Lê Dũng on 1/12/19.
//  Copyright © 2019 limerence. All rights reserved.
//

import UIKit

extension UILabel
{
    var textAnimation: String? {
        
        get { return text }
        set {
            
            if(newValue?.isEmpty)!
            {
                text = "-"
            }
            else
            {
                if(self.text! != newValue)
                {
                    UIView.transition(with: self, duration: 0.24, options: .transitionCrossDissolve, animations: {
                        self.backgroundColor = UIColor.random()

                    }) { (resBool) in

                        
                        UIView.transition(with: self, duration: 0.24, options: .transitionCrossDissolve, animations: {
                            self.backgroundColor = UIColor.white

                        }) { (resBool) in
                            
                        }

                    }
                }
                text = newValue
            }
        }
    }
    
}



class AnimationLabel: UILabel {
    
    
    

}










class DevViewController: MasterViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var lbDes: UILabel!
    
    @IBAction func touchIn(_ sender: Any)
    {
        lbDes.textAnimation = String.random(8)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
