//
//  ourdrawing.cpp
//  my first cocoa application
//
//  Created by 王彥欽 on 2015/6/10.
//  Copyright (c) 2015年 Yen-chin Wang. All rights reserved.
//
#include <iostream>
#include <string>
#include "opencv2/opencv.hpp"
using namespace std;

template <class T>
class my_vector {
    T* data;
    int container_size;
    int data_size;
    
public:
    my_vector<T>();
   /*     data = nullptr;
        container_size=data_size=0;
    }
    T operator [](int i){
        return data[i];
    }*/
    void push_back(T& value)const;
    void pop();
    int size(){return data_size;}
    int capacity(){return container_size;}
    ~my_vector(){
        delete [] data;
    }
};
template <class T>
my_vector<T>::my_vector() {
    data = nullptr;
    data_size=container_size=0;
}

template <class T>
void my_vector<T>::push_back(T& value)const {
    if (data_size==container_size==0) {
        data = new T[2];
        data[0]=value;
        data_size++;
        container_size=2;
    }else if (data_size==container_size-1){
        T* temp=new T[container_size];
        for (int i=0; i<data_size; i++) {
            temp[i]=data[i];
        }
        delete [] data;
        data = new T[data_size*2];
        for (int i=0; i<data_size; i++)
            data[i]=temp[i];
        data[data_size]=value;
        container_size=data_size*2;
        data_size++;
        delete [] temp;
    }else{
        data[data_size+1]=value;
        data_size++;
    }
}
template <class T>
void my_vector<T>::pop(){
    data_size--;
    if (data_size<container_size/2) {
        T* temp=new T[container_size/2];
        for (int i=0; i<data_size; i++) {
            temp[i]=data[i];
        }
        delete [] data;
        data = new T[container_size/2];
        for (int i=0; i<data_size; i++)
            data[i]=temp[i];
        container_size/=2;
        delete [] temp;
    }
}

int main(){
    my_vector<int> t1;
    
}