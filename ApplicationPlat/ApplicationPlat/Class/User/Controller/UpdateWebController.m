//
//  UpdateWebController.m
//  ApplicationPlat
//
//  Created by ljxMac on 2020/11/27.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "UpdateWebController.h"
#import <WebKit/WebKit.h>
@interface UpdateWebController ()<WKNavigationDelegate,WKUIDelegate>
@property(nonatomic, strong)WKWebView *webView;
@end

@implementation UpdateWebController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //    [self.navigationController.navigationBar setBackgroundImage:[UIImage coloreImage:[UIColor whiteColor]] forBarMetrics:(UIBarMetricsDefault)];
    self.tabBarController.tabBar.hidden = NO;
    
}

- (void)initNavi
{
    //    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    //    [self.navigationController.navigationBar setShadowImage:nil];
    //    self.navigationController.navigationBar.translucent = YES;
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 40)];
    [btn setImage:[UIImage imageNamed:@"backIcon"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* litem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [btn setTitle:@"     " forState:UIControlStateNormal];
    
    self.navigationItem.leftBarButtonItem = litem;
    

}
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"更新日志";
    [self initNavi];
    
    //创建网页配置对象
     WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
     
     // 创建设置对象
     WKPreferences *preference = [[WKPreferences alloc]init];
     //最小字体大小 当将javaScriptEnabled属性设置为NO时，可以看到明显的效果
     preference.minimumFontSize = 0;
     //设置是否支持javaScript 默认是支持的
     preference.javaScriptEnabled = YES;
     // 在iOS上默认为NO，表示是否允许不经过用户交互由javaScript自动打开窗口
     preference.javaScriptCanOpenWindowsAutomatically = YES;
     config.preferences = preference;
     
     // 是使用h5的视频播放器在线播放, 还是使用原生播放器全屏播放
     config.allowsInlineMediaPlayback = YES;
     //设置视频是否需要用户手动播放  设置为NO则会允许自动播放
    config.mediaTypesRequiringUserActionForPlayback = YES;
     //设置是否允许画中画技术 在特定设备上有效
     config.allowsPictureInPictureMediaPlayback = YES;
     //设置请求的User-Agent信息中应用程序名称 iOS9后可用
     config.applicationNameForUserAgent = @"ChinaDailyForiPad";
     
     //初始化
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) configuration:config];
    // UI代理
    _webView.UIDelegate = self;
    // 导航代理
    _webView.navigationDelegate = self;
    // 是否允许手势左滑返回上一级, 类似导航控制的左滑返回
    _webView.allowsBackForwardNavigationGestures = YES;
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:_urlStr]];
    //                [request addValue:[self readCurrentCookieWithDomain:@"http://www.chinadaily.com.cn"] forHTTPHeaderField:@"Cookie"];
    [_webView loadRequest:request];
    //页面后退
    [_webView goBack];
    //页面前进
    [_webView goForward];
    //刷新当前页面
    [_webView reload];
    [self.view addSubview:_webView];

        
}

/**
    *  web界面中有弹出警告框时调用
    *
    *  @param webView           实现该代理的webview
    *  @param message           警告框中的内容
    *  @param completionHandler 警告框消失调用
    */
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
   UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"HTML的弹出框" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
   [alertController addAction:([UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       completionHandler();
   }])];
   [self presentViewController:alertController animated:YES completion:nil];
}
   // 确认框
   //JavaScript调用confirm方法后回调的方法 confirm是js中的确定框，需要在block中把用户选择的情况传递进去
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
   UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
   [alertController addAction:([UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
       completionHandler(NO);
   }])];
   [alertController addAction:([UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       completionHandler(YES);
   }])];
   [self presentViewController:alertController animated:YES completion:nil];
}
   // 输入框
   //JavaScript调用prompt方法后回调的方法 prompt是js中的输入框 需要在block中把用户输入的信息传入
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
   UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt message:@"" preferredStyle:UIAlertControllerStyleAlert];
   [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
       textField.text = defaultText;
   }];
   [alertController addAction:([UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       completionHandler(alertController.textFields[0].text?:@"");
   }])];
   [self presentViewController:alertController animated:YES completion:nil];
}
   // 页面是弹出窗口 _blank 处理
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
   if (!navigationAction.targetFrame.isMainFrame) {
       [webView loadRequest:navigationAction.request];
   }
   return nil;
}
-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
   
    if(webView != self.webView) {
        
        decisionHandler(WKNavigationActionPolicyAllow);
        
        return;
        
    }
    NSURL  * url = navigationAction.request.URL;
    UIApplication *app = [UIApplication sharedApplication];
    
    
//    appstorte
    if ([url.absoluteString containsString:@"itunes.apple.com"])
        
    {
        
        if ([app canOpenURL:url])
            
        {
            
            [app openURL:url options:@{} completionHandler:^(BOOL success) {
                
            }];
            decisionHandler(WKNavigationActionPolicyCancel);
            
            return;
            
        }
        
    }
    if (!navigationAction.targetFrame.isMainFrame) {
        [self.webView loadRequest:navigationAction.request];
    }
//    appstore的外的包  慎用 itms-services ----审核会被拒
    if ([url.absoluteString containsString:@"itms-services://"]) {
        [app openURL:url options:@{} completionHandler:^(BOOL success) {
            
        }];
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    decisionHandler(WKNavigationActionPolicyAllow);
    
}



@end
