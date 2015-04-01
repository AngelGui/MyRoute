//
//  CountDownViewController.swift
//  MyRoute
//
//  Created by 陈桂 on 15/3/26.
//  Copyright (c) 2015年 AutoNavi. All rights reserved.
//

import Foundation

class CountDownViewController: UIViewController, MAMapViewDelegate{
    
    var mapView: MAMapView?
    var locationButton: UIButton?
    var imageLocated: UIImage?
    var imageNotLocate: UIImage?
    var boardView:UIImageView!
    var CancelBt = UIButton()
    private var progressView: ProgressView!
    private var label:UILabel!
    private var progress: CGFloat = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.edgesForExtendedLayout = UIRectEdge.None
   
        initToolBar()
        initMapView()
        initBoardView()
        createProgressView()
        createRadar()
    }
    
    func createRadar(){
        // jeremy.gif
        //var url = NSBundle.mainBundle().URLForResource("radar", withExtension: "gif")
        //var imageData = NSData(contentsOfURL: url!)
        var imageData = NSData(contentsOfURL: NSBundle.mainBundle()
            .URLForResource("radar", withExtension: "gif")!)
        let radar = UIImage.animatedImageWithData(imageData!)
        var imageView = UIImageView(image: radar)
        imageView.frame = CGRect(x: 30.0, y: 40.0, width: 250.0, height: 192.0)
        
        view.addSubview(imageView)
        
        // Returns an animated UIImage
       // UIImage.animatedImageWithData(imageData)
    
    }
    func createProgressView(){
    
        progressView = ProgressView(frame: CGRectMake(110.0, 100.0, 100.0, 100.0))
        self.view.addSubview(progressView)
        
        label = UILabel(frame: CGRectMake(110.0, 200.0, 100.0, 25.0))
        label.textColor = UIColor.blackColor()
        label.textAlignment = NSTextAlignment.Center
        label.font = UIFont.systemFontOfSize(18.0)
        self.view.addSubview(label)
        
        var timer = NSTimer.scheduledTimerWithTimeInterval(0.3, target: self, selector: "updateTime:", userInfo: nil, repeats: true)
    
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
        
        
        var gotoWCImage = UIImage(named: "gotoWCBt.png")
        CancelBt.setImage(gotoWCImage, forState: UIControlState.Normal)
        CancelBt.frame = CGRect(x: 45, y: self.view.frame.height-120, width: 230, height: 35)
        CancelBt.addTarget(self, action: "changeToMainVC", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(CancelBt)
 
    }
    
    func changeToMainVC(){
    
        //self.dismissViewControllerAnimated(true, completion: nil)
       //MARK:---切换到倒计时界面---
         var m_MainVC: MainViewController!
    
        m_MainVC = MainViewController()
        m_MainVC.title = "主页"
        self.presentViewController(m_MainVC, animated: true, completion: nil)
             
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
