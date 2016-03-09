//
//  myopenglview.swift
//  my first cocoa application
//
//  Created by 王彥欽 on 2015/5/15.
//  Copyright (c) 2015年 Yen-chin Wang. All rights reserved.
//

import Cocoa
import GLKit
import AppKit
import OpenGL
import GLUT
import Foundation

class myopenglview: NSOpenGLView {

    var aview:openglview=openglview()
    
    override func awakeFromNib() {
        let attributes:[NSOpenGLPixelFormatAttribute] = [
            UInt32(NSOpenGLPFAAccelerated),
            UInt32(NSOpenGLPFADoubleBuffer),
            UInt32(NSOpenGLPFAStencilSize),UInt32(32),
            UInt32(NSOpenGLPFAColorSize),UInt32(32),
            UInt32(NSOpenGLPFADepthSize),UInt32(32)
        ]
        _ = NSOpenGLPixelFormat(attributes: attributes)
        self.openGLContext!.makeCurrentContext()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }
    override func prepareOpenGL() {
        glClearColor(0.34,0.6,1, 1);        //original  glClearColor(0.34,0.6,1, 1);
        glEnable(GLenum(GL_LINE_SMOOTH));
        glHint(GLenum(GL_LINE_SMOOTH_HINT), GLenum(GL_NICEST));
    }
    
    /*override func mouseDown(theEvent: NSEvent){
        var mypoint:NSPoint
        mypoint = theEvent.locationInWindow
        mypoint = self.convertPoint(mypoint, fromView: nil)
        println("(\(mypoint.x),\(mypoint.y))")
        super.mouseDown(theEvent)
    }*/ //we finish it in viewcontroller
    
