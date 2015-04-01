//
//  WaitingForUserViewController.swift
//  MyRoute
//
//  Created by 陈桂 on 15/4/1.
//  Copyright (c) 2015年 AutoNavi. All rights reserved.
//

import Foundation

class WaitingForUserViewController: UIViewController{
    
    
    var backgroundView:UIImageView!
    var orderTime = UILabel()
    var userNo = UILabel()
    var tipLabel = UILabel()
    var distance = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        initResponsedView()
        
        
    }
    
    
    func initResponsedView(){
        
        backgroundView = UIImageView()
        var backgroundImage = UIImage(named: "successed.png")
        backgroundView!.image = backgroundImage
        backgroundView!.frame = CGRect(x: 150, y:200, width: 120, height: 140)
        self.view.addSubview(backgroundView!)
        
        
        orderTime.text = "订单时间"
        orderTime.frame = CGRect(x: 15, y: 260, width: 100, height: 20)
        orderTime.backgroundColor = UIColor.whiteColor()
        orderTime.font = UIFont.systemFontOfSize(15)
        self.view.addSubview(orderTime)
        
        userNo.text = "用户编号"
        userNo.frame = CGRect(x: 15, y: 290, width: 100, height: 20)
        userNo.backgroundColor = UIColor.whiteColor()
        userNo.font = UIFont.systemFontOfSize(15)
        self.view.addSubview(userNo)
        
        tipLabel.text = "愿给小费"
        tipLabel.frame = CGRect(x: 15, y: 320, width: 100, height: 20)
        tipLabel.backgroundColor = UIColor.whiteColor()
        tipLabel.font = UIFont.systemFontOfSize(15)
        self.view.addSubview(tipLabel)
        
        distance.text = "抢单距离"
        distance.frame = CGRect(x: 15, y:350, width: 100, height: 20)
        distance.backgroundColor = UIColor.whiteColor()
        distance.font = UIFont.systemFontOfSize(15)
        self.view.addSubview(distance)
        
    }
    
    
    
}