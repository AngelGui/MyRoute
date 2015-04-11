//
//  RegisterViewController.swift
//  MyRoute
//
//  Created by 陈桂 on 15/3/26.
//  Copyright (c) 2015年 AutoNavi. All rights reserved.
//

import Foundation
import Alamofire


extension String {
    subscript (r: Range<Int>) -> String {
        get {
            let startIndex = advance(self.startIndex, r.startIndex)
            let endIndex = advance(startIndex, r.endIndex - r.startIndex)
            
            return self[Range(start: startIndex, end: endIndex)]
        }
    }
}

class RegisterViewController: UIViewController, MAMapViewDelegate, UITextFieldDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    var location: NSArray?
    
    var didLabel = UILabel()
    var arrow = UIButton()
    var toiletTypeLabel = UILabel()
    var sitToilet = UIButton()
    var crouchToilet = UIButton()
    var providersLabel = UILabel()
    var tissue = UIButton()
    var wifi = UIButton()
    var washer = UIButton()
    var addressLabel = UILabel()
    var cityText: UITextField! = UITextField()
    var cityArrow = UIButton()
    var addressText: UITextField! = UITextField()
    var toiletPhotoLabel = UILabel()
    var toiletPhotoImageBtn: UIButton! = UIButton()
    var submitBt = UIButton()
    
    var tissueImage = UIImage(named: "tissue2.png")
    var wifiImage = UIImage(named: "wifi2.png")
    var washerImage = UIImage(named: "washer1.png")

    
    var m_toiletPhotoUrl: String!                               //厕主厕所图像
    var m_address: String!                                      //厕所地址
    var m_provision: NSMutableArray! = NSMutableArray()         //厕所配置
    var m_toiletType: String!                                   //厕所类型

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.whiteColor()
        
        initRegiterVC()
        createOSSClient()
        createTapGesture()
        readProvinceCityInfo()

    }
    
    //MARK: ---读取沙盒中的文件ProvincesAndCities.plist----
    func readProvinceCityInfo()
    {
        
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
        let documentsDirectory = paths[0] as String
        let path = documentsDirectory.stringByAppendingPathComponent("ProvincesAndCities.plist")
        let fileManager = NSFileManager.defaultManager()
        
        // ---判断沙盒中是否存在该文件----
        if(!fileManager.fileExistsAtPath(path)) {
            // If it doesn't, copy it from the default file in the Bundle
            if let bundlePath = NSBundle.mainBundle().pathForResource("ProvincesAndCities", ofType: "plist") {
                let resultDictionary = NSMutableDictionary(contentsOfFile: bundlePath)
                println("Bundle ProvincesAndCities.plist file is --> \(resultDictionary?.description)")
                fileManager.copyItemAtPath(bundlePath, toPath: path, error: nil)
                println("copy")
            } else {
                println("ProvincesAndCities.plist not found. Please, make sure it is part of the bundle.")
            }
        } else {
            println("ProvincesAndCities.plist already exits at path.")

        }
        let resultArray = NSMutableArray(contentsOfFile: path)
        //println("ProvincesAndCities.plist file is --> \(resultArray?.description)")

        location = resultArray
        //print(path)
    }
    
    func  initRegiterVC(){
        
        didLabel.text = "已提交过厕所信息的请直接进入"
        didLabel.frame = CGRect(x: 20, y: 75, width: 280, height: 25)
        didLabel.backgroundColor = UIColor.whiteColor()
        didLabel.textColor = UIColor.grayColor()
        didLabel.font = UIFont.systemFontOfSize(17)
        self.view.addSubview(didLabel)
        
        var arrowImage = UIImage(named: "arrow.png")
        arrow.frame = CGRect(x: 285, y: 80, width: 15, height: 15)
        arrow.setImage(arrowImage, forState: UIControlState.Normal)
        arrow.addTarget(self, action: "changeToCodeTest", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(arrow)
        
        var line = UILabel()
        line.frame = CGRect(x: 0, y: 110, width: 320, height: 0.5)
        line.backgroundColor = UIColor.grayColor()
        self.view.addSubview(line)
        
        toiletTypeLabel.text = "厕所类型"
        toiletTypeLabel.frame = CGRect(x: 20, y: 130, width: 120, height: 25)
        toiletTypeLabel.backgroundColor = UIColor.whiteColor()
        toiletTypeLabel.textColor = UIColor.grayColor()
        toiletTypeLabel.font = UIFont.systemFontOfSize(17)
        self.view.addSubview(toiletTypeLabel)
        
        var sitToiletImage = UIImage(named: "sitToilet2.png")
        sitToilet.frame = CGRect(x: 30, y: 170, width: 116, height: 32)
        sitToilet.setImage(sitToiletImage, forState: UIControlState.Normal)
        sitToilet.addTarget(self, action: "changeToiletType:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(sitToilet)
        
        var crouchToiletImage = UIImage(named: "crouchToliet1.png")
        crouchToilet.frame = CGRect(x: 175, y: 170, width: 116, height: 32)
        crouchToilet.setImage(crouchToiletImage, forState: UIControlState.Normal)
        crouchToilet.addTarget(self, action: "changeToiletType:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(crouchToilet)
        
        providersLabel.text = "周边配置"
        providersLabel.frame = CGRect(x: 20, y: 225, width: 120, height: 25)
        providersLabel.backgroundColor = UIColor.whiteColor()
        providersLabel.textColor = UIColor.grayColor()
        providersLabel.font = UIFont.systemFontOfSize(17)
        self.view.addSubview(providersLabel)
        

        tissue.frame = CGRect(x: 25, y: 260, width: 75, height: 32)
        tissue.setImage(tissueImage, forState: UIControlState.Normal)
        tissue.addTarget(self, action: "changeStatus:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(tissue)

        wifi.frame = CGRect(x: 124, y: 260, width: 75, height: 32)
        wifi.setImage(wifiImage, forState: UIControlState.Normal)
        wifi.addTarget(self, action: "changeStatus:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(wifi)
        

        washer.frame = CGRect(x: 223, y: 260, width: 75, height: 32)
        washer.setImage(washerImage, forState: UIControlState.Normal)
        washer.addTarget(self, action: "changeStatus:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(washer)
        
        addressLabel.text = "厕所地址"
        addressLabel.frame = CGRect(x: 20, y: 325, width: 120, height: 25)
        addressLabel.backgroundColor = UIColor.whiteColor()
        addressLabel.textColor = UIColor.grayColor()
        addressLabel.font = UIFont.systemFontOfSize(17)
        self.view.addSubview(addressLabel)
        
        
        cityText.frame = CGRectMake(100, 325, 160, 30)
        cityText.placeholder = "选择城市"
        cityText.keyboardType = UIKeyboardType.NumberPad
        cityText.clearButtonMode = UITextFieldViewMode.WhileEditing
        cityText.borderStyle = UITextBorderStyle.RoundedRect
        cityText.delegate = self
        self.view.addSubview(cityText)
        cityArrow.frame = CGRect(x: 240, y: 335, width: 10, height: 10)
        cityArrow.setImage(arrowImage, forState: UIControlState.Normal)
        cityArrow.addTarget(self, action: "changeToProvince", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(cityArrow)
        
        
        addressText.frame = CGRectMake(100, 360, 200, 30)
        addressText.placeholder = "请补充详细地址"
        addressText.keyboardType = UIKeyboardType.Default
        addressText.clearButtonMode = UITextFieldViewMode.WhileEditing
        addressText.borderStyle = UITextBorderStyle.RoundedRect
        addressText.delegate = self
        self.view.addSubview(addressText)
        
        
        toiletPhotoLabel.text = "厕所照片"
        toiletPhotoLabel.frame = CGRect(x: 20, y: 400, width: 120, height: 25)
        toiletPhotoLabel.backgroundColor = UIColor.whiteColor()
        toiletPhotoLabel.textColor = UIColor.grayColor()
        toiletPhotoLabel.font = UIFont.systemFontOfSize(17)
        self.view.addSubview(toiletPhotoLabel)
        
        toiletPhotoImageBtn.frame = CGRectMake(100, 410, 100, 80)
        //toiletPhotoImageBtn.backgroundColor = UIColor(white: 0.8, alpha: 1)
        
        var defaultImage:UIImage! = UIImage(named: "toiletPhoto.png")
        toiletPhotoImageBtn.setImage(defaultImage,
            forState: UIControlState.Normal)
        toiletPhotoImageBtn.addTarget(self,
            action: "changePhotoBtnPress:",
            forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(toiletPhotoImageBtn)
        
        var submitImage = UIImage(named: "submit.png")
        submitBt.frame = CGRect(x: 30, y: 510, width: 260, height: 40)
        submitBt.setImage(submitImage, forState: UIControlState.Normal)
        submitBt.addTarget(self, action: "registerBtnPress:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(submitBt)

    }
    
    func changeToiletType(sender:UIButton){
        
        switch sender{
        case sitToilet:
            sitToilet.setImage(UIImage(named: "sitToilet1.png"), forState: UIControlState.Normal)
            crouchToilet.setImage(UIImage(named: "crouchToliet1.png"), forState: UIControlState.Normal)
            m_toiletType = "豪华坐便器"
        case crouchToilet:
            sitToilet.setImage(UIImage(named: "sitToilet2.png"), forState: UIControlState.Normal)
            crouchToilet.setImage(UIImage(named: "crouchToliet2.png"), forState: UIControlState.Normal)
            m_toiletType = "经济蹲坑"
        default:
            sender.setImage(UIImage(named: "sitToilet1.png"), forState: UIControlState.Normal)
            
        }
    }
    
    func changeStatus(sender:UIButton){
        
        switch sender{
        case tissue:
            if tissue.imageView?.image == tissueImage
            {tissue.setImage(UIImage(named: "tissue1.png"), forState: UIControlState.Normal)
             //m_provision[0]="手纸"
              m_provision.addObject("手纸")
            }
            else
            {tissue.setImage(UIImage(named: "tissue2.png"), forState: UIControlState.Normal)}
        case wifi:
            if wifi.imageView?.image == wifiImage
            {  wifi.setImage(UIImage(named: "wifi1.png"), forState: UIControlState.Normal)
                var alert = UIAlertView()
                alert.title = "alert"
                alert.delegate = self
                alert.addButtonWithTitle("知道了")
                alert.message = "请记得在厕所贴上wifi名和密码哦"
                alert.show()
                m_provision.addObject("wifi")
            }
            else
            {   wifi.setImage(UIImage(named: "wifi2.png"), forState: UIControlState.Normal)
                
            }
        case washer:
            if washer.imageView?.image == washerImage
            {washer.setImage(UIImage(named: "washer2.png"), forState: UIControlState.Normal)
                m_provision.addObject("洗手台")
            }
            else
            {washer.setImage(UIImage(named: "washer1.png"), forState: UIControlState.Normal)}
        default:
            tissue.setImage(UIImage(named: "tissue2.png"), forState: UIControlState.Normal)
        }
    
    }
    
    
    //MARK: - UITextFieldDelegate
    
    //-------------------------------------------------
    //文本框已经开始进入编辑状态时的委托方法
    //-------------------------------------------------
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        println(__FUNCTION__, __LINE__)
        var fDistance = self.view.frame.height - (textField.frame.origin.y + textField.frame.size.height) - 216.0
        
        if fDistance < 0.0 {
            
            UIView.animateWithDuration(0.2,
                delay: 0.0,
                options: .CurveEaseOut,
                animations:{
                    
                    var frame: CGRect! = self.view.frame
                    frame.origin.y = fDistance
                    self.view.frame = frame
                },
                completion:{
                    
                    finished in
                    println("view up !")
                }
            )
            
        }
        //return true
    }
 
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        //禁止输入字数过多
        if (addressText.text.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 240 )
        {
            var alert = UIAlertView(title: "温馨提示: ",
                message: "地址输入长度最高控制在40字！",
                delegate: self,
                cancelButtonTitle: "确定")
            alert.show()
            
            return false
            
        }

        //按下回车后取消键盘
        if (string == "\n") {
            addressText.resignFirstResponder()
            return false
        }

        return true
    }
    
    
    //-------------------------------------------------
    //文本框已经结束编辑状态时的委托方法
    //-------------------------------------------------
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        NSLog("%@: %d", __FUNCTION__, __LINE__)

        UIView.animateWithDuration(0.2,
            delay: 0.0,
            options: .CurveEaseOut,
            animations:{
                
                var frame: CGRect! = self.view.frame
                frame.origin.y = 0
                self.view.frame = frame
            },
            completion:{
                
                finished in
                println("view down !")
            }
        )
        
        if (addressText.text.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 240 )
        {
            var alert = UIAlertView(title: "温馨提示: ",
                message: "地址输入长度最高控制在40字！",
                delegate: self,
                cancelButtonTitle: "确定")
            alert.show()
            
            var s = addressText.text
            addressText.text = s[0...240]

        }
        
    }
    
    
    //MARK: - UITapGestureRecognizer
    
    //-------------------------------------------------
    //添加单击手势识别器，给当前视图
    //-------------------------------------------------
    
    var m_tapGes: UITapGestureRecognizer! = UITapGestureRecognizer()
    
    func createTapGesture() {
        
        println(__FUNCTION__, __LINE__)
        
        m_tapGes.addTarget(self, action: "tapGesture:")
        self.view.addGestureRecognizer(m_tapGes)
    }
    
    //-------------------------------------------------
    //单击当前视图时，关闭键盘
    //-------------------------------------------------
    func tapGesture(tapGes: UITapGestureRecognizer) {
        println(__FUNCTION__, __LINE__)
        
        cityText.resignFirstResponder()
        addressText.resignFirstResponder()
    }
    
    //MARK: - 按扭响应方法
    
    //-------------------------------------------------
    //修改厕所照片
    //-------------------------------------------------
    func changePhotoBtnPress(sender: UIButton) {
        NSLog("%@: %d", __FUNCTION__, __LINE__);
        
        //1.创建动作列表
        let actionSheet = UIActionSheet(
            title: "厕所照片",
            delegate: self,
            cancelButtonTitle: "取消",
            destructiveButtonTitle: "拍照",
            otherButtonTitles: "从相册中选择")
        //2.设置
        actionSheet.delegate = self
        //3.显示
        actionSheet.showInView(self.view)
    }
    
    //-------------------------------------------------
    // UIActionSheetDelegate 委托方法
    //-------------------------------------------------
    func actionSheet(actionSheet: UIActionSheet!, clickedButtonAtIndex buttonIndex: Int)
    {
        switch buttonIndex
        {
        case 0: //拍照
            NSLog("Camera")
            //拍照
            var picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .Camera //= UIImagePickerControllerSourceTypeCamera;
            self.presentViewController(picker, animated: true, completion: nil)
            break;
        case 1: //取消
            NSLog("Cancel")
            break;
        case 2: //相册
            NSLog("SelectAlbum")
            var picker = UIImagePickerController()
            picker.delegate = self;
            picker.sourceType = .SavedPhotosAlbum; //UIImagePickerControllerSourceTypeSavedPhotosAlbum
            self.presentViewController(picker, animated: true, completion: nil)
            break;
            
        default:
            NSLog("Default")
            break;
        }
    }
    
    // MARK: - UIImagePickerControllerDelegate 委托方法
    //-------------------------------------------------
    //相册选图或相机拍照完成后，调用的委托方法
    //-------------------------------------------------
    var toiletPhotoImage: UIImage! = UIImage()
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject])
    {
        println(__FUNCTION__, __LINE__)
        
        var tempImage:UIImage = info[UIImagePickerControllerOriginalImage] as UIImage
        toiletPhotoImage = tempImage
        toiletPhotoImageBtn.setImage(toiletPhotoImage, forState: UIControlState.Normal)
        
        picker.dismissViewControllerAnimated(true, completion: nil)
        
        //保存用户头像到文件夹Documents中
        savePhoto()
        
        updateloadImage(toiletPhotoImage)
    }
    
    //MARK:----保存用户头像到文件夹Documents中----
    func savePhoto(){
        //1.查找本app沙盒中的Documents路径
        //区别:
        //文件夹Documents, 参数: NSSearchPathDirectory.DocumentDirectory
        //                区别: NSSearchPathDirectory.DocumentationDirectory
        var pathArr: NSArray! = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory,
            NSSearchPathDomainMask.UserDomainMask,
            true)
        var filePath: String! = pathArr.objectAtIndex(0) as String
        
        println("filePath: \(filePath)")
        
        //2.添加待写入图像的文件名与后缀
        filePath = filePath + "/userPhotoImage.png"
        println("filePath: \(filePath)")
        
        //3.判断是否存在同名文件
        //若存在，则先删除.
        var bFileExist: Bool = NSFileManager.defaultManager().fileExistsAtPath(filePath)
        
        if bFileExist {
            
            var bFileDeleted: Bool = NSFileManager.defaultManager().removeItemAtPath(filePath, error: nil)
            
            if bFileDeleted {

                println("delete success !")
            } else {
                println("delete error !")
                return
            }
        }
        
        //4.保存文件的名称
        UIImagePNGRepresentation(toiletPhotoImage).writeToFile(filePath, atomically: true)
        
        //5.保存路径到用户信息单例类对象中
        var lord: LordInfomation! = LordInfomation.shareInstance()
        lord.m_toiletPhotoUrl = filePath
        self.m_toiletPhotoUrl = filePath
    
    }

    func createOSSClient(){
    
        var ossclient =  OSSClient.sharedInstanceManage()
        
        var accessKey =  "zwfTw8BrXxIXzBb0"
        
        var secretKey =  "HrvqQQaYiAYk0LzFjYWaC1eVplFwz5"
        
//        ossclient.generateToken(
//        (NSString(), NSString(), NSString(), NSString(), NSString(), NSString()) in
//        {   var signature = "test"
//            var content =  NSString(format:"%@\n%@\n%@\n%@\n%@%", method, md5, type, date, xoss, resource)
//            signature = OSSTool(data:content,withKey:secretKey)
//            signature = NSString(format:"OSS %@:%", accessKey, signature)
//            return signature
//        })
        ossclient.globalDefaultBucketHostId = "oss-cn-beijing.aliyuncs.com"
        ossclient.globalDefaultBucketAcl.value = 1
        
//        accessKey = ""
//        secretKey = ""
    
    
    }
    
    
    //MARK: --- 保存用户头像到阿里云上面 ---
    func updateloadImage(image:UIImage)
    {
        

//        var imageData =  UIImageJPEGRepresentation(image, 1)
//        if (imageData.length >= 50000)
//        {
//            imageData = UIImageJPEGRepresentation(image, 0.1)
//        }
        
        
        var bucket =  OSSBucket(bucket:"ddlsimage")
        
        
        bucket.acl.value = 1       // 指明该Bucket的访问权限
        bucket.ossHostId = "oss-cn-beijing.aliyuncs.com" // 指明该Bucket所在数据中心的域名
        
//        var uuid = NSUUID() as NSString
//          uuid.stringByReplacingOccurrencesOfString:"-",withString:""
//      var uuid =  [[NSUUID.UUID() UUIDString],stringByReplacingOccurrencesOfString:"-",withString:""
//        
//        var imageName =  NSString(format:"%@.%",uuid,imagetype)
        
//        
//        var testFile =  OSSData(bucket:bucket, withKey:image.description)
//        
////        uuid = nil
//        
//        
//        testFile.setData(imageData, withType:imagetype)
//        
//        imageName = nil
//        
//        println("%@",testFile.getResourceURL())
//        testFile.uploadWithUploadCallback(isSuccess:Bool, error:NSError)
//            {
//                _picker.dismissViewController(animated:true,completion:nil)
//                
//                
//                if (isSuccess) {
//                    
//                    
//                    self.uploadWithcompleteBack(testFile.getResourceURL())
//                    
//                    println("%@",testFile.getResourceURL())
//                    
//                } else {
//                    self.uploadWithErrorBack(error)
//                    println("errorInfo_testFilePartsUpload:%@", error.userInfo())
//                }
//            }
//                
//        }
    }

    
    /*
    *上传成功回调接口
    */
    func uploadWithcompleteBack(url: NSString)
    {
        
        
    }
    
    /*
    *上传出错回调接口
    */
    func uploadWithErrorBack(error: NSError)
    {
        
        
    }

    
    
    
    func changeToProvince(){
     
        var m_ProvinceTableVC = ProvinceTableViewController()
        m_ProvinceTableVC.title = "选择省份"
        m_ProvinceTableVC.registerViewController = self
        m_ProvinceTableVC.location = self.location
        self.navigationController?.pushViewController(m_ProvinceTableVC, animated: true)
    
    }
    
    
    func changeToCodeTest(){
        
        var m_CodeTestVC = CodeTestViewController()
        m_CodeTestVC.title = "手机验证"
        self.navigationController?.pushViewController(m_CodeTestVC, animated: true)
    
    
    }
   
    // MARK: - 注册按钮
    
    //-------------------------------------------------
    //注册功能：注册按钮对应的方法
    //-------------------------------------------------
    var m_isRegisterSuccess: Bool =  true
    
    func registerBtnPress(sender: UIButton){
        
        println(__FUNCTION__, __LINE__)
        
        //判断用户是否输入各个字段
        if isInputNotEmpty() {

            //联网
            
            //获取头像文件路径，从用户信息单例类对象中
     //       var user: LoginUser! = LoginUser.shareInstance()
//            println("user.m_photoUrl = \(user.m_photoUrl)")
//            
//            if nil == user.m_photoUrl || user.m_photoUrl.isEmpty {
//                
//                //注册方法1: 不上传用户头像的版本
//                registerRequestURL()
//            } else {
//                
//                //注册方法2: 上传用户头像的版本
//                registerRequestURLV2()
//            }
//            
            //若注册成功，则切换到手机验证界面
            if m_isRegisterSuccess {
                
                changeToCodeTest()
            }
        }
        else {
            
            //用户输入的数据有空值
        }
    }
    //-------------------------------------------------
    //判断用户是否输入各个字段
    //-------------------------------------------------
    
    func isInputNotEmpty() -> Bool {
        
        //保存用户输入的数据到用户信息单例中
        var lord: LordInfomation! = LordInfomation.shareInstance()
        
        
       if m_toiletType == nil
       {
       
          var alert = UIAlertView(title: "温馨提示: ",
            message: "请选择厕所类型！",
            delegate: self,
            cancelButtonTitle: "确定")
        alert.show()
        
        return false
       
       
       }
        else {
            
            lord.m_id = "0"
            lord.m_toiletType = m_toiletType
            lord.m_provision = m_provision
        
            //---begin-added-by-MaoYingyong-2014-12-6---
            //lord.m_photoUrl = ""
            //---end---added-by-MaoYingyong-2014-12-6---
            
           // return true
        }
        
        if  cityText.text.isEmpty || addressText.text.isEmpty
        {
            //某些字段未空, 用户未输入
            var alert = UIAlertView(title: "温馨提示: ",
                message: "请填写厕所地址！",
                delegate: self,
                cancelButtonTitle: "确定")
            alert.show()
            
            return false
        }
        else{
            
            lord.m_address = cityText.text + addressText.text
           // return true
        }
        
        if m_toiletPhotoUrl == nil
        {
            var alert = UIAlertView(title: "温馨提示: ",
                message: "请填写厕所照片！",
                delegate: self,
                cancelButtonTitle: "确定")
            alert.show()
            
            return false
        
        }
        else{
            
            lord.m_toiletPhotoUrl = m_toiletPhotoUrl
            return true
        }

    }
    
    
}


