//
//  PopOrderViewController.swift
//  MyRoute
//
//  Created by 陈桂 on 15/3/31.
//  Copyright (c) 2015年 AutoNavi. All rights reserved.
//

import Foundation

class PopOrderViewController: UIViewController{
    
    
    var orderView:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.modalPresentationStyle = .Custom
        initOrderView()
        createTapGesture()
        
    }
    
    
    func initOrderView(){
        
        orderView = UIImageView()
        var orderImage = UIImage(named: "orderWin.png")
        orderView!.image = orderImage
        orderView!.frame = CGRect(x: 221, y: self.view.frame.height-132, width: 91, height: 123)
        self.view.addSubview(orderView!)
        
    }
    
    
    //MARK: - UITapGestureRecognizer
    //-------------------------------------------------
    //给当前视图添加单击手势识别器
    //-------------------------------------------------
    
    var m_tapGes: UITapGestureRecognizer! = UITapGestureRecognizer()
    
    func createTapGesture() {
        
        println(__FUNCTION__, __LINE__)
        
        m_tapGes.addTarget(self, action: "tapGesture:")
        self.view.addGestureRecognizer(m_tapGes)
    }
    
    //-------------------------------------------------
    //单击当前视图时，关闭弹窗
    //-------------------------------------------------
    func tapGesture(tapGes: UITapGestureRecognizer) {
        println(__FUNCTION__, __LINE__)
        
        self.dismissViewControllerAnimated(0, completion: nil)
    }
}