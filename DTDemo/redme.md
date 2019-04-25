# DTSDKWebView  for  IOS

### 注意事项

需要xcode配置如下：
1.在TARGETS  >iBuild Setting > Build Options > Enable Bitcode 设置为NO
2.添加微信和拼多多白名单


## 示例

请参考工程目录下的 `DTDemo/` 文件夹. 运行并查看示例交互.

如果要在你自己的项目中使用 DTSDKWebView :

## 使用

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

## 命名空间

命名空间可以帮助你更好的管理API，这在API数量多的时候非常实用，比如在混合应用中。支持你通过命名空间将API分类管理，并且命名空间支持多级的，不同级之间只需用'.' 分隔即可。

## 调试模式

在调试模式时，发生一些错误时，将会以弹窗形式提示，并且原生API如果触发异常将不会被自动捕获，因为在调试阶段应该将问题暴露出来。如果调试模式关闭，错误将不会弹窗，并且会自动捕获API触发的异常，防止crash。强烈建议在开发阶段开启调试模式，可以通过如下代码开启调试模式：

```
// open debug mode
[webview setDebugMode:true];
```


# WKUIDelegate

在 `DTSDKWebView ` 中，请使用` DSUIDelegate` 代替 `UIDelegate` , 因为在`DTSDKWebView ` 内部 `UIDelegate`已经设置过了，而 `DSUIDelegate` 正是  `UIDelegate` 的一个代理。


​
​## 最后
​
​如果你喜欢 DTSDKWebView, 欢迎star，以便更多的人知道它, 谢谢 !
​
​

