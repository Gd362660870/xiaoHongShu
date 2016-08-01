//
//  WebVC.m
//  xiaoHongShu
//
//  Created by 陈家劲 on 16/6/3.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import "WebVC.h"

@interface WebVC ()<UIWebViewDelegate>

@property (nonatomic,strong)UIWebView *webView;
@property (nonatomic,strong)NSString *url;

@end

@implementation WebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}

-(instancetype)initWithNavigationController:(UINavigationController *)navigationController endURL:(NSString *)url
{
    self = [super init];
    if (self) {
        [self.view setBackgroundColor:[UIColor whiteColor]];
        _url = url;


        [self addViews];
        [self defineLayout];
        [self bindWithViewModel];
        
        
    }
    return self;
}


#pragma mark - 添加视图
-(void)addViews
{
    [self.view addSubview: self.webView];
}
#pragma mark - 适配
-(void)defineLayout
{
    
}

#pragma mark - 关联
- (void)bindWithViewModel {
    
    
}

#pragma mark - 初始化

-(UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc]initWithFrame:SCREEN_BOUNDS];
        
        _webView.delegate = self;
        NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:self.url]];
        [_webView loadRequest:request];
        
       
    }
    return _webView;
}

#pragma mark - webViewDelegate
-(void)webViewDidFinishLoad:(UIWebView *)webView{

}

@end
