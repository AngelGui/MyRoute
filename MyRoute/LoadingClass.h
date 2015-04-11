//
//  LoadingClass.h
//  SharedLoading
//
//  Created by admin on 12-11-12.
//  Copyright (c) 2012年 ChinaSoftware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

#define kHudShowDelay   1

/**
 * hud公用类
 */
@interface LoadingClass : NSObject<MBProgressHUDDelegate>
{
    MBProgressHUD *_HUD;
    UIWindow *_window;
    
    NSInteger m_nRequestCount;
}

+ (LoadingClass *)shared;

/**
 * @brief 展示loading等待(那朵菊花)
 * @param str  展示的文字
 */
- (void)showLoading:(NSString *)str;


/**
 * @brief 展示提示文字，如“操作成功”、“请求失败，请稍后再试”等,可添加自定义图片
 * @param str           文字
 * @param imgName       可展示一张图片
 */
-(void)showContent:(NSError*)str;

/**
 * @brief 展示提示文字，如“操作成功”、“请求失败，请稍后再试”等,可添加自定义图片
 * @param str           文字
 * @param imgName       可展示一张图片
 */
-(void)showContent:(NSString*)str andCustomImage:(NSString *)imgName;

/**
 * 隐藏hud
 */
- (void)hideLoading;

/** 多个请求同时发送，每个请求调用一次
 * @brief 展示loading等待(那朵菊花)
 * @param str  展示的文字
 */
-(void)showLoadingForMoreRequest:(NSString *)str;

/** 当最后一个请求返回时，隐藏
 * 隐藏hud
 */
-(void)hideLoadingForMoreRequest;

@end
