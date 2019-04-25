//
//  ViewController.m
//  DTDemo
//
//  Created by wanmeizty on 5/3/19.
//  Copyright © 2019年 wanmeizty. All rights reserved.
//

#import "ViewController.h"
#import "DTSDKWebView.h"
#import "NewWebViewController.h"

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface ViewController ()<SDKDelegate>
//@property (strong,nonatomic) DTSDKWebView * webview;
@property (strong,nonatomic) UIImageView * imgView;
//@property (strong,nonatomic) DTSDKJsApi * jsApi;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"首页";
    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [btn setTitle:@"点击" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
    
    [self webViewtest];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)webViewtest{
    
    
    
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
    
    
    
    self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64)];
    self.imgView.backgroundColor = [UIColor yellowColor];
    self.imgView.hidden = YES;
    [self.view addSubview:self.imgView];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
}

-(void)click{
    
}

- ( int)ztytestt:(NSString *)aaa{
    NSLog(@"%@",aaa);
    return 2;
}

- (NSString *)ztytest:(NSString *)name{
    return name;
}

#pragma mark -- delegate
// token失效代理方法，通过此方法可以重新授权
-(void)tokenFailed:(NSDictionary *)args{
    
}

// 拦截调用代理方法，
-(void)interceptHomePageUrl:(NSString *)url{
    NewWebViewController * webvc = [[NewWebViewController alloc] init];
    webvc.url = url;
    [self.navigationController pushViewController:webvc animated:YES];
}

// 分享图片代理，SDK会传递合成的分享图片和分享类型
-(void)shareImage:(UIImage *)shareImage shareType:(SDKShareType)shareType{
    NSLog(@"dddd");
}

// SDK返回代理，此方法可以调用SDK导航栏返回
- (void)goSDKWebback{
    NSLog(@"goSDKWebback");
}

@end
