//
//  mapcontent.swift
//  my first cocoa application
//
//  Created by 王彥欽 on 2015/5/26.
//  Copyright (c) 2015年 Yen-chin Wang. All rights reserved.
//

import Cocoa

class green: NSViewController {

    @available(OSX 10.10, *)
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        let pic:NSImage=NSImage(named: "2.jpg")!
        let img:NSImageView=NSImageView(frame: self.view.frame)
        img.image=pic
        self.view=img
    }
    
}
