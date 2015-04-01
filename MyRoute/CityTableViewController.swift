//
//  NextCityTableViewController.swift
//  MyRoute
//
//  Created by 陈桂 on 15/3/31.
//  Copyright (c) 2015年 AutoNavi. All rights reserved.
//

import Foundation


class CityTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var dataArray: NSMutableArray?
    var tableView: UITableView?
    var registerViewController: RegisterViewController?
    var selectedProvince: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.orangeColor()
        self.navigationItem.title = "选择城市"
//        switch 
        self.dataArray = NSMutableArray()
        self.dataArray!.addObject("东城区")
        self.dataArray!.addObject("西城区")
        self.dataArray!.addObject("崇文区")
        self.dataArray!.addObject("宣武区")
        self.dataArray!.addObject("朝阳区")
        self.dataArray!.addObject("丰台区")
        self.dataArray!.addObject("石景山区")
        self.dataArray!.addObject("海淀区")
        self.dataArray!.addObject("门头沟区")
                
        NSLog("%@", self.dataArray!)
        
        self.tableView = UITableView(frame: self.view.frame, style:UITableViewStyle.Plain)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        self.tableView!.registerClass(UITableViewCell.self, forCellReuseIdentifier: "MyTestCell")
        self.view.addSubview(self.tableView!)
        
        
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


        let selectedCity:String = self.dataArray![indexPath.row] as String
        self.registerViewController?.cityText.text = selectedProvince! + selectedCity
        self.navigationController?.popToViewController(registerViewController!, animated: true)


    }
    
}