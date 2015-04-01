//
//  PopVoiceWin.swift
//  MyRoute
//
//  Created by 陈桂 on 15/3/25.
//  Copyright (c) 2015年 AutoNavi. All rights reserved.
//

import Foundation

class ProvinceTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var pDataSource: NSMutableArray?
    var ptableView: UITableView?
    var regionID:string?
    var regionName: String?
    var childrensArray: NSString
    var registerViewController: RegisterViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.orangeColor()
        
        self.dataArray = NSMutableArray()
        self.dataArray!.addObject("北京市")
        self.dataArray!.addObject("江苏省")
        self.dataArray!.addObject("浙江省")
        self.dataArray!.addObject("安徽省")
        self.dataArray!.addObject("福建省")
        self.dataArray!.addObject("江西省")
        self.dataArray!.addObject("山东省")
        self.dataArray!.addObject("湖北省")
        self.dataArray!.addObject("湖南省")
        self.dataArray!.addObject("河南省")
        self.dataArray!.addObject("广东省")
        self.dataArray!.addObject("天津市")
        self.dataArray!.addObject("广西壮族自治区")
        self.dataArray!.addObject("海南省")
        self.dataArray!.addObject("重庆市")
        self.dataArray!.addObject("四川省")
        self.dataArray!.addObject("贵州省")
        self.dataArray!.addObject("云南省")
        self.dataArray!.addObject("西藏自治区")
        self.dataArray!.addObject("陕西省")
        self.dataArray!.addObject("甘肃省")
        self.dataArray!.addObject("青海省")
        self.dataArray!.addObject("河北省")
        self.dataArray!.addObject("宁夏回族自治区")
        self.dataArray!.addObject("新疆维吾尔自治区")
        self.dataArray!.addObject("香港特别行政区")
        self.dataArray!.addObject("澳门特别行政区")
        self.dataArray!.addObject("台湾省")
        self.dataArray!.addObject("山西省")
        self.dataArray!.addObject("内蒙古自治区")
        self.dataArray!.addObject("辽宁省")
        self.dataArray!.addObject("吉林省")
        self.dataArray!.addObject("黑龙江省")
        self.dataArray!.addObject("上海市")
        
        NSLog("%@", self.dataArray!)
        
        self.tableView = UITableView(frame: self.view.frame, style:UITableViewStyle.Plain)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        self.tableView!.registerClass(UITableViewCell.self, forCellReuseIdentifier: "MyTestCell")
        self.view.addSubview(self.tableView!)
        
        
    }
    override func viewDidAppear(animated: Bool) {
        if(self.p)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.dataArray!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "MyTestCell")!
        
        var string  = self.dataArray?.objectAtIndex(indexPath.row) as NSString
        cell.textLabel?.text = string
        
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        
        
        var province = self.dataArray![indexPath.row] as? String
        print(self.dataArray)
        var m_City = CityTableViewController()
        m_City.registerViewController = self.registerViewController
        m_City.selectedProvince = province
        
        
        self.navigationController?.pushViewController(m_City, animated: true)
        
    }
    
}