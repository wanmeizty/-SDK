//
//  NewWebViewController.m
//  DTDemo
//
//  Created by wanmeizty on 8/3/19.
//  Copyright © 2019年 wanmeizty. All rights reserved.
//

#import "NewWebViewController.h"
#import "DTSDKWebView.h"
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
@interface NewWebViewController ()<SDKDelegate>

@property (strong,nonatomic) DTSDKWebView * dwebview;
@property (strong,nonatomic) UIImageView * imgView;
@end

@implementation NewWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"web页";
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    DTSDKWebView * webView = [[DTSDKWebView alloc] initWithFrame:self.view.bounds];

    webView.sdkdelegate = self;
    [self.view addSubview:webView];
    
    
    DTSDKJsApi * api = [[DTSDKJsApi alloc] init];
    [api interceptSDKHomePageUrl:NO];
    [api showSDKtitle:YES];
    
    [webView addJavascriptApi:api namespace:@""];
    [webView setDebugMode:true];
    
    NSString *urlStr = self.url; //@"https://ec-h5-test.thefifthera.com/?debug=true#/";
    NSMutableURLRequest *dealRequest =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:15.0];
    [webView loadRequest:dealRequest];
    
    self.dwebview = webView;
    
    self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height )];
    self.imgView.backgroundColor = [UIColor yellowColor];
    self.imgView.hidden = YES;
    self.imgView.userInteractionEnabled = YES;
    [self.view addSubview:self.imgView];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddeView)];
    [self.imgView addGestureRecognizer:tap];
    // Do any additional setup after loading the view.
}

- (void)hiddeView{
    self.imgView.hidden = YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}

// 分享图片代理，SDK会传递合成的分享图片和分享类型
-(void)shareImage:(UIImage *)shareImage shareType:(SDKShareType)shareType{
    self.imgView.hidden = NO;
    self.imgView.image = shareImage;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.navigationController.navigationBar setHidden:NO];
}

-(void)goSDKWebback{
    if ([self.dwebview canGoBack]) {
        [self.dwebview goBack];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
