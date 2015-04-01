//
//  ProgressView.swift
//  ProgressViewDemo
//
//  Created by 陈桂 on 14-10-17.
//  Copyright (c) 2014年 陈桂. All rights reserved.
//

import UIKit
class ProgressView:UIView {
   
    private var trackLayer: CAShapeLayer!
    private var trackPath: UIBezierPath!
    private var progressLayer: CAShapeLayer!
    private var progressPath: UIBezierPath!
    
    private var prgWidth: CGFloat = 10.0
    
    ///Draw a graphic
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        var centerPoint = CGPoint(x: self.bounds.width/2.0, y: self.bounds.height/2.0)
        var radius = CGFloat(self.bounds.width - prgWidth)/2.0
        
        trackPath = UIBezierPath(arcCenter: centerPoint,
            radius: radius,
            startAngle: 0,
            endAngle: CGFloat(M_PI*2),
            clockwise: true)
        trackLayer=CAShapeLayer()
        trackLayer.frame = self.bounds
        trackLayer.fillColor = nil
        trackLayer.lineWidth = prgWidth
        trackLayer.strokeColor = UIColor.grayColor().CGColor
        
        trackLayer.path = trackPath.CGPath
        
        self.layer.addSublayer(trackLayer)
        
        progressLayer=CAShapeLayer()
        progressLayer.frame = self.bounds
        progressLayer.fillColor = nil
        progressLayer.lineWidth = prgWidth
        progressLayer.strokeColor = UIColor.orangeColor().CGColor
        
        self.layer.addSublayer(progressLayer)
        
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    ///It is a driver for progress
    ///
    ///:param: progress
    func setProgress(progress: CGFloat){
        
        var centerPoint = CGPoint(x: self.bounds.width/2.0, y: self.bounds.height/2.0)
        var radius = CGFloat(self.bounds.width - prgWidth)/2.0
        var endAngel = CGFloat(M_PI * 2) * progress - CGFloat(M_PI_2)
        
        progressPath = UIBezierPath(arcCenter: centerPoint, radius: radius, startAngle: CGFloat(-M_PI_2), endAngle: endAngel, clockwise: true)
        progressLayer.path = progressPath.CGPath
    
    }

}