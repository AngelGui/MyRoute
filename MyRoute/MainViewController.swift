//
//  MainViewController.swift
//  MyRoute
//
//  Created by xiaoming han on 14-7-21.
//  Copyright (c) 2014 AutoNavi. All rights reserved.

import UIKit
import Alamofire


@IBDesignable
class MainViewController: UIViewController, MAMapViewDelegate{
    
    var mapView: MAMapView?
    var userLat: CLLocationDegrees?
    var userLon: CLLocationDegrees?
    var locationButton: UIButton?
    var imageLocated: UIImage?
    var imageNotLocate: UIImage?
    var boardView:UIImageView!
    var board1View:UIImageView!
    var userBt = UIButton()
    var lordBt = UIButton()
    var tipLabel = UILabel()
    var tip0Bt = UIButton()
    var tip1Bt = UIButton()
    var tip10Bt = UIButton()
    var userTip: Int? = 0
    var voiceBt = UIButton()
    var gotoWCBt = UIButton()
    var giveWCBt = UIButton()
    var orderBt = UIButton()
    var voiceWin = UIImageView()
    
    var gotoWCImage = UIImage(named: "gotoWCBt.png")

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.edgesForExtendedLayout = UIRectEdge.None
    
        
        initToolBar()
        initMapView()
        initBoardView()
        //createTapGesture()
        
    }

    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        
        var pointAnnotation = MAPointAnnotation()
        pointAnnotation.coordinate = CLLocationCoordinate2DMake(39.989631, 116.481018)
        pointAnnotation.title = "duangduang拉屎"
        pointAnnotation.subtitle = "路边拉屎终结者"
        mapView?.addAnnotation(pointAnnotation)
    }

