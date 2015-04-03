//
//  CustomCalloutView.swift
//  MyRoute
//
//  Created by 陈桂 on 15/4/3.
//  Copyright (c) 2015年 AutoNavi. All rights reserved.
//

import Foundation

class CustomCalloutView: UIView {
   
    
    //----设置气泡后面的矩形---
    override func drawRect(rect:CGRect)
    {
        
        
        self.drawInContext(UIGraphicsGetCurrentContext())
        
        self.layer.shadowColor = UIColor.redColor().CGColor
        self.layer.shadowOpacity = 1.0
        self.layer.shadowOffset = CGSizeMake(0.0, 0.0)
        
    }
    
    //----设置气泡的显示----
    func drawInContext(context:CGContextRef)
    {
        
        
        CGContextSetLineWidth(context, 2.0)
        CGContextSetFillColorWithColor(context, UIColor(red:0.3,green:0.3,blue:0.3,alpha:0.8).CGColor)
        
        self.getDrawPath(context)
        
        CGContextFillPath(context)
        
    }

    //----设置气泡下面的倒三角----
    func getDrawPath(context:CGContextRef)
    {
        
        
        var rrect =  self.bounds
        
        var radius:CGFloat =  6
        
        var minx =  CGRectGetMinX(rrect)
        var midx = CGRectGetMidX(rrect)
        var maxx = CGRectGetMaxX(rrect)
        var miny =  CGRectGetMinY(rrect)
        
        var maxy = CGRectGetMaxY(rrect) - 10
        
        CGContextMoveToPoint(context, midx+10, maxy)
        CGContextAddLineToPoint(context,midx, maxy+10)
        CGContextAddLineToPoint(context,midx-10, maxy)
        
        CGContextAddArcToPoint(context, minx, maxy, minx, miny, radius)
        CGContextAddArcToPoint(context, minx, minx, maxx, miny, radius)
        CGContextAddArcToPoint(context, maxx, miny, maxx, maxx, radius)
        
        CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius)
        CGContextClosePath(context)
    }
    
    let kPortraitMargin:CGFloat = 5
    let kPortraitWidth:CGFloat = 70
    let kPortraitHeight:CGFloat = 50
    
    let kTitleWidth:CGFloat = 120
    let kTitleHeight:CGFloat = 20
    
    
    var portraitView:UIImageView!
    var subtitleLabel:UILabel!
    var titleLabel:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initSubViews()
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func initSubViews()
    {
        
        // 添加图片，即商户图
        self.portraitView = UIImageView(frame:CGRectMake(kPortraitMargin, kPortraitMargin, kPortraitWidth, kPortraitHeight))
        var m_image = UIImage(named: "0yuan2.png")

        self.portraitView.image = m_image
      //  self.portraitView.backgroundColor = UIColor.blackColor()
        
        self.addSubview(self.portraitView)
        
        
        // 添加标题，即商户名
        self.titleLabel = UILabel(frame:CGRectMake(kPortraitMargin * 2 + kPortraitWidth, kPortraitMargin, kTitleWidth, kTitleHeight))
        
        self.titleLabel.font = UIFont.boldSystemFontOfSize(14)
        
        self.titleLabel.textColor = UIColor.whiteColor()
        
        self.titleLabel.text = "duangduang拉屎"
        self.addSubview(self.titleLabel)
        
        
        // 添加副标题，即商户地址
        self.subtitleLabel = UILabel(frame:CGRectMake(kPortraitMargin * 2 + kPortraitWidth, kPortraitMargin * 2 + kTitleHeight, kTitleWidth, kTitleHeight))
        
        self.subtitleLabel.font = UIFont.systemFontOfSize(14)
        
        self.subtitleLabel.textColor = UIColor.whiteColor()
        
        self.subtitleLabel.text = "路边拉屎终结者"
        self.addSubview(self.subtitleLabel)
        
    }
       
   
}

