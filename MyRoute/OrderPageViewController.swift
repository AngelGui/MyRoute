//
//  OrderPageViewController.swift
//  MyRoute
//
//  Created by 陈桂 on 15/3/31.
//  Copyright (c) 2015年 AutoNavi. All rights reserved.
//

import Foundation
import Alamofire

class OrderPageViewController: UIViewController, MAMapViewDelegate{
    
    var mapView: MAMapView?
    var locationButton: UIButton?
    var imageLocated: UIImage?
    var imageNotLocate: UIImage?
    var CancelBt = UIButton()
    var lordBt = UIButton()
    var timer:NSTimer?
    var progressView: ProgressView!
    var label:UILabel!
    var progress: CGFloat = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.edgesForExtendedLayout = UIRectEdge.None
        
      
        initToolBar()
        initMapView()
        //initBoardView()
        createProgressView()
        
        
        //MARK: ---- 告诉后台我在供厕中，接收推送消息 ----
        Alamofire.request(.POST, "厕主供厕中接口",
            parameters: ["UserID":UDID,
                "UserTip":userTip,
                "UserLat":userLat,
                "UserLon":userLon ])
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
                    println("已经发送了推送标志位")
                 
                 //弹出一个订单弹窗
                 //弹出一个抢单按钮
                    
                }

        }
        

        
    }
    
       func createProgressView(){
        
        progressView = ProgressView(frame: CGRectMake(100.0, self.view.frame.height-200, 120.0, 120.0))
        self.view.addSubview(progressView)
        
        label = UILabel(frame: CGRectMake(110.0, 200.0, 100.0, 25.0))
        label.textColor = UIColor.blackColor()
        label.textAlignment = NSTextAlignment.Center
        label.font = UIFont.systemFontOfSize(18.0)
        label.hidden = true
        self.view.addSubview(label)
        
        var provisionImage = UIImage(named: "provision.png")
        CancelBt.setImage(provisionImage, forState: UIControlState.Normal)
        CancelBt.frame = CGRect(x: 110, y: self.view.frame.height-190, width: 100, height: 100)
        CancelBt.addTarget(self, action: "changeToMainVC", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(CancelBt)
        
        
        timer?.invalidate()
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "updateTime:", userInfo: nil, repeats: true)
        
    }
    func updateTime(timer: NSTimer){
        if progress > 0.999{
            progress = 0.0
            
        }else{
            
            progress += 0.1
        }
        label.text = "\(progress)"
        progressView.setProgress(progress)
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
    
        var provisionImage = UIImage(named: "provision.png")
        CancelBt.setImage(provisionImage, forState: UIControlState.Normal)
        CancelBt.frame = CGRect(x: 110, y: self.view.frame.height-200, width: 100, height: 110)
        CancelBt.addTarget(self, action: "changeToMainVC", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(CancelBt)

        
    }
    
    func changeToMainVC(){
        
        //self.dismissViewControllerAnimated(true, completion: nil)
        var m_MainVC: MainViewController!
        
        m_MainVC = MainViewController()
        m_MainVC.navigationItem.title = "duangduang拉屎"
        m_MainVC.navigationItem.hidesBackButton = true
        self.navigationController?.pushViewController(m_MainVC, animated: true)
       // m_MainVC.changeToLord()
     
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