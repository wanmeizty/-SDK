//
//  DTSDKWebView.h
//  DTSDK
//
//  Created by wanmeizty on 6/3/19.
//  Copyright © 2019年 wanmeizty. All rights reserved.
//

#import <WebKit/WebKit.h>

/**分享类型**/
typedef NS_ENUM(NSInteger, SDKShareType) {
    SDKShareWechatType= 0, //微信
    SDKShareWechatMomentType,  //朋友圈
};

NS_ASSUME_NONNULL_BEGIN

@protocol SDKDelegate <NSObject>

/**
 * token失效 通过此方法可以重新授权
 * @param args 返回的失效信息
 **/
- (void)tokenFailed:(NSDictionary *)args;

/**
 * 合成分享图片
 * @param shareImage 分享图片
 * @param shareType 分享类型 (微信：SDKShareWechatType, 朋友圈：SDKShareWechatMomentType)
 **/
-(void)shareImage:(UIImage *)shareImage shareType:(SDKShareType)shareType;

/**
 * SDKWeb SDK导航栏返回
 **/
-(void)goSDKWebback;

/**
 * 拦截URL
 * @param url 地址
 **/
-(void)interceptHomePageUrl:(NSString *)url;

@end

@interface DTSDKJsApi : NSObject

@property (weak,nonatomic) id<SDKDelegate> delegate;
/**
 * 导航栏显示
 * @param isShowTitle 是否显示SDKWeb导航栏
 * 默认 显示
 **/
-(void)showSDKtitle:(BOOL)isShowTitle;

/**
 * 拦截url
 * @param isInterceptHomePageUrl 是否拦截URL
 * 默认不拦截
 **/
-(void)interceptSDKHomePageUrl:(BOOL)isInterceptHomePageUrl;

@end

@class DTSDKJsApi;
@interface DTSDKWebView : WKWebView

@property (weak,nonatomic) id<SDKDelegate> sdkdelegate;


@property (nullable, nonatomic, weak) id <WKUIDelegate> DSUIDelegate;

/**
 * 加载Url
 * @param url 地址
 **/
- (void)loadUrl: (NSString *)url;

/**
 * refresh SDKWeb
 **/
-(void)refreshSDKWeb;

/**
 * Add a Javascript Object to dsBridge with namespace.
 * @param jsapi
 * which implemented the javascript interfaces
 * @param namespace
 * if empty, the object have no namespace.
 **/
- (void)addJavascriptApi:(DTSDKJsApi *  _Nullable)jsapi namespace:(NSString *  _Nullable) namespace;


// Remove the Javascript Object with the supplied namespace
- (void)removeJavascriptObject:(NSString *  _Nullable) namespace;

// Set debug mode. if in debug mode, some errors will be prompted by a dialog
// and the exception caused by the native handlers will not be captured.
- (void) setDebugMode:(bool) debug;

@end

NS_ASSUME_NONNULL_END
