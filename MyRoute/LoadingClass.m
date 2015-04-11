//
//  LoadingClass.m
//  SharedLoading
//
//  Created by admin on 12-11-12.
//  Copyright (c) 2012年 ChinaSoftware. All rights reserved.
//

#import "LoadingClass.h"

@implementation LoadingClass

static LoadingClass *loadingClass = nil;

+ (LoadingClass *)shared
{
    if (loadingClass == nil)
    {
        loadingClass = [[LoadingClass alloc] init];
    }
    return loadingClass;
}

+ (id)allocWithZone:(NSZone *)zone
{
	@synchronized(self)
	{
		if (loadingClass == nil)
        {
			loadingClass = [super allocWithZone:zone];
			return loadingClass;
		}
	}
	return nil;
}

- (id)init
{
    if ((self = [super init]))
    {
        _window = [[UIApplication sharedApplication].windows objectAtIndex:0];
        _HUD = [[MBProgressHUD alloc] initWithWindow:_window];
    }
    return self;
}

//展示Loading界面，str为展示的字符串
- (void)showLoading:(NSString *)str
{
    if(_HUD)
    {
        [self hideLoading];
    }
    
    //if (_HUD == nil)
    {
        _HUD = [[MBProgressHUD alloc] initWithWindow:_window];
        _HUD.removeFromSuperViewOnHide = YES;
    }
    
    _HUD.labelText = str;
    //_HUD.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.6];
    _HUD.backgroundColor = [UIColor clearColor];
    _HUD.dimBackground = NO;
    
    [_window addSubview:_HUD];
    [_HUD show:YES];
}

- (void)hideLoading
{
    [_HUD hide:YES];
    
    [_HUD removeFromSuperview];
    _HUD = nil;
}


-(void)showLoadingForMoreRequest:(NSString *)str
{
    m_nRequestCount++;
    if (m_nRequestCount > 1) {
        return;
    }
    
    if(_HUD)
    {
        [self hideLoading];
    }
    
    //if (_HUD == nil)
    {
        _HUD = [[MBProgressHUD alloc] initWithWindow:_window];
        _HUD.removeFromSuperViewOnHide = YES;
    }
    
    _HUD.labelText = str;
    //_HUD.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.6];
    _HUD.dimBackground = YES;
    
    [_window addSubview:_HUD];
    [_HUD show:YES];
}


-(void)hideLoadingForMoreRequest
{
    m_nRequestCount--;
    if (m_nRequestCount > 0) {
        return;
    }
    
    [_HUD hide:YES];
    
    [_HUD removeFromSuperview];
    _HUD = nil;
}

-(void)showContent:(NSError *)error
{
    
    // NSString *errorString = [NSString alloc];
    NSString *errorString =[[NSMutableString alloc] init];
    
    NSDictionary *errorDic = error.userInfo;
    
    for (NSString *key in errorDic) {
        
        errorString = [[NSString alloc] initWithFormat:@"%@\n%@:%@",errorString,key, errorDic[key],nil];
    }
    
    errorString = [[NSString alloc] initWithFormat:@"%@,%@", [error localizedDescription],errorString];
    
    NSLog(@"%@",errorString);
    
    [[LoadingClass shared] showContent:@"泪奔~网络不给力啊" andCustomImage:nil];
}

-(void)showContent:(NSString *)str andCustomImage:(NSString *)imgName
{
    _HUD.backgroundColor = [UIColor clearColor];
    
    if(_HUD)
    {
        [self hideLoading];
    }
    if (!_HUD)
    {
        _HUD = [[MBProgressHUD alloc] initWithWindow:_window];
        _HUD.removeFromSuperViewOnHide = YES;
    }
    
    _HUD.labelText = str;
    if(imgName && [imgName length] > 0)
    {
        _HUD.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imgName]];
        _HUD.mode = MBProgressHUDModeCustomView;
    }
    else
    {
        _HUD.mode = MBProgressHUDModeText;
    }
    
    _HUD.userInteractionEnabled = NO;
    
    [_window addSubview:_HUD];
    [_HUD show:YES];
    
    [_HUD hide:YES afterDelay:kHudShowDelay];
}

@end
