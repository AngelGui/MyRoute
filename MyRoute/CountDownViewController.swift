//
//  CountDownViewController.swift
//  MyRoute
//
//  Created by 陈桂 on 15/3/26.
//  Copyright (c) 2015年 AutoNavi. All rights reserved.
//

import Foundation
import Alamofire

class CountDownViewController: UIViewController, MAMapViewDelegate, UIAlertViewDelegate{
    
    var mapView: MAMapView?
    var locationButton: UIButton?
    var imageLocated: UIImage?
    var imageNotLocate: UIImage?
    var boardView:UIImageView!
    var clockImageView:UIImageView?
    var needleImageView:UIImageView?
    var CancelBt = UIButton()
    var timer:NSTimer?
    var NumImageView = UIImageView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.edgesForExtendedLayout = UIRectEdge.None
   
        initToolBar()
        initMapView()
        initBoardView()
        //createRadar()
        rotate360DegreeWithImageView()
        
        timer?.invalidate()
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "CountDown:", userInfo: nil, repeats: true)
    }
    
    //================================================
    //----采用GIF的格式为页面增加动画的效果----
    //================================================
//    func createRadar(){
//        // jeremy.gif
//        //var url = NSBundle.mainBundle().URLForResource("radar", withExtension: "gif")
//        //var imageData = NSData(contentsOfURL: url!)
//        var imageData = NSData(contentsOfURL: NSBundle.mainBundle()
//            .URLForResource("radar", withExtension: "gif")!)
//        let radar = UIImage.animatedImageWithData(imageData!)
//        var imageView = UIImageView(image: radar)
//        imageView.frame = CGRect(x: 30.0, y: 40.0, width: 250.0, height: 192.0)
//        
//        view.addSubview(imageView)
//        
//        // Returns an animated UIImage
//       // UIImage.animatedImageWithData(imageData)
//    
//    }
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
        
        boardView = UIImageView()
        var boardImage = UIImage(named: "board.png")
        boardView!.image = boardImage
        boardView!.frame = CGRect(x: 0,y: self.view.frame.height-140,width: 320,height:80)
        self.view.addSubview(boardView!)
        
        clockImageView = UIImageView()
        var clockImage = UIImage(named: "clock.png")
        clockImageView!.image = clockImage
        clockImageView!.frame = CGRect(x: 75,y: 40,width: 170,height:170)
        self.view.addSubview(clockImageView!)
        
        var NumImage = UIImage(named: "Num0.png")
        NumImageView.image = NumImage
        NumImageView.frame = CGRect(x: 150, y: 110, width: 24, height: 38)
        self.view.addSubview(NumImageView)
        
        var CancelOrderImage = UIImage(named: "CancelOrder.png")
        CancelBt.setImage(CancelOrderImage, forState: UIControlState.Normal)
        CancelBt.frame = CGRect(x: 58, y: self.view.frame.height-120, width: 204, height: 35)
        CancelBt.addTarget(self, action: "CancelOrder", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(CancelBt)
        
 
    }
    
    var count = 0
    func CountDown(timer: NSTimer){
        

        self.view.layer.removeAllAnimations()
            count++
            if 30 == count{
 
                var LastImage = UIImage(named: "0yuan2.png")
                var LastImageView = UIImageView()
                LastImageView.image = LastImage
                LastImageView.frame = CGRect(x: 140, y: 110, width: 50, height: 50)
                self.view.addSubview(LastImageView)
                needleImageView?.layer.removeAllAnimations()
                
            }
            if 32 == count{
                
                timer.invalidate()
                var m_MainVC: MainViewController!
                m_MainVC = MainViewController()
                m_MainVC.navigationItem.title = "duangduang拉屎"
                m_MainVC.navigationItem.hidesBackButton = true
                self.navigationController?.pushViewController(m_MainVC, animated: true)

            }
            else{
                var NumImage = UIImage(named: "Num\(count).png")
                NumImageView.image = NumImage
                NumImageView.frame = CGRect(x: 150, y: 110, width: 24, height: 38)
                self.view.addSubview(NumImageView)
            
            /*
                //================================================
                //----采用不断访问服务器的方法，这种会增加服务器的负荷----
                //================================================
                
                //MARK: ----判断用户是否被厕主抢单----
                Alamofire.request(.POST, "是否有厕主抢单",
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
                            println("已被抢")
                            
                    var m_ResponsedVC = ResponsedViewController()
                    m_ResponsedVC!.title = "已应答"
                    // self.presentViewController(m_CountDownVC, animated: true, completion: nil)
                    self.navigationController?.pushViewController(m_ResponsedVC, animated: true)
                        }
                }
             */
                
            }
    }
    
    
    //MARK: ----让图片360度的旋转----
    func rotate360DegreeWithImageView()->UIImageView
    {

        var animation = CABasicAnimation(keyPath: "transform")
        animation.fromValue = NSValue(CATransform3D:CATransform3DIdentity)
        
        //围绕Z轴旋转，垂直与屏幕
        animation.toValue = NSValue(CATransform3D: CATransform3DMakeRotation(3.14, 0.0, 0.0, 1.0))
        animation.duration = 0.5
        //旋转效果累计，先转180度，接着再旋转180度，从而实现360旋转
        animation.cumulative = true
        animation.repeatCount = 1000
        
        needleImageView = UIImageView()
        var needleImage = UIImage(named: "needle.png")
        needleImageView!.image = needleImage
        needleImageView!.frame = CGRect(x: 116,y: 92,width: 88,height:65)
        self.view.addSubview(needleImageView!)
        self.needleImageView?.layer.anchorPoint = CGPointMake(0, 0)
        self.needleImageView?.layer.transform = CATransform3DMakeRotation( 0.97 , 1.0, 0.0, 0.0)
        needleImageView?.layer.addAnimation(animation, forKey:nil)
        
        return needleImageView!
    }
  
    func CancelOrder(){
    
        var alert = UIAlertView(title: "提示：", message: "确定要取消订单么？", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "确定")
        alert.show()
        timer?.invalidate()
        needleImageView?.layer.removeAllAnimations()
        
//        Alamofire.request(.POST, "用户取消订单接口",
//            parameters: ["UserID":UDID])
//            
//            .responseString { (request, response, string, error) in
//                
//                println("\n\n======注册数据===========")
//                
//                println("--- request: --- \n \(request)")
//                println("--- response: --- \n \(response)")
//                println("--- data: --- \n \(data)")
//                println("--- error:  --- \n \(error)")

                
    }

    //MARK:---切换到倒计时界面---
    func alertView(alertView: UIAlertView, clickedButtonAtIndex: Int){
        
        if clickedButtonAtIndex == 1
        {
            var alert = UIAlertView(title: "提示：", message: "订单已取消", delegate: self, cancelButtonTitle: "确定")
            alert.show()
        }
        if clickedButtonAtIndex == 0
        {
            //self.dismissViewControllerAnimated(true, completion: nil)
            var m_MainVC: MainViewController!
            m_MainVC = MainViewController()
            m_MainVC.navigationItem.title = "duangduang拉屎"
            m_MainVC.navigationItem.hidesBackButton = true
            self.navigationController?.pushViewController(m_MainVC, animated: true)
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
