//
//  colonyDrawer.swift
//  IosGameOfLife
//
//  Created by daniel bauman on 11/22/16.
//
//

import UIKit

struct Line {
    var begin = CGPoint.zero
    var end = CGPoint.zero
}

class colonyDrawer: UIView {
    func strokeLine(line: Line) {
        let path = UIBezierPath()
        path.lineWidth = 3
        path.lineCapStyle = CGLineCap.Round
        path.moveToPoint(line.begin)
        path.addLineToPoint(line.end)
        path.stroke()
    }
    
    override func drawRect(rect: CGRect) {
        var l = Line()
        UIColor.redColor().setStroke()
        l.begin = CGPointMake(0, 0)
        l.end = CGPointMake(rect.maxX, rect.maxY)
        strokeLine(l)
        
        UIColor.greenColor().setStroke()
        l.begin = CGPointMake(0, rect.maxY)
        l.end = CGPointMake(rect.maxX, 0)
        strokeLine(l)
        
        let leftMargin = (rect.width - 200) / 2
        let topMargin = (rect.height - 200) / 2
        
        let rectangle  = CGRectMake(leftMargin, topMargin, 200.0, 200.0)
        
        let context = UIGraphicsGetCurrentContext()
        CGContextSetRGBFillColor(context, 0.0, 0.0, 100.0, 0.5)
        CGContextSetRGBStrokeColor(context, 0.0, 0.0, 100.0, 0.5)
        CGContextFillRect(context, rectangle)
    }
}


