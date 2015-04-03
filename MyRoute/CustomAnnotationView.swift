//
//  CustomAnnotationView.swift
//  MyRoute
//
//  Created by 陈桂 on 15/4/3.
//  Copyright (c) 2015年 AutoNavi. All rights reserved.
//

import Foundation

class CustomAnnotationView: MAAnnotationView {
    
    var calloutView = CustomCalloutView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
    
    //----设置弹出的气泡的高宽----
    let kCalloutWidth:CGFloat = 200
    let kCalloutHeight:CGFloat = 70
  
    override func setSelected(selected:Bool, animated:Bool)
    {
        
        if (self.selected == selected)
        {
            return
        }
        
        if (selected)
        {

        self.calloutView = CustomCalloutView(frame:CGRectMake(0, 0, kCalloutWidth, kCalloutHeight))
        //-----设置倒三角的中心点的位置----
        self.calloutView.center = CGPointMake(CGRectGetWidth(self.bounds) / 2 + self.calloutOffset.x, -CGRectGetHeight(self.calloutView.bounds) / 2 + self.calloutOffset.y)

           
            self.addSubview(self.calloutView)
            
        }
        else
        {
            //----设置弹出的气泡无法收回去---
        //    self.calloutView.removeFromSuperview()
            
        }
        
        super.setSelected(selected, animated:animated)
        
    }

}