    func getjson(a:String,b:UnsafeMutablePointer<UnsafeMutablePointer<CFloat>>) -> (UnsafeMutablePointer<UnsafeMutablePointer<CFloat>>,Int){
        
        let path:String = NSBundle.mainBundle().pathForResource(a, ofType: "json")!
        var i = 0
        if let jsondata:NSData = NSData(contentsOfFile: path){
        //let json:AnyObject = NSJSONSerialization.JSONObjectWithData(jsondata, options: NSJSONReadingOptions.AllowFragments, error: nil)!
            do{
                let json = try NSJSONSerialization.JSONObjectWithData(jsondata, options: NSJSONReadingOptions.AllowFragments)
                var temp:[CFloat]=[]
                var temp1:[CFloat]=[]
                
                for result in json as! NSArray{
                    let x = (result.objectForKey("x") as! NSString).floatValue
                    let y = (result.objectForKey("y") as! NSString).floatValue
                    temp.append(x)
                    temp1.append(y)
                }
                b[0] = UnsafeMutablePointer<CFloat>.alloc(temp.count)
                b[1] = UnsafeMutablePointer<CFloat>.alloc(temp.count)
                for i in 0...temp.count-1{
                    b[0][i] = temp[i]
                    b[1][i] = temp1[i]
                }
                i=temp.count

            }catch{
                let alert = NSAlert()
                alert.messageText = "Failed to open json file"
                alert.informativeText = "Check if the files needed exist"
                alert.addButtonWithTitle("OK")
            }
            
        }else{
            self.print("error1")
        }
        return (b,i)
    }

    
    override func drawRect(dirtyRect: NSRect) {
        
        var interest:UnsafeMutablePointer<UnsafeMutablePointer<CFloat>> = UnsafeMutablePointer<UnsafeMutablePointer<CFloat>>.alloc(2)
        
        var forehead = [UnsafeMutablePointer<UnsafeMutablePointer<CFloat>>.alloc(2),
                        UnsafeMutablePointer<UnsafeMutablePointer<CFloat>>.alloc(2),
                        UnsafeMutablePointer<UnsafeMutablePointer<CFloat>>.alloc(2),
                        UnsafeMutablePointer<UnsafeMutablePointer<CFloat>>.alloc(2),
                        UnsafeMutablePointer<UnsafeMutablePointer<CFloat>>.alloc(2),
                        UnsafeMutablePointer<UnsafeMutablePointer<CFloat>>.alloc(2)]
        
        var borders:[UnsafeMutablePointer<UnsafeMutablePointer<CFloat>>]=[
            UnsafeMutablePointer<UnsafeMutablePointer<CFloat>>.alloc(2),
            UnsafeMutablePointer<UnsafeMutablePointer<CFloat>>.alloc(2),
            UnsafeMutablePointer<UnsafeMutablePointer<CFloat>>.alloc(2),
            UnsafeMutablePointer<UnsafeMutablePointer<CFloat>>.alloc(2),
            UnsafeMutablePointer<UnsafeMutablePointer<CFloat>>.alloc(2),
            UnsafeMutablePointer<UnsafeMutablePointer<CFloat>>.alloc(2),
            UnsafeMutablePointer<UnsafeMutablePointer<CFloat>>.alloc(2),
            UnsafeMutablePointer<UnsafeMutablePointer<CFloat>>.alloc(2),
            UnsafeMutablePointer<UnsafeMutablePointer<CFloat>>.alloc(2),
            UnsafeMutablePointer<UnsafeMutablePointer<CFloat>>.alloc(2),
            UnsafeMutablePointer<UnsafeMutablePointer<CFloat>>.alloc(2),
            UnsafeMutablePointer<UnsafeMutablePointer<CFloat>>.alloc(2),
            UnsafeMutablePointer<UnsafeMutablePointer<CFloat>>.alloc(2),
            UnsafeMutablePointer<UnsafeMutablePointer<CFloat>>.alloc(2),
            UnsafeMutablePointer<UnsafeMutablePointer<CFloat>>.alloc(2),
            UnsafeMutablePointer<UnsafeMutablePointer<CFloat>>.alloc(2),
            UnsafeMutablePointer<UnsafeMutablePointer<CFloat>>.alloc(2)]
        
        var fengshan = [UnsafeMutablePointer<UnsafeMutablePointer<CFloat>>.alloc(2),
                        UnsafeMutablePointer<UnsafeMutablePointer<CFloat>>.alloc(2),
                        UnsafeMutablePointer<UnsafeMutablePointer<CFloat>>.alloc(2),
                        UnsafeMutablePointer<UnsafeMutablePointer<CFloat>>.alloc(2),
                        UnsafeMutablePointer<UnsafeMutablePointer<CFloat>>.alloc(2),
                        UnsafeMutablePointer<UnsafeMutablePointer<CFloat>>.alloc(2),
                        UnsafeMutablePointer<UnsafeMutablePointer<CFloat>>.alloc(2),
                        UnsafeMutablePointer<UnsafeMutablePointer<CFloat>>.alloc(2),
                        UnsafeMutablePointer<UnsafeMutablePointer<CFloat>>.alloc(2)]

        var mytuple:(UnsafeMutablePointer<UnsafeMutablePointer<CFloat>>,Int)=(nil,0)
        var len = 0

        for i in 0...16{
            switch(i){
            case 0:
                mytuple = getjson("east",b:borders[0])
            case 1:
                mytuple = getjson("4border",b:borders[1])
            case 2:
                mytuple = getjson("north",b:borders[2])
            case 3:
                mytuple = getjson("znorth",b:borders[3])
            case 4:
                mytuple = getjson("newf",b:borders[4])
            case 5:
                mytuple = getjson("lakemouth",b:borders[5])
            case 6:
                mytuple = getjson("newpo",b:borders[6])
            case 7:
                mytuple = getjson("kwanwest",b:borders[7])
            case 8:
                mytuple = getjson("sharpstone",b:borders[8])
            case 9:
                mytuple = getjson("baoshan",b:borders[9])
            case 10:
                mytuple = getjson("mountain",b:borders[10])
            case 11:
                mytuple = getjson("emei",b:borders[11])
            case 12:
                mytuple = getjson("qionglin",b:borders[12])
            case 13:
                mytuple = getjson("hengshan",b:borders[13])
            case 14:
                mytuple = getjson("wufeng",b:borders[14])
            case 15:
                mytuple = getjson("zhudong",b:borders[15])
            case 16:
                mytuple = getjson("beipu",b:borders[16])
            default:
                self.print("error")
            }
            borders[i]=mytuple.0
            len=mytuple.1
            aview.myfunc(borders[i], withlength: Int32(len), to: Int32(i+1))
        }
        
        
        for i in 0...5{
            switch(i){
            case 0:
                mytuple = getjson("forehead",b:forehead[0])
            case 1:
                mytuple = getjson("forehead_1",b:forehead[1])
            case 2:
                mytuple = getjson("forehead_2",b:forehead[2])
            case 3:
                mytuple = getjson("forehead_3",b:forehead[3])
            case 4:
                mytuple = getjson("forehead_4",b:forehead[4])
            case 5:
                mytuple = getjson("forehead_5",b:forehead[5])
            default:
                self.print("error")
            }
            forehead[i]=mytuple.0
            len=mytuple.1
            aview.getriver(forehead[i], river: Int32(1), withpoint: Int32(len), to: Int32(i))
        }
        
        for i in 0...fengshan.count-1{
            switch(i){
            case 0:
                mytuple = getjson("fengshanmain",b:fengshan[0])
            case 1:
                mytuple = getjson("fengshan1",b:fengshan[1])
            case 2:
                mytuple = getjson("fengshan2",b:fengshan[2])
            case 3:
                mytuple = getjson("fengshan3",b:fengshan[3])
            case 4:
                mytuple = getjson("fengshan4",b:fengshan[4])
            case 5:
                mytuple = getjson("fengshan5",b:fengshan[5])
            case 6:
                mytuple = getjson("fengshan6",b:fengshan[6])
            case 7:
                mytuple = getjson("fengshan2-1",b:fengshan[7])
            case 8:
                mytuple = getjson("fengshan2-2",b:fengshan[8])
            
            default:
                self.print("error")
            }
            fengshan[i]=mytuple.0
            len=mytuple.1
            aview.getriver(fengshan[i], river: Int32(0), withpoint: Int32(len), to: Int32(i))
        }
        
        mytuple = getjson("interest",b:interest)
        interest=mytuple.0
        len=mytuple.1
        aview.myfunc(interest, withlength: Int32(len), to: Int32(0))
        
        self.openGLContext!.makeCurrentContext()
        aview.drawrect()
        //glFlush();
        self.openGLContext!.flushBuffer()
       /* var path=NSBezierPath()
        path.moveToPoint(NSPoint(x: 100, y: 100))
        path.lineToPoint(NSZeroPoint)
        NSColor.redColor().setStroke()
        path.stroke()*/
    }
}