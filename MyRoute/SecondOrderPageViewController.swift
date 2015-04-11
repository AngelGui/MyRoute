//
//  SecondOrderPageViewController.swift
//  MyRoute
//
//  Created by 陈桂 on 15/4/10.
//  Copyright (c) 2015年 AutoNavi. All rights reserved.
//

import Foundation
import Alamofire

class OrderPageViewController: UIViewController, MAMapViewDelegate{
    
    var mapView: MAMapView?
    var locationButton: UIButton?
    var imageLocated: UIImage?
    var imageNotLocate: UIImage?
    var timer:NSTimer?

    var occupingBt = UIButton()!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.edgesForExtendedLayout = UIRectEdge.None
        
        
        initToolBar()
        initMapView()
        initBoardView()
       
    }
    
     
    override func viewDidAppear(animated: Bool) {
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    //MARK:- Initialization
    //MARK: ---创建地图并显示用户的当前位置---
    func initMapView() {
        
        mapView = MAMapView(frame: self.view.bounds)
        mapView!.delegate = self
        self.view.addSubview(mapView!)
        self.view.sendSubviewToBack(mapView!)
        
        mapView!.showsUserLocation = true
        mapView!.userTrackingMode = MAUserTrackingMode.Follow
        
        mapView!.distanceFilter = 10.0
        mapView!.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        
        mapView?.showsCompass = false
        
    }
    
    //MARK: ---创建首页左下角的定位与否按钮---
    func initToolBar() {
        
        imageLocated = UIImage(named: "location_yes.png")
        imageNotLocate = UIImage(named: "location_no.png")
        
        locationButton = UIButton(frame: CGRectMake(20, CGRectGetHeight(view.bounds) - 80, 40, 40))
        locationButton!.autoresizingMask = UIViewAutoresizing.FlexibleRightMargin | UIViewAutoresizing.FlexibleTopMargin
        locationButton!.backgroundColor = UIColor.whiteColor()
        locationButton!.layer.cornerRadius = 5
        locationButton!.layer.shadowColor = UIColor.blackColor().CGColor
        locationButton!.layer.shadowOffset = CGSizeMake(5, 5)
        locationButton!.layer.shadowRadius = 5
        
        locationButton!.addTarget(self, action: "actionLocation:", forControlEvents: UIControlEvents.TouchUpInside)
        
        locationButton!.setImage(imageNotLocate, forState: UIControlState.Normal)
        
        view.addSubview(locationButton!)
        
    }
    
    
    func initBoardView(){
        
        var bgDialogueView = UIImageView()!
        var bgDialogueImage = UIImage(named: "bgDialogue.png")
        bgDialogueView!.image = bgDialogueImage
        bgDialogueView!.frame = CGRect(x: 10,y: 40,width: 300, height:310)
        self.view.addSubview(bgDialogueView!)
        
        var closeView = UIImageView()!
        var closeImage = UIImage(named: "close.png")
        closeView!.image = closeImage
        closeView!.frame = CGRect(x: 294,y: self.view.frame.height-230,width: 26, height: 26)
        self.view.addSubview(closeView!)
        
        var distanceLabel = UILabel()!
        distanceLabel!.frame = CGRect(x: 294,y: self.view.frame.height-230,width: 26, height: 26)
        distanceLabel.text = "距您\(distance)公里"
        self.view.addSubview(distanceLabel)
        
        var tipView = UIImageView()!
        tipView!.frame = CGRect(x: 294,y: self.view.frame.height-230,width: 26, height: 26)
        var tipImage = UIImage(named: "tip\(tip).png")
        tipView!.image = tipImage
        self.view.addSubview(tipView!)
        
        var occupingImage = UIImage(named: "occuping.png")
        occupingBt.setImage(occupingImage, forState: UIControlState.Normal)
        occupingBt.frame = CGRect(x: 110, y: self.view.frame.height-190, width: 100, height: 100)
        occupingBt.addTarget(self, action: "changeNextVC", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(occupingBt)

        
        
    }
    
    func changeNextVC(){
        
        //self.dismissViewControllerAnimated(true, completion: nil)
        var lord: LordInfomation! = LordInfomation.shareInstance()
        
        Alamofire.request(.POST, "用户发送订单接口",
            parameters: ["lordToken":lord.m_phoneNumber])
            .responseString { (request, response, string, error) in
                
                println("\n\n======注册数据===========")
                
                println("--- request: --- \n \(request)")
                println("--- response: --- \n \(response)")
                println("--- data: --- \n \(data)")
                println("--- error:  --- \n \(error)")
                
                /*
                //下行参数：
                发送成功: {"result": [ {"hbCode":10, "state":1} ]}
                发送失败: {"result": [ {"hbCode":0,  "state":1} ]}
                */
                var resultDicData = data as NSDictionary
                var resultLoginArray = resultDicData.objectForKey("result") as NSArray
                println("resultLoginArray : \(resultLoginArray)")
                
                var resultDic = resultLoginArray.objectAtIndex(0) as NSDictionary
                println("resultDic : \(resultDic)")
                
                if 10 == resultDic.objectForKey("hbCode") as UInt {
                    println("抢单成功")
                
                m_WaitingForUserVC = WaitingForUserViewController()
                m_WaitingForUserVC!.title = "等待应答"
                // self.presentViewController(m_CountDownVC, animated: true, completion: nil)
                self.navigationController?.pushViewController(m_WaitingForUserVC, animated: true)
                }
                else
                {
                    
                    var occupiedImage = UIImage(named: "occupied.png")
                    occupingBt.setImage(occupiedImage, forState: UIControlState.Normal)
                    occupingBt.frame = CGRect(x: 110, y: self.view.frame.height-190, width: 100, height: 100)
                    self.view.addSubview(occupingBt)
                
                }
        }
        
    }
    
    
    
    func actionLocation(sender: UIButton) {
        println("actionLocation")
        
        if mapView!.userTrackingMode == MAUserTrackingMode.Follow {
            
            mapView!.setUserTrackingMode(MAUserTrackingMode.None, animated: false)
            mapView!.showsUserLocation = false
        }
        else {
            mapView!.setUserTrackingMode(MAUserTrackingMode.Follow, animated: true)
        }
    }
    
    //MARK:- MAMapViewDelegate
    
    func mapView(mapView: MAMapView , didUpdateUserLocation userLocation: MAUserLocation ) {
        
        let location: CLLocation = userLocation.location
        /*
        let infoArray: [(String, String)] = [("coordinate", NSString(format: "<%.4f, %.4f>", location.coordinate.latitude, location.coordinate.longitude)),
        ("speed", NSString(format: "%.2fm/s(%.2fkm/h)", location.speed, location.speed * 3.6)),
        ("accuracy", "\(location.horizontalAccuracy)m"),
        ("altitude", NSString(format: "%.2fm", location.altitude))]
        */
        
    }
    
    /*
    //MARK: ---显示用户自定义的标记图标---
    func mapView(mapView: MAMapView!, viewForAnnotation annotation: MAAnnotation!) -> MAAnnotationView! {
    
    var m_image = UIImage(named:"user2.png")
    var annotationView = MAAnnotationView()
    annotationView.image = m_image
    return annotationView
    
    }
    */
    
    func mapView(mapView: MAMapView, didChangeUserTrackingMode mode: MAUserTrackingMode, animated: Bool) {
        if mode == MAUserTrackingMode.None {
            locationButton?.setImage(imageNotLocate, forState: UIControlState.Normal)
        }
        else {
            locationButton?.setImage(imageLocated, forState: UIControlState.Normal)
        }
    }
    
}