//
//  AppDelegate.swift
//  my first cocoa application
//
//  Created by 王彥欽 on 2014/7/13.
//  Copyright (c) 2014年 Yen-chin Wang. All rights reserved.
//

import Cocoa

class AppDelegate: NSObject,NSApplicationDelegate {
    
    @IBOutlet weak var window:NSWindow!
    
    @IBOutlet weak var map: NSView!
    
    @IBOutlet weak var radiobtn: NSMatrix!
    @IBOutlet weak var mapcontroller: NSViewController!
    @IBOutlet weak var thepop:NSPopover!
    @IBOutlet weak var showbtn: NSButton!
    
    
    @IBAction func radiobtnpick(sender: AnyObject) {
        let tag=radiobtn.selectedTag()
        
        switch(tag){
        case 1:
            mapcontroller.view.removeFromSuperview()
            showbtn.enabled = false
            created=worldmapcontroller(nibName:"worldmapcontroller",bundle:nil)!
            mapcontroller=created
            map.addSubview(mapcontroller.view)
            
        case 2:
            mapcontroller.view.removeFromSuperview()
            showbtn.enabled = false
            created=green(nibName:"green",bundle:nil)!
            mapcontroller=created
            map.addSubview(mapcontroller.view)
        case 3:
            mapcontroller.view.removeFromSuperview()
            showbtn.enabled = true
            created=hsinchu(nibName:"hsinchu",bundle:nil)!
            mapcontroller=created
            map.addSubview(mapcontroller.view)
        default:
            //Should never get there
            break;
        }
    }
    
    @IBAction func mybutton(sender: AnyObject) {
        thepop.showRelativeToRect(sender.bounds, ofView: sender as! NSView , preferredEdge: NSRectEdge.MinX)
    }
    var created:NSViewController=NSViewController()
    
        
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        window.setContentSize(NSMakeSize(766, 595))
        radiobtn.selectCellAtRow(0, column: 0)
        created=worldmapcontroller(nibName:"worldmapcontroller",bundle:nil)!
        mapcontroller=created
        map.addSubview(mapcontroller.view)
        showbtn.enabled = false
    }
    func applicationWillTerminate(aNotification: NSNotification) {
    }
}