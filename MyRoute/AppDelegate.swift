//
//  AppDelegate.swift
//  MyRoute
//
//  Created by xiaoming han on 14-7-21.
//  Copyright (c) 2014 AutoNavi. All rights reserved.
//

import UIKit

let APIKey = "477b7777d055e6f2f4576caacb002d55"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var viewController: MainViewController?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: NSDictionary?) -> Bool {
        // Override point for customization after application launch.
        
        MAMapServices.sharedServices().apiKey = APIKey
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds);
        
        viewController = MainViewController(nibName: nil, bundle: nil);
        
        viewController!.title = "duangduang拉屎";
        
        let naviController = UINavigationController(rootViewController: viewController!);
        
        window!.rootViewController = naviController;
        window!.makeKeyAndVisible();
        
        //判断是否有远程消息通知应用程序
        var str:NSString = UIDevice.currentDevice().systemVersion
        var version:Float = str.floatValue
        if version >= 8.0 {
            UIApplication.sharedApplication().registerUserNotificationSettings(UIUserNotificationSettings(forTypes: UIUserNotificationType.None, categories: nil))
            UIApplication.sharedApplication().registerForRemoteNotifications()
        } else {
            UIApplication.sharedApplication().registerForRemoteNotificationTypes( UIRemoteNotificationType.None)
        }

        
        return true
    }

     //获取终端设备标识，这个标识需要通过接口发送到服务器端，服务器端推送消息到APNS时需要知道终端的标识，APNS通过注册的终端标识找到终端设备。
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        var token:String = deviceToken.description.stringByTrimmingCharactersInSet(NSCharacterSet(charactersInString: "<>"))
        var user: UserInformation! = UserInformation.shareInstance()
        user.m_id = token
        var lord: LordInfomation! = LordInfomation.shareInstance()
        lord.m_id = token
        println("token==\(token)")
        //将token发送到服务器
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        var alert:UIAlertView = UIAlertView(title: "", message: error.localizedDescription, delegate: nil, cancelButtonTitle: "OK")
        alert.show()
    }
    
    //处理收到的消息推送
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
       
        //userInfo 就是服务器推送到客户端的数据
        println("userInfo==\(userInfo)")
        //这里会判断标志位：用户是否被抢单的标志位和厕主是否被推送的标志位
        //userInfo[0]为用户标志位，userInfo[1]为厕主标志位，userInfo[2]为距离，userInfo[3]为小费
        if userInfo[0] == 1  //1表示用户被抢单
        {
            println("已被抢")
            var m_ResponsedVC = ResponsedViewController()
            m_ResponsedVC!.title = "已应答"
            // self.presentViewController(m_CountDownVC, animated: true, completion: nil)
            self.navigationController?.pushViewController(m_ResponsedVC, animated: true)
        }
        if userInfo[1] == 1 //1表示厕主被推送
        {
            var m_SecondOrderPageVC: SecondOrderPageViewController!
            m_SecondOrderPageVC = SecondOrderPageViewController()
            m_SecondOrderPageVC.navigationItem.title = "供厕服务中"
            m_SecondOrderPageVC.navigationItem.hidesBackButton = true
            self.navigationController?.pushViewController(m_SecondOrderPageVC, animated: false)
            
//            m_OrderPageVC.CancelBt.hidden = true
//            m_OrderPageVC.progressView.hidden = true
            
            
        }
    }
    
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.

    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