//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//    }

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
    
    //MARK: ---创建首页下的白色背景图---
    func initBoardView(){
        
        boardView = UIImageView()
        var boardImage = UIImage(named: "board.png")
        boardView!.image = boardImage
       // boardView!.frame = CGRect(x: 0,y: self.view.frame.height-230,width: 320,height:168)
        boardView!.frame = CGRect(x: 0,y: self.view.frame.height-230,width: self.view.frame.width, height: self.view.frame.height-168)
        boardView.autoresizingMask =  UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        self.view.addSubview(boardView!)

        //为坑主和屎客添加轻扫手势
        board1View = UIImageView()
        var board1Image = UIImage(named: "board.png")
        board1View!.image = board1Image
        board1View!.frame = CGRect(x: 60,y: self.view.frame.height-225,width: 250,height:45)
        self.view.addSubview(board1View!)
        board1View.userInteractionEnabled = true
        var swipeRight = UISwipeGestureRecognizer(target: self, action: "respondToSwipeRightGesture:")
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        board1View.addGestureRecognizer(swipeRight)
        var swipeLeft = UISwipeGestureRecognizer(target: self, action: "respondToSwipeLeftGesture:")
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        board1View.addGestureRecognizer(swipeLeft)
        
        var userImage = UIImage(named:"user1.png")
        userBt.setImage(userImage, forState: UIControlState.Normal)
        userBt.frame = CGRect(x: 160, y: self.view.frame.height-225, width: 23, height: 37)
        userBt.addTarget(self, action: "changeToUser", forControlEvents: UIControlEvents.TouchUpInside)
        //userBt.autoresizingMask = UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleWidth
        self.view.addSubview(userBt)
        
        
        var lordImage = UIImage(named:"lord2.png")
        lordBt.setImage(lordImage, forState: UIControlState.Normal)
        lordBt.frame = CGRect(x: 200, y: self.view.frame.height-225, width: 23, height: 37)
        lordBt.addTarget(self, action: "changeToLord", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(lordBt)
        
        
        tipLabel.text = "愿支付"
        tipLabel.frame = CGRect(x: 15, y: self.view.frame.height-160, width: 100, height: 20)
        tipLabel.backgroundColor = UIColor.whiteColor()
        tipLabel.font = UIFont.systemFontOfSize(15)
//      tipLabel.autoresizingMask = UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleLeftMargin
        self.view.addSubview(tipLabel)
        
        var tip0Image = UIImage(named: "0yuan2.png")
        tip0Bt.setImage(tip0Image, forState: UIControlState.Normal)
        tip0Bt.frame = CGRect(x: 70, y: self.view.frame.height-175, width: 50, height: 50)
        tip0Bt.addTarget(self, action: "changeTip:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(tip0Bt)
        
        var tip1Image = UIImage(named: "1yuan1.png")
        tip1Bt.setImage(tip1Image, forState: UIControlState.Normal)
        tip1Bt.frame = CGRect(x: 150, y: self.view.frame.height-175, width: 50, height: 50)
        tip1Bt.addTarget(self, action: "changeTip:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(tip1Bt)
        
        var tip10Image = UIImage(named: "10yuan1.png")
        tip10Bt.setImage(tip10Image, forState: UIControlState.Normal)
        tip10Bt.frame = CGRect(x: 230, y: self.view.frame.height-175, width: 50, height: 50)
        tip10Bt.addTarget(self, action: "changeTip:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(tip10Bt)
        
        var voiceImage = UIImage(named: "voiceBt.png")
        voiceBt.setImage(voiceImage, forState: UIControlState.Normal)
        voiceBt.frame = CGRect(x: 8, y: self.view.frame.height-115, width: 42, height: 42)
        voiceBt.addTarget(self, action: "popVoiceWin", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(voiceBt)
        
        var gotoWCImage = UIImage(named: "gotoWCBt.png")
        gotoWCBt.setImage(gotoWCImage, forState: UIControlState.Normal)
        gotoWCBt.frame = CGRect(x: 58, y: self.view.frame.height-110, width: 204, height: 35)
        gotoWCBt.addTarget(self, action: "changeToCountDown:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(gotoWCBt)
        
        var orderImage = UIImage(named: "orderBt.png")
        orderBt.setImage(orderImage, forState: UIControlState.Normal)
        orderBt.frame = CGRect(x: 270, y: self.view.frame.height-115, width: 42, height: 42)
        orderBt.addTarget(self, action: "popOrderWin", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(orderBt)
    }
    
    func respondToSwipeRightGesture(gesture:UISwipeGestureRecognizer){
    
        println(__FUNCTION__,__LINE__)
        changeToUser()
    }
    
    func respondToSwipeLeftGesture(gesture:UISwipeGestureRecognizer){
        
        println(__FUNCTION__,__LINE__)
        changeToLord()
    }
    
    func changeToUser(){
        
        var userImage = UIImage(named:"user1.png")
        userBt.setImage(userImage, forState: UIControlState.Normal)
        userBt.frame = CGRect(x: 150, y: self.view.frame.height-160, width: 23, height: 37)
        self.view.addSubview(userBt)
        
        
        var lordImage = UIImage(named:"lord2.png")
        lordBt.setImage(lordImage, forState: UIControlState.Normal)
        lordBt.frame = CGRect(x: 200, y: self.view.frame.height-160, width: 23, height: 37)
        self.view.addSubview(lordBt)
        
        tip0Bt.alpha = 1
        tip1Bt.alpha = 1
        tip10Bt.alpha = 1
        tipLabel.text = "愿支付"
        tipLabel.frame = CGRect(x: 15, y: self.view.frame.height-95, width: 50, height: 20)
        tipLabel.backgroundColor = UIColor.whiteColor()
        tipLabel.font = UIFont.systemFontOfSize(15)
        self.view.addSubview(tipLabel)
        
        var gotoWCImage = UIImage(named: "gotoWCBt.png")
        gotoWCBt.setImage(gotoWCImage, forState: UIControlState.Normal)
        gotoWCBt.enabled = true
        giveWCBt.enabled = false
        gotoWCBt.frame = CGRect(x: 58, y: self.view.frame.height-46, width: 204, height: 35)
        gotoWCBt.addTarget(self, action: "changeToCountDown:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(gotoWCBt)
    }
    
    func changeToLord(){

        var userImage = UIImage(named:"user2.png")
        userBt.setImage(userImage, forState: UIControlState.Normal)
        userBt.frame = CGRect(x: 100, y: self.view.frame.height-160, width: 23, height: 37)
        self.view.addSubview(userBt)
        
        var lordImage = UIImage(named:"lord1.png")
        lordBt.setImage(lordImage, forState: UIControlState.Normal)
        lordBt.frame = CGRect(x: 150, y: self.view.frame.height-160, width: 23, height: 37)
        self.view.addSubview(lordBt)
        
        tip0Bt.alpha = 0
        tip1Bt.alpha = 0
        tip10Bt.alpha = 0
        tipLabel.text = "duangduang -- 路边拉屎终结者！"
        tipLabel.frame = CGRect(x: 55, y: self.view.frame.height-90, width: 250, height: 20)
        tipLabel.backgroundColor = UIColor.whiteColor()
        tipLabel.font = UIFont.systemFontOfSize(15)
        self.view.addSubview(tipLabel)
        
        var giveWCImage = UIImage(named: "giveWCBt.png")
        giveWCBt.setImage(giveWCImage, forState: UIControlState.Normal)
        giveWCBt.enabled = true
        gotoWCBt.enabled = false
        giveWCBt.frame = CGRect(x: 58, y: self.view.frame.height-46, width: 204, height: 35)
        giveWCBt.addTarget(self, action: "changeToCountDown:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(giveWCBt)
    }
    
    func changeTip(sender: UIButton){
        
        switch sender {
        case tip0Bt:
            sender.setImage(UIImage(named: "0yuan2.png"), forState: UIControlState.Normal)
            tip1Bt.setImage(UIImage(named: "1yuan1.png"), forState: UIControlState.Normal)
            tip10Bt.setImage(UIImage(named: "10yuan1.png"), forState: UIControlState.Normal)
            userTip = 0
        case tip1Bt:
            sender.setImage(UIImage(named: "1yuan2.png"), forState: UIControlState.Normal)
            tip0Bt.setImage(UIImage(named: "0yuan1.png"), forState: UIControlState.Normal)
            tip10Bt.setImage(UIImage(named: "10yuan1.png"), forState: UIControlState.Normal)
            userTip = 1
        case tip10Bt:
            sender.setImage(UIImage(named: "10yuan2.png"), forState: UIControlState.Normal)
            tip0Bt.setImage(UIImage(named: "0yuan1.png"), forState: UIControlState.Normal)
            tip1Bt.setImage(UIImage(named: "1yuan1.png"), forState: UIControlState.Normal)
            userTip = 10
        default:
            sender.setImage(UIImage(named: "0yuan2.png"), forState: UIControlState.Normal)
        }
    }
    
    
    let m_PopVoiceVC = PopVoiceViewController()
    var timer: NSTimer?
    func popVoiceWin(){

                
        m_PopVoiceVC.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        self.presentViewController(m_PopVoiceVC, animated: false, completion: nil)
        timer?.invalidate()
        timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "tapGesture:", userInfo: nil, repeats: false)

    }
    
    let m_PopOrderVC = PopOrderViewController()
    func popOrderWin(){
        
        m_PopOrderVC.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        self.presentViewController(m_PopOrderVC, animated: false, completion: nil)
        timer?.invalidate()
        timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "tapGesture:", userInfo: nil, repeats: false)
    }
    
    //MARK:---切换到倒计时界面或者是厕主注册界面---
    var m_CountDownVC: CountDownViewController!
    var m_RegisterVC: RegisterViewController!
    //-------------------------------------------------
    // 用户发送订单并解析返回数据，判断是否发送订单成功
    //-------------------------------------------------
    var m_isSubmitSuccess: Bool =  false
    func changeToCountDown(sender:UIButton) {

        var user: UserInformation! = UserInformation.shareInstance()
        if sender == gotoWCBt
        {
            Alamofire.request(.POST, "用户发送订单接口",
                parameters: ["UserID":user.m_id,
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
//                    var resultDicData = data as NSDictionary
//                    var resultLoginArray = resultDicData.objectForKey("result") as NSArray
//                    println("resultLoginArray : \(resultLoginArray)")
//                    
//                    var resultDic = resultLoginArray.objectAtIndex(0) as NSDictionary
//                    println("resultDic : \(resultDic)")
//                    
//                    if 10 == resultDic.objectForKey("hbCode") as UInt {
//                        println("注册成功")
//                        
//                        self.m_isSubmitSuccess = true
                    
                        m_CountDownVC = CountDownViewController()
                        m_CountDownVC!.title = "等待应答"
                        // self.presentViewController(m_CountDownVC, animated: true, completion: nil)
                        self.navigationController?.pushViewController(m_CountDownVC, animated: true)
//                    }
//                    else {
//                        var alert = UIAlertView(title: "错误提示: ",
//                            message: "发送订单失败",
//                            delegate: self,
//                            cancelButtonTitle: "确定")
//                        alert.show()
//                        
//                        self.m_isSubmitSuccess = false
//                    }                    
//
//            }
            
        }
       if sender == giveWCBt
        {
            m_RegisterVC = RegisterViewController()
            m_RegisterVC!.title = "提交信息"
            self.navigationController?.pushViewController(m_RegisterVC, animated: true)
        }
       
    }
   
    
    /*
    //MARK: - UITapGestureRecognizer
    
    //-------------------------------------------------
    //给m_PopVC添加单击手势识别器
    //-------------------------------------------------
    
    var m_tapGes: UITapGestureRecognizer! = UITapGestureRecognizer()
    
    func createTapGesture() {
        
        println(__FUNCTION__, __LINE__)
        
        m_tapGes.addTarget(self, action: "tapGesture:")
        m_PopVC.view.addGestureRecognizer(m_tapGes)
    }
    */
    //-------------------------------------------------
    //单击当前视图时，关闭弹窗
    //-------------------------------------------------
    func tapGesture(tapGes: UITapGestureRecognizer) {
        println(__FUNCTION__, __LINE__)
        
       m_PopVoiceVC.dismissViewControllerAnimated(0, completion: nil)
       m_PopOrderVC.dismissViewControllerAnimated(0, completion: nil)

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
               userLat = location.coordinate.latitude
               userLon = location.coordinate.longitude

        /*
        let infoArray: [(String, String)] = [("coordinate", NSString(format: "<%.4f, %.4f>", location.coordinate.latitude, location.coordinate.longitude)),
            ("speed", NSString(format: "%.2fm/s(%.2fkm/h)", location.speed, location.speed * 3.6)),
            ("accuracy", "\(location.horizontalAccuracy)m"),
            ("altitude", NSString(format: "%.2fm", location.altitude))]
       */
        
        var x = location.coordinate.latitude
        var y = location.coordinate.longitude
        var A:CGPoint = CGPoint(x: x-0.01, y: y-0.01)
        var B:CGPoint = CGPoint(x: x-0.01, y: y+0.01)
        var C:CGPoint = CGPoint(x: x+0.01, y: y-0.01)
        var D:CGPoint = CGPoint(x: x+0.01, y: y+0.01)
        
        var toiletImage = UIImage(named: "toilet.png")
        var toiletImageView = UIImageView(image: toiletImage)
        toiletImageView.center = A
        mapView.addSubview(toiletImageView)
        
        var toiletIconImage = UIImage(named: "toilet.png")
        var toiletImageIconView = UIImageView(image: toiletIconImage)
        toiletImageIconView.center = B
        mapView.addSubview(toiletImageIconView)

    }
    
    
    //MARK: ---显示用户自定义的标记图标---
    func mapView(mapView: MAMapView!, viewForAnnotation annotation: MAAnnotation!) -> MAAnnotationView! {
     
//        if annotation == isKindOfClass(MAPointAnnotation)
//        {
//            var pointReuseIdentifier: NSString = "pointReuseIdentifier"
//            var annotationView = MAPinAnnotationView(annotation: annotation, reuseIdentifier: pointReuseIdentifier)
//            annotationView.canShowCallout = true
//            annotationView.draggable = true
//            return annotationView
//        }
//        return nil
        var annotationView = CustomAnnotationView()
        annotationView.image = UIImage(named: "lord2.png")
        annotationView.canShowCallout = false
        annotationView.centerOffset = CGPointMake(0, -18)
        return annotationView
        
    }


    func mapView(mapView: MAMapView, didChangeUserTrackingMode mode: MAUserTrackingMode, animated: Bool) {
        if mode == MAUserTrackingMode.None {
            locationButton?.setImage(imageNotLocate, forState: UIControlState.Normal)
        }
        else {
            locationButton?.setImage(imageLocated, forState: UIControlState.Normal)
        }
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
}
