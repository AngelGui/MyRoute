//
//  UserInformation.swift
//  MyRoute
//
//  Created by 陈桂 on 15/4/9.
//  Copyright (c) 2015年 AutoNavi. All rights reserved.
//

import Foundation

//-------------------------------------------------
//单例类: 拉屎用户信息类
//-------------------------------------------------

class UserInformation: NSObject {
    
    // MARK: - Member Data
    //-------------------------------------------------
    
    var m_id: String!                //用户序号
    var m_tip: String!               //用户小费
    var m_lat: String!               //用户纬度
    var m_lon: String!               //用户经度
//    var m_ifResponsed: NSMutableArray!         //是否被抢单标志位

    
    // MARK: - 创建并返回单例的方法
    //-------------------------------------------------
    //类方法: 静态方法
    // 创建并返回单例的方法
    //-------------------------------------------------
    class func shareInstance() -> UserInformation {
        
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: UserInformation? = nil
        }
        
        //确保值调用一次，从而只创建一个对象——单例
        dispatch_once(&Static.onceToken) {
            
            Static.instance = UserInformation() //创建单例对象
        }
        
        return Static.instance!
    }
    
}