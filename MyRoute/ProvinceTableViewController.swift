//
//  CitiesTableViewController.swift
//  MyRoute
//
//  Created by 陈桂 on 15/3/31.
//  Copyright (c) 2015年 AutoNavi. All rights reserved.
//

import Foundation

class ProvinceTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var dataArray: NSMutableArray?
    var tableView: UITableView?
    var registerViewController: RegisterViewController?
    var location: NSArray?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.orangeColor()
        
        self.dataArray = NSMutableArray()
        for var i=0; i<location?.count ; ++i {
            let item = location?[i] as NSDictionary
            var ss:NSString = "State"
            let key: AnyObject? = item.valueForKey(ss)
           // let skey :String = key
            self.dataArray!.addObject(key!)
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
        //print(self.dataArray)
        var m_City = CityTableViewController()
        m_City.registerViewController = self.registerViewController
        m_City.selectedProvince = province
        m_City.location = self.location
        
        self.navigationController?.pushViewController(m_City, animated: true)
    
    }
 
}