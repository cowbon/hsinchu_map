//
//  worldmapcontroller.swift
//  my first cocoa application
//
//  Created by 王彥欽 on 2015/5/28.
//  Copyright (c) 2015年 Yen-chin Wang. All rights reserved.
//

import Cocoa

class worldmapcontroller: NSViewController {

    override func viewDidLoad() {
        if #available(OSX 10.10, *) {
            super.viewDidLoad()
        } else {
            // Fallback on earlier versions
        }
        // Do view setup here.
        let pic:NSImage?=NSImage(named: "BlankMap-World-1ce")
        let img:NSImageView=NSImageView(frame: self.view.frame)
        img.image=pic
        self.view=img
    }
    
    
}
