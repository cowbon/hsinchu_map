//
//  ourdrawing.h
//  my first cocoa application
//
//  Created by 王彥欽 on 2015/6/10.
//  Copyright (c) 2015年 Yen-chin Wang. All rights reserved.
//

#ifndef __my_first_cocoa_application__ourdrawing__
#define __my_first_cocoa_application__ourdrawing__

#include <iostream>
#include <vector>
#include <string.h>
#include <cstdlib>
#include <OpenGL/OpenGL.h>
#include <GLUT/GLUT.h>
using namespace std;

void CALLBACK vertexCallback(GLvoid *vertex);
void CALLBACK beginCallback(GLenum which);
void CALLBACK endCallback ();
void CALLBACK errorCallback(GLenum errorCode);
void CALLBACK combineCallback(GLdouble coords[3],
                              GLdouble *vertex_data[4],
                              GLfloat weight[4], GLdouble **dataOut);

struct point2f {
    float x, y;
};

class AllMaps {
public:
    friend class ourdraw;
    void addArea(const std::vector<point2f>& area) {data.push_back(area);}
    void addPoint(const std::vector<point2f>& area) {points=area;}
    std::vector<point2f> getAreaData(int index) {return data[index];}
    int size() {return static_cast<int>(data.size());}
    void normalize();
private:
    std::vector<std::vector<point2f>> data;
    std::vector<point2f> points;
};

class ourdraw {
    AllMaps all_maps;
    float** east[8];
    float** point;
    vector<int> len;
    int points_num;
public:
    ourdraw();
    void draw();
    void send(float**s,int l,int mode);
    void get_point(float**s,int l);
};
ourdraw::ourdraw(){}
void ourdraw::send(float** s,int l, int mode){
    east[mode-1]=s;
    len.push_back(l);
}
void ourdraw::get_point(float**s, int l){
    point=s;
    points_num=l;
}
void ourdraw::draw(){
    for(int i = 0; i < 8; ++i) {
        vector<point2f> temp;
        point2f t1;
        for (int j=0; j<len[i]; j++) {
            t1.x=east[i][0][j];
            t1.y=east[i][1][j];
            temp.push_back(t1);
        }
        all_maps.addArea(temp);
    }
    vector<point2f> c;
    for (int i=0; i<points_num; i++) {
        point2f t2;
        t2.x=point[0][i];
        t2.y=point[1][i];
        c.push_back(t2);
    }
    all_maps.addPoint(c);
    all_maps.normalize();
    
    glClearColor(0.34,0.6,1, 1);
    glClear(GL_COLOR_BUFFER_BIT);
    glEnable(GL_LINE_SMOOTH);
    glHint(GL_LINE_SMOOTH_HINT, GL_NICEST);

    
    glLoadIdentity();
    glScalef(1.0f,1.0f,1);
    glTranslatef(0, 0, 0);
    
    //draw each area
    for(int i = 0; i < all_maps.size(); ++i) {
        GLUtesselator* tobj = gluNewTess();
        if (!tobj) return;
        
        gluTessCallback(tobj, GLU_TESS_VERTEX, (void (CALLBACK *)())vertexCallback);
        gluTessCallback(tobj, GLU_TESS_BEGIN, (void (CALLBACK *)())beginCallback);
        gluTessCallback(tobj, GLU_TESS_END, (void (CALLBACK *)())endCallback);
        gluTessCallback(tobj, GLU_TESS_ERROR, (void (CALLBACK *)())errorCallback);
        gluTessCallback(tobj, GLU_TESS_COMBINE, (void (CALLBACK *)())combineCallback);
        
        vector<point2f> temp = all_maps.getAreaData(i);
        double **data;
        data = new double*[temp.size()];
        for(int i = 0; i < temp.size(); ++i) {
            data[i] = new double[6];
            data[i][0] = temp[i].x;
            data[i][1] = temp[i].y;
            data[i][2] = 0;
            data[i][3] = 0.37; //red
            data[i][4] = 0.83; //green
            data[i][5] = 0.553; //blue
        }
        
        gluTessBeginPolygon(tobj,NULL);
        gluTessBeginContour(tobj);
        for(int i = 0; i < temp.size(); ++i)
            gluTessVertex(tobj,data[i], data[i]);
        gluTessEndContour(tobj);
        gluTessEndPolygon(tobj);
        gluDeleteTess(tobj);
        
        for(int i = 0; i < temp.size(); ++i)
            delete[] data[i];
        delete[] data;
    }
    
    glPushAttrib(GL_CURRENT_BIT);
    glEnable(GL_LINE_STIPPLE);
    glLineStipple(1, 0x0F0F);
    for(int i = 0; i < all_maps.data.size(); ++i) {
        if(i == 2) {
            glDisable(GL_LINE_STIPPLE);
            glColor3f(1,0,1);
        } else {
            glEnable(GL_LINE_STIPPLE);
            glColor3f(1,0,0);
        }
        
        glLineWidth(1);
        glBegin(GL_LINE_STRIP);
        for(int j = 0; j < all_maps.data.size(); ++j)
            glVertex2f(all_maps.data[i][j].x, all_maps.data[i][j].y);
        glVertex2f(all_maps.data[i][0].x, all_maps.data[i][0].y);
        glEnd();
    }
    glDisable(GL_LINE_STIPPLE);
    glPopAttrib();
    
    
    glPushAttrib(GL_CURRENT_BIT);
    glPointSize(5);
    glColor3f(0,0,1);
    glBegin(GL_POINTS);
    for(int i = 0; i < points_num; ++i)
        glVertex2f(all_maps.points[i].x, all_maps.points[i].y);
    glEnd();
    glPopAttrib();
    /*cout<<all_maps.data[0][0].x<<" "<<all_maps.data[0][0].y<<endl;
    cout<<all_maps.data[0][1].x<<" "<<all_maps.data[0][1].y<<endl;
    cout<<all_maps.data[0][2].x<<" "<<all_maps.data[0][2].y<<endl;
    glColor3f(1,0,0);
    glLineWidth(3);
    glBegin(GL_LINE_STRIP);
    {
        glVertex2f(all_maps.data[0][0].x, all_maps.data[0][0].y);
        glVertex2f(all_maps.data[0][1].x, all_maps.data[0][1].y);
        glVertex2f(all_maps.data[0][2].x, all_maps.data[0][2].y);
        //glVertex2f(all_maps.data[0][0].x, all_maps.data[0][0].y);
    }
    glEnd();*/
    glutSwapBuffers();
}

