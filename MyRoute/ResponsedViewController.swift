//
//  ResponsedViewController.swift
//  MyRoute
//
//  Created by 陈桂 on 15/4/1.
//  Copyright (c) 2015年 AutoNavi. All rights reserved.
//

import Foundation


class ResponsedViewController: UIViewController{
    
    
    var toiletView:UIImageView!
    var shareBt = UIButton()
    var telephoneBt = UIButton()
    var finishBt = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        

        initResponsedView()
 
        
    }
    
    
    func initResponsedView(){
        
        toiletView = UIImageView()
        var toiletImage = UIImage(named: "toilet.png")
        toiletView!.image = toiletImage
        toiletView!.frame = CGRect(x: 8, y: self.view.frame.height-148, width: 120, height: 140)
        self.view.addSubview(toiletView!)
        
        
        var shareImage = UIImage(named: "share.png")
        shareBt.frame = CGRect(x: 30, y: 450, width: 50, height: 50)
        shareBt.setImage(shareImage, forState: UIControlState.Normal)
        shareBt.addTarget(self, action: "share", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(shareBt)
        
        var telephoneImage = UIImage(named: "telephone.png")
        telephoneBt.frame = CGRect(x: 30, y: 450, width: 50, height: 50)
        telephoneBt.setImage(shareImage, forState: UIControlState.Normal)
        telephoneBt.addTarget(self, action: "share", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(telephoneBt)
        
        var finishImage = UIImage(named: "")
        finishBt.frame = CGRect(x: 30, y: 450, width: 50, height: 50)
        finishBt.setImage(shareImage, forState: UIControlState.Normal)
        finishBt.addTarget(self, action: "share", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(finishBt)
    }
    
    
 
}