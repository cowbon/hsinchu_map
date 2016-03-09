//
//  symbol.swift
//  my first cocoa application
//
//  Created by 王彥欽 on 2015/6/18.
//  Copyright (c) 2015年 Yen-chin Wang. All rights reserved.
//

import Cocoa

class symbol: NSView {

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        
        let b = NSMakeRect(3, 53, 5, 5)
        NSColor.redColor().setFill()
        NSRectFill(b)
        
        let str="point of interest"
        (str as NSString).drawAtPoint(NSMakePoint(25, 50), withAttributes: nil)
        
        
        let c = NSBezierPath()
        c.moveToPoint(NSPoint(x: 1, y: 70))
        c.lineToPoint(NSPoint(x: 15, y: 70))
        NSColor.greenColor().setStroke()
        c.lineWidth = 3
        c.stroke()
        
        ("City-County Border" as NSString).drawAtPoint(NSPoint(x: 27, y: 65), withAttributes: nil)
        
        let d = NSBezierPath()

        d.moveToPoint(NSPoint(x: 1, y: 40))
        d.lineToPoint(NSPoint(x: 15, y: 40))
        NSColor.blueColor().setStroke()
        d.lineWidth = 3
        d.stroke()
        
        ("river" as NSString).drawAtPoint(NSMakePoint(27, 35), withAttributes: nil)
        
        c.moveToPoint(NSPoint(x: 1, y: 27))
        c.lineToPoint(NSPoint(x: 15, y: 27))
        c.setLineDash([5.0,5.0], count: 2, phase: 0.0)
        c.stroke()
        
        ("Border" as NSString).drawAtPoint(NSMakePoint(27, 20), withAttributes: nil)
        
        
        // Drawing code here.
    }
    
}
