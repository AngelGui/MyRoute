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
    var cityArray: NSMutableArray?
    var tableView: UITableView?
    var registerViewController: RegisterViewController?
    var selectedProvince: String?
    
    
    var location : NSArray?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.orangeColor()
        self.navigationItem.title = "选择城市"
        
        
        self.cityArray = NSMutableArray()
        //self.dataArray = NSMutableArray()
        for var i=0; i<location?.count ; ++i {
            
            let item = location?[i] as NSDictionary
            
            if item.valueForKey("State")as NSString == selectedProvince
            {
                
                let locationCity: AnyObject? = item.valueForKey("Cities")
                
                for var j=0; j<locationCity?.count ; ++j
                {
                    let itemcity = locationCity?[j] as NSDictionary
                    var cs:NSString = "city"
                    let ckey: AnyObject? = itemcity.valueForKey(cs)
                    // let skey :String = key
                    self.cityArray!.addObject(ckey!)
                    
                }
                
                
            }
            
        }
        
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
        return self.cityArray!.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "MyTestCell")
        var string  = self.cityArray?.objectAtIndex(indexPath.row) as NSString
        cell.textLabel?.text = string
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        
        
        let selectedCity:String = self.cityArray![indexPath.row] as String
        self.registerViewController?.cityText.text = selectedProvince! + selectedCity
        self.navigationController?.popToViewController(registerViewController!, animated: true)
        
        
    }
    
}