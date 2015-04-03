//
//  CodeTestViewController.swift
//  MyRoute
//
//  Created by 陈桂 on 15/3/30.
//  Copyright (c) 2015年 AutoNavi. All rights reserved.
//

import Foundation
import Alamofire

class CodeTestViewController: UIViewController, UITextFieldDelegate{
    
    var telephoneText: UITextField! = UITextField()
    var codeBt = UIButton()
    var codeText: UITextField! = UITextField()
    var orderBt = UIButton()
    var serviceProtocol = UILabel()
    var serviceProtocolBt = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.whiteColor()
        
        initCodeVC()
    }
    
    func initCodeVC(){
        
        telephoneText.frame = CGRectMake(20, 90, 200, 45)
        telephoneText.placeholder = "请输入联系的手机"
        telephoneText.keyboardType = UIKeyboardType.NumberPad
        telephoneText.clearButtonMode = UITextFieldViewMode.WhileEditing
        telephoneText.borderStyle = UITextBorderStyle.RoundedRect
        telephoneText.delegate = self
        self.view.addSubview(telephoneText)
        
        
        var codeBtImage = UIImage(named: "codeTest.png")
        codeBt.frame = CGRect(x: 245, y: 90, width: 65, height: 40)
        codeBt.setImage(codeBtImage, forState: UIControlState.Normal)
        codeBt.addTarget(self, action: "CodeTest", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(codeBt)
        
        
        codeText.frame = CGRectMake(20, 160, 280, 45)
        codeText.placeholder = "请输入验证码"
        codeText.keyboardType = UIKeyboardType.NumberPad
        codeText.clearButtonMode = UITextFieldViewMode.WhileEditing
        codeText.borderStyle = UITextBorderStyle.RoundedRect
        codeText.delegate = self
        self.view.addSubview(codeText)
        
        var submitImage = UIImage(named: "order.png")
        orderBt.frame = CGRect(x: 20, y: 230, width: 280, height: 40)
        orderBt.setImage(submitImage, forState: UIControlState.Normal)
        orderBt.addTarget(self, action: "changeToOrderPage", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(orderBt)
        
        serviceProtocol.text = "点击-开始接单，即表示您同意"
        serviceProtocol.frame = CGRect(x: 50, y: 280, width: 220, height: 20)
        serviceProtocol.backgroundColor = UIColor.whiteColor()
        serviceProtocol.font = UIFont.systemFontOfSize(15)
        self.view.addSubview(serviceProtocol)
        
        serviceProtocolBt.setTitle("《duangduang拉屎服务协议》", forState: UIControlState.Normal)
        serviceProtocolBt.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        serviceProtocolBt.frame = CGRect(x: 45, y: 300, width: 220, height: 20)
        serviceProtocolBt.titleLabel?.font = UIFont.systemFontOfSize(15)
        serviceProtocolBt.addTarget(self, action: "showProtocol", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(serviceProtocolBt)
    }
    
    func  showProtocol(){
        
        serviceProtocolBt.setTitleColor(UIColor.grayColor(), forState: UIControlState.Highlighted)
        var m_ServiceProtocolVC: ServiceProtocolViewController!
        m_ServiceProtocolVC = ServiceProtocolViewController()
        m_ServiceProtocolVC.navigationItem.title = "服务协议"
        self.navigationController?.pushViewController(m_ServiceProtocolVC, animated: false)
        
    }
    
    
    func  CodeTest(){
        
        Alamofire.request(.POST, "http://192.168.31.200:8002/api/Users/GetVerifyCode", parameters: ["Mobile":telephoneText.text])
            .responseString { (request, response, string, error) in
                
                println(string)
        }
        
    }
    
    
    func  changeToOrderPage(){
        
        var m_OrderPageVC: OrderPageViewController!
        m_OrderPageVC = OrderPageViewController()
        m_OrderPageVC.navigationItem.title = "供厕服务中"
        m_OrderPageVC.navigationItem.hidesBackButton = true
        self.navigationController?.pushViewController(m_OrderPageVC, animated: false)
    }
    
}