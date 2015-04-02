//
//  LordInfomation.swift
//  MyRoute
//
//  Created by 陈桂 on 15/4/2.
//  Copyright (c) 2015年 陈桂. All rights reserved.
//

import Foundation

//-------------------------------------------------
//单例类: 注册的厕主信息类
//-------------------------------------------------

class LordInfomation: NSObject {
    
    // MARK: - Member Data
    //-------------------------------------------------
    
    var m_id: String!                //厕主序号
    var m_phoneNumber: String!       //手机号
    var m_toiletPhotoUrl: String!    //厕主厕所图像
    var m_address: String!           //厕所地址
    var m_provision: NSMutableArray!         //厕所配置
    var m_toiletType: String!        //厕所类型
    
    // MARK: - 创建并返回单例的方法
    //-------------------------------------------------
    //类方法: 静态方法
    // 创建并返回单例的方法
    //-------------------------------------------------
    class func shareInstance() -> LordInfomation {
        
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: LordInfomation? = nil
        }
        
        //确保值调用一次，从而只创建一个对象——单例
        dispatch_once(&Static.onceToken) {
            
            Static.instance = LordInfomation() //创建单例对象
        }
        
        return Static.instance!
    }
    
}