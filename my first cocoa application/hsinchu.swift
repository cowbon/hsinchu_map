//
//  worldmap.swift
//  my first cocoa application
//
//  Created by 王彥欽 on 2015/5/28.
//  Copyright (c) 2015年 Yen-chin Wang. All rights reserved.
//

import Cocoa

class hsinchu: NSViewController {
    
    //required init?(coder aDecoder: NSCoder) {
      //  super.init(coder: aDecoder)
    //}
    //let delegate:AppDelegate = NSApplication.sharedApplication().delegate as! AppDelegate
    
    
    @IBOutlet var mypop: NSPopover!
    @IBOutlet weak var spotname: NSTextField!
    @IBOutlet weak var spotimage: NSImageView!
    @IBOutlet weak var opengl: myopenglview!
    @IBOutlet weak var river1: NSPopover!
    @IBOutlet weak var river2: NSPopover!
    
    
    struct interest {
        var x:Float
        var y:Float
        var name:String
        var pic_source:String!
    }
    
    let poi_url:[String] = ["http://www.vrwalker.net/public/sceneryfiles/684/684_6655_1278404554.jpg",
                            "http://www.tonyhuang39.com/tony0767/20100416_01.JPG",
                            "http://e.blog.xuite.net/e/a/4/7/19823792/blog_1103936/txt/20766627/0.jpg",
                            "http://pic.pimg.tw/travel2tp/04a599cdf24f1c203147849ee0022c28.jpg",
                            "http://6.blog.xuite.net/6/b/3/7/12109262/blog_665180/txt/18988766/0.jpg",
                            "http://archives.hakka.gov.tw/e_upload_hakka/cms/webEdit/A0/B0/C0/D0/E0/F0/c7ecd302-9bc9-4fc0-a7ea-4fefafa7014d.jpg",
                            "http://album.udn.com/community/img/PSN_PHOTO/fullwin1/f_2139439_1.jpg",
                            "http://www.tayih.com.tw/upload/images/Ticket/Recreation/Leofoo/01.jpg",
                            "http://www.sp.gov.tw/files/980720-0075.JPG",
                            "http://d.blog.xuite.net/d/6/3/b/14008744/blog_206237/txt/8237616/0.jpg",
                            "http://8.blog.xuite.net/8/8/2/3/10776940/blog_1157605/txt/23697932/4.jpg",
                            "http://pic.pimg.tw/terry7f/1378650794-1327138664.jpg",
                            "http://mmmfile.emmm.tw/member/9/article/20100723230816.jpg",
                            "http://pic.pimg.tw/recording/856e6771bd5794f149ec38e2e5a29183.jpg",
                            "http://pic.pimg.tw/qpy5/1189240783.jpg",
                            "http://www.tonyhuang39.com/tony0422/20061027_02.JPG",
                            "http://blog.roodo.com/silksoap/7121b82b.jpg",
                            "http://iphoto.ipeen.com.tw/photo/comment/4/3/4/cm20120711_94631_118578_88ab05127d84dba9cc437f96aaf37c61106.jpg",
                            "http://travel.hsinchu.gov.tw/images/scene/201101/20110123155338.jpg",
                            "http://www.oscar.idv.tw/oscar/101/1010317/c01.jpg",
                            "http://tw.tranews.com/Show/images/News/3219068_1.jpg",
                            "http://pic.pimg.tw/ching0714/4a0314c1e0910.jpg",
                            "http://5.share.photo.xuite.net/masayasu/150ad70/5150938/198211478_x.jpg",
                            "http://living.donghong.info/travel/2006/060318/DSCN3216s.jpg",
                            "http://www.lihpao.com/attachments/2011/02/17_201102102126541b14B.jpg"]
    
    var place:[interest]=[]
    let minY:Float = 13.9399
    let maxY:Float = 57464.8906
    
    func getjson()->Void{
        
        let path:String = NSBundle.mainBundle().pathForResource("interest", ofType: "json")!
        if let jsondata:NSData = NSData(contentsOfFile: path){
            do{
                let json = try NSJSONSerialization.JSONObjectWithData(jsondata, options: NSJSONReadingOptions.AllowFragments)
                for result in json as! NSArray{
                    let x = (result.objectForKey("x") as! NSString).floatValue
                    let y = (result.objectForKey("y") as! NSString).floatValue
                    let spot = result.objectForKey("name") as! String
                    let temp:interest = interest(x: x, y: y, name: spot, pic_source: nil)
                    place.append(temp)
                }
            }catch{
                let alert = NSAlert()
                alert.addButtonWithTitle("OK")
                alert.messageText = "Failed to open json file"
                alert.informativeText = "Check if files needed exist"
            }
            
        }
    }
    
    override func viewDidLoad() {
        if #available(OSX 10.10, *) {
            super.viewDidLoad()
        } else {
            // Fallback on earlier versions
        }
        getjson()
        for i in 0...place.count-1{
            place[i].x = 330+((place[i].x-27020.9707)*1.33/(maxY-minY))*330/0.66
            place[i].y = 275+(place[i].y-28739.41525)*1.33/(maxY-minY)*275/0.66
            place[i].pic_source = poi_url[i]
        }
        
    }
    override func viewDidAppear() {
        let river1rect = NSMakeRect(334.921875, 295.5, 1, 1)
        river1.showRelativeToRect(river1rect, ofView: opengl, preferredEdge: NSRectEdge.MinY)
        let river0rect = NSMakeRect(330.3515625, 401.484375, 1, 1)
        river2.showRelativeToRect(river0rect, ofView: opengl, preferredEdge: NSRectEdge.MaxY)
    }
    
    override func mouseDown(theEvent: NSEvent) {
        var mypoint:NSPoint
        mypoint = theEvent.locationInWindow
        mypoint = opengl.convertPoint(mypoint, fromView: nil)
        mypop.performClose(theEvent)
        let rect = NSMakeRect(mypoint.x, mypoint.y, 1, 1)
        for i in 0...place.count-1{
            if mypoint.y.f>place[i].y-5{
                if mypoint.y.f<place[i].y+5{
                    if mypoint.x.f<place[i].x+5{
                        if mypoint.x.f>place[i].x-5{
                            spotname.stringValue = place[i].name
                            let path = NSURL(string: place[i].pic_source)!
                            spotimage.image = NSImage(contentsOfURL: path)
                            mypop.showRelativeToRect(rect, ofView: opengl, preferredEdge: NSRectEdge.MaxX)
                            break
                        }
                    }
                }
            }
        }
    }
    
}
extension CGFloat{
    var f:Float {return Float(self)}
}