void AllMaps::normalize()
{
    //shift
        
    float minX = data[0][0].x;
    float maxX = data[0][0].x;
    float minY = data[0][0].y;
    float maxY = data[0][0].y;
    for(int i = 0; i < data.size(); ++i) {
        for(int j = 0; j < data[i].size(); ++j) {
            if(data[i][j].x < minX)
                minX = data[i][j].x;
            if(data[i][j].x > maxX)
                maxX = data[i][j].x;
            if(data[i][j].y < minY)
                minY = data[i][j].y;
            if(data[i][j].y > maxY)
                minY = data[i][j].y;
        }
    }
    for(int i = 0; i < points.size(); ++i) {
        if(points[i].x < minX)
            minX = points[i].x;
        if(points[i].x > maxX)
            maxX = points[i].x;
        if(points[i].y < minY)
            minY = points[i].y;
        if(points[i].y > maxY)
            maxY = points[i].y;
    }
    
    float min, max;
    if(maxX-minX >= maxY-minY) {
        min = minX;
        max = maxX;
    } else {
        min = minY;
        max = maxY;
    }
    for(int i = 0; i < data.size(); ++i) {
        for(int j = 0; j < data[i].size(); ++j) {
            data[i][j].x -= (minX + maxX)/2.0f;
            data[i][j].y -= (minY + maxY)/2.0f;
        }
    }
    for(int i = 0; i < points.size(); ++i) {
        points[i].x -= (minX + maxX)/2.0f;
        points[i].y -= (minY + maxY)/2.0f;
    }
    //scale
    for(int i = 0; i < data.size(); ++i) {
        for(int j = 0; j < data[i].size(); ++j) {
            data[i][j].x *= 1.5/(max-min);
            data[i][j].y *= 1.5/(max-min);
        }
    }
    /*for(int i = 0; i < lineData.size(); ++i) {
        for(int j = 0; j < lineData[i].size(); ++j) {
            lineData[i][j].x *= 1.5/(max-min);
            lineData[i][j].y *= 1.5/(max-min);
        }
    }*/
    for(int i = 0; i < points.size(); ++i) {
        points[i].x *= 1.5/(max-min);
        points[i].y *= 1.5/(max-min);
    }
}

void CALLBACK vertexCallback(GLvoid *vertex)
{
    const GLdouble *pointer;
    pointer = (GLdouble *) vertex;
    glColor3f(pointer[3], pointer[4], pointer[5]);
    glVertex3dv(pointer);
}

void CALLBACK beginCallback(GLenum which){
    glBegin(which);
}

void CALLBACK endCallback  (){
    glEnd();
}

void CALLBACK errorCallback(GLenum errorCode){
    const GLubyte *estring;
    estring = gluErrorString(errorCode);
    fprintf(stderr, "Tessellation Error: %sn", estring);
    exit(0);
}

void CALLBACK combineCallback(GLdouble coords[3],
                              GLdouble *vertex_data[4],
                              GLfloat weight[4], GLdouble **dataOut )
{
    GLdouble *vertex;
    int i;
    vertex = (GLdouble *) malloc(6 * sizeof(GLdouble));
    vertex[0] = coords[0];
    vertex[1] = coords[1];
    vertex[2] = coords[2];
    for (i = 3; i < 6; i++) {
        vertex[i] = 0;
    }
    *dataOut = vertex;
}

#endif /* defined(__my_first_cocoa_application__ourdrawing__) */
