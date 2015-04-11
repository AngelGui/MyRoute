////
////  UploadImageViewController.swift
////  MyRoute
////
////  Created by 陈桂 on 15/4/8.
////  Copyright (c) 2015年 AutoNavi. All rights reserved.
////
//
//import Foundation
//
//
//class UploadImageViewController: UIViewController, UIAlertViewDelegate,UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate
//{
//
//    var _picker:UIImagePickerController!
//    
//    override  func viewDidLoad()
//    {
//        
//        super.viewDidLoad()
//        
//        
//        var ossclient =  OSSClient.sharedInstanceManage()
//        
//        var accessKey =  "zwfTw8BrXxIXzBb0"
//        
//        var secretKey =  "HrvqQQaYiAYk0LzFjYWaC1eVplFwz5"
//        
//        
//        ossclient.generateToken(NSString(), NSString(), NSString(), NSString(), NSString(), NSString())
//
//        {
//            var signature = "test"
//            var content =  NSString(format:"%@\n%@\n%@\n%@\n%@%", method, md5, type, date, xoss, resource)
//            signature = OSSTool(data:content,withKey:secretKey)
//            signature = NSString(format:"OSS %@:%", accessKey, signature)
//            println("here signature:%@", signature)
//            return signature
//        }
//        
//        ossclient.globalDefaultBucketHostId = "oss-cn-beijing.aliyuncs.com"
//        ossclient.globalDefaultBucketAcl.value = 1
//
//        accessKey = ""
//        secretKey = ""
//    }
//    
//    override func didReceiveMemoryWarning()
//    {
//        
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//
//    func showSelectImageMenus()
//    {
//        
//        var actionSheet = UIActionSheet(
//            title: "厕所照片",
//            delegate: self,
//            cancelButtonTitle: "取消",
//            destructiveButtonTitle: "拍照",
//            otherButtonTitles: "从相册中选择")
//        
//        actionSheet.showInView( self.view)
//        
//    }
//    
//    //将图片的二进制转换成String类型
//    func stringWithImage(image: UIImage)->NSString
//    {
//    
//        var imageData =  UIImageJPEGRepresentation(image, 1)
//        if (imageData.length >= 50000)
//        {
//            imageData = UIImageJPEGRepresentation(image, 0.1)
//        }
//        
//        var testByte = imageData.bytes
//        
//        var str = NSMutableString()
//        for i in 0...imageData.length
//        {
//              str.appendFormat("%d,",testByte[i])
//        }
//        
//        var range:NSRange!
//        range.location = str.length-1
//        range.length = 1
//        str.deleteCharactersInRange(range)
//        
//        
//        return str
//    }
//    
//    func updateloadImage(image:UIImage, imagetype:NSString)
//    {
//    
//    
//        var imageData =  UIImageJPEGRepresentation(image, 1)
//        if (imageData.length >= 50000)
//        {
//            imageData = UIImageJPEGRepresentation(image, 0.1)
//        }
//    
//    
//        var bucket =  OSSBucket(bucket:"ddlsimage")
//    
//        
//        bucket.acl.value = 1       // 指明该Bucket的访问权限
//        bucket.ossHostId = "oss-cn-beijing.aliyuncs.com" // 指明该Bucket所在数据中心的域名
//        
//        var uuid = NSUUID() as NSString
//        uuid.stringByReplacingOccurrencesOfString:"-",withString:""
//        var uuid =  [[NSUUID.UUID() UUIDString],stringByReplacingOccurrencesOfString:"-",withString:""
//        
//        var imageName =  NSString(format:"%@.%",uuid,imagetype)
//        
//        
//        
//        var testFile =  OSSData(bucket:bucket, withKey:imageName)
//        
//        uuid = nil
//    
//        testFile.setData(imageData, withType:imagetype)
//        
//        self.prepareUploadImages(imageData, imageName:imageName)
//        
//        imageName = nil
//        
//        println("%@",testFile.getResourceURL())
//        testFile.uploadWithUploadCallback(isSuccess:Bool, error:NSError)
//            {
//                _picker.dismissViewController(animated:true,completion:nil)
//    
//    
//            if (isSuccess) {
//                
//            self(completeBack:testFile.getResourceURL)()
//            
//            println("%@",testFile.getResourceURL())
//                
//            } else {
//            self(errorBack:error)
//            println("errorInfo_testFilePartsUpload:%@", error.userInfo())
//            }
//        } .withProgressCallback(progress:CGFloat) {
//            
//                println(__FUNCTION__,__LINE__)
//        
//      }
//}
//
///*
//*开始上传前的
//*/
//func prepareUploadImages(imageData:NSData, imageName:NSString)
//{
//    
//    
//}
//
///*
//*上传成功回调接口
//*/
//    func uploadWithcompleteBack(url: NSString)
//{
//    
//    
//}
//
///*
//*上传出错回调接口
//*/
//    func uploadWithErrorBack(error: NSError)
//{
//    
//    
//}
//
////MARK: --- UIActionSheetDelegate ---
//func actionSheet(actionSheet:UIActionSheet, buttonIndex:Int)
//{
//    
//    if (buttonIndex == 0)       // 拍照
//    {
//        var type = UIImagePickerControllerSourceType.Camera
//        _picker = UIImagePickerController()
//        _picker.delegate = self
//        _picker.allowsEditing = true // 设置可编辑
//        _picker.sourceType = type
//        self.presentViewController(_picker,animated:true,completion:nil)
//        
//        
//    }
//    else if (buttonIndex == 1)  // 从相册选择
//    {
//        _picker = UIImagePickerController()
//        
//        if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary))
//        {
//            _picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
//            _picker.mediaTypes = UIImagePickerController.availableMediaTypesForSourceType( _picker.sourceType)!
//            
//        }
//        _picker.delegate = self
//        _picker.allowsEditing = true
//        self.presentViewController(_picker,animated:true,completion:nil)
//        
//        
//    }
//    else if (buttonIndex == 2)  // 取消
//    {
//        
//    }
//}
//
////MARK: ---UIImagePickerControllerDelegate---
//    
//    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: NSDictionary)
//    {
//        println(__FUNCTION__, __LINE__)
//        
//        
//        var medicType: AnyObject? =  info.objectForKey(UIImagePickerControllerMediaType)
//        
//        //判断选中的是不是图片
//        if (medicType?.isEqualToString(kUTTypeImage) == true)
//        {
//                //得到选中的图片
//            var image: AnyObject? = info.objectForKey(UIImagePickerControllerEditedImage)
//            
//            self.updateloadImage(image, imagetype: ".jpg")
//                image = nil
//            
//                
//        }
//        
//        LoadingClass.shared().showContent("请稍等", andCustomImage:nil)
//        
//    }
//    
//    
//    func imagePickerControllerDidCancel(picker:UIImagePickerController)
//    {
//        
//        println("imagePickerControllerDidCancel")
//        picker.dismissViewControllerAnimated(true,completion:nil)
//        
//        
//    }
//    
//    func updateload()
//    {
//        
//        
//        
//    }
//    
//    //MARK: --- BsaeViewController ---
////    func startRequestDataWithPostValue(postValue:NSDictionary, url:NSString)
////    {
////        
////        BFNetManager.sharedManager()
////        doPostWithPath:url params:postValue callback(isSuccessed:BOOL, id result) {
////            
////            if(isSuccessed && result){
////                
////                var tempDic:NSDictionary = result
////                switch (tempDic.objectForKey("code").intValue)
////                {
////                case RetCode_Success:
////                    {
////                        if(url.isEqualToString(RequestName_UploadUserHead))
////                        {
////                            println("头像修改成功")
////                            self(postValue:[Users.sharedInstance) getTokenAndUserId() andUrl:RequestName_GetUserInfoByID]
////                                
////                                _picker.dismissViewController(animated:true,completion:nil)
////                            
////                        }
////                    }
////                    break
////                case RetCode_NotLogin:
////                    {
////                        if(url.isEqualToString(RequestName_UploadUserHead)
////                        {
////                        _picker.dismissViewController(animated:true,completion:nil)
////                        
////                        }
////                        LoadingClass.shared().showContent(tempDic.objectForKey("msg"),andCustomImage:nil)
////                        Users.sharedInstance().logout
////                    }
////                    break
////                default:
////                    if(url.isEqualToString(RequestName_UploadUserHead))
////                    {
////                        _picker.dismissViewController(animated:true,completion:nil)
////                        
////                    }
////                    LoadingClass.shared().showContent(tempDic.objectForKey("msg"),andCustomImage:nil)
////                    break
////                }
////            }else {
////                if(url.isEqualToString(RequestName_UploadUserHead)){
////                    _picker.dismissViewController(animated:true,completion:nil)
////                    
////                }
////                println("url%@ error%@,",url,result)
////            }
////        }
////    }
//}