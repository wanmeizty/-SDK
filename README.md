# iOS SDK 集成文档

## 集成

一、导入SDK：

首先把下载好的SDK包导入到项目中

还需要在xcode配置如下：
1.设置Bitcode
在TARGETS  >iBuild Setting > Build Options > Enable Bitcode 设置为NO

2.添加微信和拼多多白名单
在info.plist中,增加LSApplicationQueriesSchemes字段,并添加pinduoduo,wechat,weixin


## 基本使用

使用 DTSDKWebView 就像使用普通的 WebView 控件一样简单。
```

DTSDKWebView * webView = [[DTSDKWebView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
webView.sdkdelegate = self;
[self.view addSubview:webView];


DTSDKJsApi * api = [[DTSDKJsApi alloc] init];
[api showSDKtitle:NO]; 
[api interceptSDKHomePageUrl:YES]; 
[webView addJavascriptApi:api namespace:@""];
[webView setDebugMode:true];

NSString *urlStr = @"https://ec-h5-test.thefifthera.com/?debug=true#/";
[webView loadUrl:urlStr];



根据情况实现代理方法如下
// token失效代理方法，通过此方法可以重新授权
-(void)tokenFailed:(NSDictionary *)args{

}

// 拦截Url调用代理方法，
-(void)interceptHomePageUrl:(NSString *)url{

    NewWebViewController * webvc = [[NewWebViewController alloc] init];
    webvc.url = url;
    [self.navigationController pushViewController:webvc animated:YES];
}

// 分享图片代理，SDK会传递合成的分享图片和分享类型
-(void)shareImage:(UIImage *)shareImage shareType:(SDKShareType)shareType{
    // 返回合成图片
}

// SDK返回代理，此方法可以调用SDK导航栏返回
- (void)goSDKWebback{
    // 点击了SDK的返回方法
}

```


## 方法说明

**API 方法**

1. 新建一个类，实现API 

```
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
```
可以看到，DTSDKWebView通过API类的方式管理导航栏显示和拦截url。


2. 添加API类实例到 DTSDKWebView 

```
DTSDKJsApi * api = [[DTSDKJsApi alloc] init];
[api showSDKtitle:YES]; // 导航栏显示
[api interceptSDKHomePageUrl:NO]; // 不拦截url
[webView addJavascriptObject:api namespace:nil];
```

3. DTSDKWebView原生调用.

- 初始化 DTSDKWebView
```
DTSDKWebView * webView = [[DTSDKWebView alloc] initWithFrame:self.view.bounds];
[self.view addSubview:webView];
```

- 加载url
```
NSString *urlStr = @"https://www.";
[webView loadUrl:urlStr];
```

- 设置调试模式
```
[webView setDebugMode:true];
```

- 添加API到DTSDKWebView
```
[webView addJavascriptObject:api namespace:nil];
```

- 移除命名空间
```
[webView removeJavascriptObject:@“namespace”];
```


- 刷新页面
```
[webView refreshSDKWeb];
```

- 设置代理
```
webView.sdkdelegate = self;
```

4. SDKDelegate代理

- token失效调用
```
/**
* token失效 通过此方法可以重新授权
* @param args 返回的失效信息
**/
- (void)tokenFailed:(NSDictionary *)args{
// 重新授权
}
```


- 合成分享图片，根据类型作相应的分享
```
// 分享图片代理，SDK会传递合成的分享图片和分享类型
-(void)shareImage:(UIImage *)shareImage shareType:(SDKShareType)shareType{
// 分享图片
}
```

- SDK导航栏返回
```
-(void)goSDKWebback{
// 调用SDK的返回
[self.navigationController popViewControllerAnimated:YES];
}
```

- 拦截URL代理
```
-(void)interceptHomePageUrl:(NSString *)url{
// 拦截url后，根据返回的url跳转自定义任意页面
NewWebViewController * webvc = [[NewWebViewController alloc] init];
webvc.url = url;
[self.navigationController pushViewController:webvc animated:YES];
}
```

**错误信息**

/**
* token失效 通过此方法可以重新加载授权URL
* @param args 返回的失效信息
**/
- (void)tokenFailed:(NSDictionary *)args{
    // 重新授权
    
}


## Demo下载

https://github.com/wanmeizty/-SDK.git
