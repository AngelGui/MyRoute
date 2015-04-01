//
//  CitiesTableView.swift
//  MyRoute
//
//  Created by 陈桂 on 15/3/31.
//  Copyright (c) 2015年 AutoNavi. All rights reserved.
//

import Foundation

class CitiesTableView: UITableView, UITableViewDataSource, UITableViewDelegate{
    
    var m_cityArray: NSArray! = ["北京","上海","天津"]
    var m_msgCellReuseIndentify: String! = "MsgCell"
    
    override init?(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        
        //.注册单元格为可重用
        self.registerClass(UITableViewCell.self,
            forCellReuseIdentifier: m_msgCellReuseIndentify)
        
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = UITableViewCellSeparatorStyle.None
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - UITableViewDataSource 表视图的数据源方法
    
    //-------------------------------------------------
    // 设置表中某一分区所拥有的行数
    //-------------------------------------------------
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        println(__FUNCTION__, __LINE__)
        
        if nil == m_cityArray || 0 >= m_cityArray.count {
            
            println(__FUNCTION__, __LINE__)
            return 0
        }
        else {
            
            println(__FUNCTION__, __LINE__)
            println("m_messageArray.count: \(m_cityArray.count)")
            return m_cityArray.count
        }
    }
    
    //-------------------------------------------------
    // 设置指定单元格的内容
    //-------------------------------------------------
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        println(__FUNCTION__, __LINE__)
        
        let cell = tableView.dequeueReusableCellWithIdentifier(m_msgCellReuseIndentify, forIndexPath: indexPath) as UITableViewCell
        
        println(__FUNCTION__, __LINE__)
        
        cell.textLabel?.text = "ok"
        
        println(__FUNCTION__, __LINE__)
        
        return cell
    }
    
    
    
    // MARK: - UITableViewDelegate 表视图的委托方法
    
    //-------------------------------------------------
    // 表中某一行被选中的事件处理方法
    //-------------------------------------------------
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        
        let cityName = tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text
        println("did select city: \(cityName)")
        //  dismissViewControllerAnimated(true, completion:nil)
        
    }
    
    
    
}