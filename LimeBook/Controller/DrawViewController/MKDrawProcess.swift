//
//  MKDrawProcess.swift
//  MiBook
//
//  Created by Lê Dũng on 1/8/19.
//  Copyright © 2019 limerence. All rights reserved.
//

import UIKit

extension MKNode {

    fileprivate func drawBaseX()
    {
        parend.drawView.addConstraint(NSLayoutConstraint(item: drawView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem:  parend.drawView, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: 0))
        parend.drawView.addConstraint(NSLayoutConstraint(item: drawView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem:  parend.drawView, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 0))
    }
    
    fileprivate func drawBaseY()
    {
        parend.drawView.addConstraint(NSLayoutConstraint(item: drawView, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem:  parend.drawView, attribute: NSLayoutAttribute.left, multiplier: 1.0, constant: 0))
        parend.drawView.addConstraint(NSLayoutConstraint(item: drawView, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem:  parend.drawView, attribute: NSLayoutAttribute.right, multiplier: 1.0, constant: 0))
    }

    fileprivate func drawBaseZ()
    {
    }

    //Vẽ size
    fileprivate func drawSizeX()
    {
        if(crossSize > 0)
        {
            let widthConstraint = NSLayoutConstraint(item: drawView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: crossSize)
            NSLayoutConstraint.activate([widthConstraint])
        }
        else
        {
            let widthConstraint = NSLayoutConstraint(item: drawView, attribute: .width, relatedBy: .equal, toItem: refNode()?.drawView, attribute: .width, multiplier: 1, constant: 0.0)
            NSLayoutConstraint.activate([widthConstraint])
        }
    }
    
    fileprivate func drawSizeY()
    {
        if(crossSize > 0)
        {
            let heightContrait = NSLayoutConstraint(item: drawView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: crossSize)
            NSLayoutConstraint.activate([heightContrait])
        }
        else
        {
            let heightContrait = NSLayoutConstraint(item: drawView, attribute: .height, relatedBy: .equal, toItem: refNode()?.drawView, attribute: .height, multiplier: 1, constant: 0.0)
            NSLayoutConstraint.activate([heightContrait])
        }
    }
    
    fileprivate func drawSizeZ()
    {
        let heightContrait = NSLayoutConstraint(item: drawView, attribute: .height, relatedBy: .equal, toItem: parend.drawView, attribute: .height, multiplier: 1, constant: 0.0)
        let widthContrait = NSLayoutConstraint(item: drawView, attribute: .width, relatedBy: .equal, toItem: parend.drawView, attribute: .width, multiplier: 1, constant: 0.0)
        NSLayoutConstraint.activate([heightContrait,widthContrait])
    }
    fileprivate func drawLeftX()
    {
        parend.drawView.addConstraint(NSLayoutConstraint(item: drawView, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem:  parend.drawView, attribute: NSLayoutAttribute.leading, multiplier: 1.0, constant: 0))
    }
    
    fileprivate func drawLeftY()
    {
        parend.drawView.addConstraint(NSLayoutConstraint(item:drawView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: parend.drawView , attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: 0))
    }
    
    fileprivate func drawLeftZ()
    {
        
    }

    //-----------------
    fileprivate func drawRightX()
    {
        parend.drawView.addConstraint(NSLayoutConstraint(item:drawView, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem:  parend.drawView, attribute: NSLayoutAttribute.right, multiplier: 1.0, constant: 0))
    }
    
    fileprivate func drawRightY()
    {
        parend.drawView.addConstraint(NSLayoutConstraint(item: drawView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem:parend.drawView , attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 0))
    }
    
    fileprivate func drawRightZ()
    {
        
    }
    
    fileprivate func drawNextX()
    {
        let leftEdge = NSLayoutConstraint(item: previousNode().drawView, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: drawView, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([leftEdge])
    }
    
    fileprivate func drawNextY()
    {
        let leftEdge = NSLayoutConstraint(item: previousNode().drawView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: drawView, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([leftEdge])
    }
    
    fileprivate func drawNextZ()
    {
        
    }
    
    //------------------------------------

    func drawLeft()
    {
        if(parend.drawType == .x)
        {
            drawLeftX()
        }
        else if(parend.drawType == .y)
        {
            drawLeftY()
        }
        else
        {
            drawLeftZ()
        }
    }
    
    func drawSize()
    {
        
    }
    
    func drawRight()
    {
        if(parend.drawType == .x)
        {
            drawRightX()
        }
        else if(parend.drawType == .y)
        {
            drawRightY()
        }
        else
        {
            drawRightZ()
        }
    }

    func drawNext()
    {
        if(parend.drawType == .x)
        {
            drawNextX()
        }
        else if(parend.drawType == .y)
        {
            drawNextY()
        }
        else
        {
            drawNextZ()
        }
    }
    
    func MKNodeDrawView()
    {
        for item in child
        {
            drawView.addSubview(item.drawView)
            if(item.child.count == 0)
            {
                _ = item.drawView.line(edges: .all, color: .red)
            }
            item.drawView.translatesAutoresizingMaskIntoConstraints = false
            
            if(drawType == .x)
            {
                item.drawBaseX()
                item.drawSizeX()
            }
            else if(drawType == .y)
            {
                item.drawBaseY()
                item.drawSizeY()
            }
            else
            {
                item.drawBaseX()
                item.drawBaseY()
                item.drawSizeZ()
                continue
            }
            
            if(item.isLeft())
            {
                item.drawLeft()
            }
            if(item.isNext())
            {
                item.drawNext()
            }
            if(item.isRight())
            {
                item.drawRight()
            }
        }
    }
}



extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
extension UIColor {
    static func random() -> UIColor {
        return UIColor(red:   .random(),
                       green: .random(),
                       blue:  .random(),
                       alpha: 1.0)
    }
}



extension UIView
{
    
    func line(edges: UIRectEdge,
                    color: UIColor,
                    inset: CGFloat = 0.0,
                    thickness: CGFloat = 0.5) -> [UIView] {
        
        var borders = [UIView]()
        
        @discardableResult
        func addBorder(formats: String...) -> UIView
        {
            let border = UIView(frame: .zero)
            border.backgroundColor = color
            border.translatesAutoresizingMaskIntoConstraints = false
            addSubview(border)
            addConstraints(formats.flatMap {
                NSLayoutConstraint.constraints(withVisualFormat: $0,
                                               options: [],
                                               metrics: ["inset": inset, "thickness": thickness],
                                               views: ["border": border]) })
            borders.append(border)
            return border
        }
        
        
        if edges.contains(.top) || edges.contains(.all) {
            addBorder(formats: "V:|-0-[border(==thickness)]", "H:|-inset-[border]-inset-|")
        }
        
        if edges.contains(.bottom) || edges.contains(.all) {
            addBorder(formats: "V:[border(==thickness)]-0-|", "H:|-inset-[border]-inset-|")
        }
        
        if edges.contains(.left) || edges.contains(.all) {
            addBorder(formats: "V:|-inset-[border]-inset-|", "H:|-0-[border(==thickness)]")
        }
        
        if edges.contains(.right) || edges.contains(.all) {
            addBorder(formats: "V:|-inset-[border]-inset-|", "H:[border(==thickness)]-0-|")
        }
        
        return borders
    }

}
