//
//  openglview.h
//  my first cocoa application
//
//  Created by 王彥欽 on 2015/5/16.
//  Copyright (c) 2015年 Yen-chin Wang. All rights reserved.
//

#ifndef my_first_cocoa_application_openglview_h
#define my_first_cocoa_application_openglview_h
#import <Cocoa/Cocoa.h>
#import <Foundation/Foundation.h>



@interface openglview:NSObject
{
    float** east;
    float** border4;
    float** north;
    float** znorth;
    float** newf;
    float** lakemouth;
    float** newpo;
    float** kwanwest;
    float** sharpstone;
    float** baoshan;
    float** mountain;
    float** emei;
    float** qionglin;
    float** hengshan;
    float** wufeng;
    float** beipu;
    float** zhudong;
    float** interest;
    float** forehead[6];
    float** fengshan[9];
    int len[18];
    int forehead_len[6];
    int fengshan_len[9];
    void* cppobj;
}
-(void)myfunc:(float **)s withlength:(int)i to:(int)mode;
-(void)getriver:(float**)s river:(int)river withpoint:(int)i to:(int)mode;
-(void)drawrect;
@end


#endif
