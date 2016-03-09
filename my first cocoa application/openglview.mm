//
//  openglview.m
//  my first cocoa application
//
//  Created by 王彥欽 on 2015/5/16.
//  Copyright (c) 2015年 Yen-chin Wang. All rights reserved.
//

#include "openglview.h"
#include "allmaps.h"
#include <vector>


@implementation openglview

-(void)drawrect{
    cppobj = new AllMaps;
    AllMaps& c = *static_cast<AllMaps*>(cppobj);
    c.importArea(east,len[1], 1);
    c.importArea(border4,len[2], 2);
    c.importArea(north,len[3], 3);
    c.importArea(znorth,len[4], 4);
    c.importArea(newf,len[5], 5);
    c.importArea(lakemouth, len[6], 6);
    c.importArea(newpo, len[7], 7);
    c.importArea(kwanwest, len[8], 8);
    c.importArea(sharpstone, len[9], 9);
    c.importArea(baoshan, len[10], 10);
    c.importArea(mountain, len[11], 11);
    c.importArea(emei, len[12], 12);
    c.importArea(qionglin, len[13], 13);
    c.importArea(hengshan, len[14], 14);
    c.importArea(wufeng, len[15], 15);
    c.importArea(zhudong, len[16], 16);
    c.importArea(beipu, len[17], 17);

    for(int i=0;i<6;i++)
        c.importLines(forehead[i], forehead_len[i]);
    for (int i=0; i<9; i++) {
        c.importLines(fengshan[i], fengshan_len[i]);
    }
    c.importPoint(interest, len[0]);
    c.render();
}
-(void)myfunc:(float **)s withlength:(int)i to:(int)mode{
    if(mode==0)interest=s;
    else if(mode==1)east=s;
    else if (mode==2) border4=s;
    else if (mode==3) north=s;
    else if (mode==4) znorth=s;
    else if (mode==5) newf=s;
    else if (mode==6) lakemouth=s;
    else if (mode==7) newpo=s;
    else if (mode==8) kwanwest=s;
    else if (mode==9) sharpstone=s;
    else if (mode==10) baoshan=s;
    else if (mode==11) mountain=s;
    else if (mode==12) emei=s;
    else if (mode==13) qionglin=s;
    else if (mode==14) hengshan=s;
    else if (mode==15) wufeng=s;
    else if (mode==16) zhudong=s;
    else if (mode==17) beipu=s;

    len[mode]=i;
}
-(void)getriver:(float **)s river:(int)river withpoint:(int)i to:(int)mode{
    if (river==1) {
        forehead[mode]=s;
        forehead_len[mode]=i;
    } else {
        fengshan[mode]=s;
        fengshan_len[mode]=i;
    }
}




@end



