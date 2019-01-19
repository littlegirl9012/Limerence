//
//  MKNode.swift
//  MiBook
//
//  Created by Lê Dũng on 1/8/19.
//  Copyright © 2019 limerence. All rights reserved.
//

import UIKit

enum MKNodeDrawType
{
    case x
    case y
    case z
}

enum MKNodeDataType
{
    case text
    case view
}

class MKNode: NSObject {
    
    var child : [MKNode]! = []
    
    var hrcList : [MKNode] = []
    
    var drawView : UIView!
    var drawType = MKNodeDrawType.x
    var content  = ""
    var crossSize : CGFloat = 0
    
    var dataType : MKNodeDataType = .text
    
    private var isDraw = false ;
    private var canTouchIn = false;
    
    
    
    var displayIndex = -1 ;
    
    weak var parend : MKNode!

    private func drawText()
    {
        if(drawView is UILabel)
        {
            (drawView as! UILabel).text = content
        }
    }
    
    func generateItem(_ item : MKNode)
    {
        self.hrcList.append(item)
        for childItem in item.child
        {
            generateItem(childItem)
        }
    }

    func initHRC()
    {
        hrcList.removeAll()
        generateItem(self)
    }
    
    func index()->Int
    {
        return parend.child.index{$0 === self} ?? -1
    }
    
    func isLeft() -> Bool
    {
        return index() == 0
    }
    
    func isNext() ->Bool
    {
        return !isLeft()
    }
    
    func isRight() ->Bool
    {
        return index() == (parend.child.count - 1)
    }
    
    func previousNode()->MKNode
    {
        return parend.child[index() - 1]
    }
    
    func lastNode()->MKNode
    {
        return parend.child[index() + 1]
    }
    
    func refNode()->MKNode?
    {
        if let target = parend.child.index(where: {$0.crossSize == 0})
        {
            return parend.child[target]
        }
        return nil
    }

    convenience init(_ text : String ) {
        self.init()
        content = text
        drawView = UILabel.init()
        drawText()
        drawView.backgroundColor = UIColor.random()
        setText(color: UIColor.white, font: UIFont.systemFont(ofSize: 14), aligment: .center)
    }
    
    convenience init(_ customView : UIView ) {
        self.init()
        drawView = customView
        dataType = .view
    }

    
    func setText(color : UIColor, font : UIFont, aligment : NSTextAlignment)
    {
        (drawView as! UILabel).textColor = color
        (drawView as! UILabel).font = font
        (drawView as! UILabel).textAlignment = aligment
        dataType = .text
    }

    
     convenience init(_ child : [MKNode] , type : MKNodeDrawType) {
        self.init()
        self.drawType = type
        self.child = child.map{
            let mutableBook = $0
            mutableBook.parend = self;
            return mutableBook
        }
    }
    convenience init(_ child : [String] , type : MKNodeDrawType)
    {
        self.init()
        self.drawType = type
        var temp : [MKNode] = []
        for item in child
        {
            temp.append(MKNode.init(item))
        }
        self.child = temp.map{
            let mutableBook = $0
            mutableBook.parend = self;
            return mutableBook
        }
    }

    
    func initDrawView()
    {
        if(drawView == nil)
        {
            drawView = UIView.init()
        }
    }
    
    func draw()
    {
        if(!isDraw)
        {
            initDrawView()
            for item in child
            {
                item.draw()
            }
            MKNodeDrawView()
            isDraw = true
            if(drawType == .z)
            {
                addGest()
            }
        }
        
    }
    
    func addGest()
    {
        if(!canTouchIn)
        {
            return
        }
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(touchIn))
        drawView.addGestureRecognizer(tap)
        displayIndex = child.count - 1 ;
    }
    
    @objc func touchIn()
    {
        drawView.sendSubview(toBack: drawView.subviews.last!)

        displayIndex = displayIndex - 1
        if(displayIndex < 0)
        {
            displayIndex = child.count - 1
        }
        updateIndexDisplay()
        var tableView: UITableView? {
            var view = self.drawView.superview
            while (view != nil && view!.isKind(of: UITableView.self) == false) {
                view = view!.superview
            }
            return view as? UITableView
        }
        tableView?.reloadData()
    }
    
    func getMaxCrossSize()->CGFloat
    {
        if(child.count > 0)
        {
            return child.map {$0.crossSize }.max() ?? -1
        }
        return CGFloat(-1)
    }
    
    
    func mirrow(_ mirrowNode : MKNode?)
    {
        if(mirrowNode == nil)
        {
            return ;
        }
        weak var weakself = self
            mirrowNode!.initHRC()
            weakself?.initHRC()
            for i in 0..<mirrowNode!.hrcList.count
            {
                let currentNode = weakself?.hrcList[i]
                let refNode = mirrowNode!.hrcList[i]
                currentNode?.displayIndex = refNode.displayIndex
                currentNode?.updateIndexDisplay()
            }
    }
    
    func updateIndexDisplay()
    {
        if((displayIndex > -1) && (drawType == .z))
        {
            hidenChild()
            drawView.bringSubview(toFront: child![displayIndex].drawView)
            child![displayIndex].drawView.isHidden = false
        }
    }
    
    func setCantouchZ(_ enable : Bool)
    {
        canTouchIn = enable
        for item in child
        {
            item.setCantouchZ(enable)
        }
    }
    
    func hidenChild()
    {
        for item in child
        {
            item.drawView.isHidden = true;
        }
    }
}



