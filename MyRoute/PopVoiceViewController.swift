//
//  PopViewController.swift
//  MyRoute
//
//  Created by 陈桂 on 15/3/30.
//  Copyright (c) 2015年 AutoNavi. All rights reserved.
//

import Foundation


class PopVoiceViewController: UIViewController{
    

    var voiceView:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.modalPresentationStyle = .Custom
        initVoiceView()
        createTapGesture()

    }
     
    
    func initVoiceView(){
        
        voiceView = UIImageView()
        var voiceImage = UIImage(named: "voiceWin.png")
        voiceView!.image = voiceImage
        voiceView!.frame = CGRect(x: 8, y: self.view.frame.height-148, width: 120, height: 140)
        self.view.addSubview(voiceView!)
        
        }
    
  
    //MARK: - UITapGestureRecognizer
    //-------------------------------------------------
    //给m_PopVC添加单击手势识别器
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