//
//  DetailVC.m
//  xiaoHongShu
//
//  Created by qf1 on 16/6/2.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

/**
 'An instance 0x79ab9200 of class WKWebView was deallocated while key value observers were still registered with it. Current observation info: <NSKeyValueObservationInfo 0x796228e0> (
 <NSKeyValueObservance 0x79622790: Observer: 0x7aa85b60, Key path: title, Options: <New: YES, Old: NO, Prior: NO> Context: 0x0, Property: 0x79622770>
 */

#import "DetailVC.h"
#import "DetailVCModel.h"
#import "RelativeUsersModel.h"

//详情网址
#define path_url1 @"http://www.xiaohongshu.com/api/sns/v1/note/5747f10c14de41023fad5b2d?platform=Android&source=discovery&deviceId=0175546b-bb57-3a4e-97ba-6b40dbffadb7&versionName=4.4.100&channel=Store360&sid=session.1149096594494495643&lang=zh-Hans&t=1464610492&sign=2c187bbe3aee34536afa1c1f1447aacc"

//本详情评论网址
#define path_url2 @"http://www.xiaohongshu.com/api/v2/comment/newest?discovery_id=5747f10c14de41023fad5b2d&platform=Android&source=discovery&deviceId=0175546b-bb57-3a4e-97ba-6b40dbffadb7&versionName=4.4.100&channel=Store360&sid=session.1149096594494495643&lang=zh-Hans&t=1464610492&sign=8060f4e465f52cadf1da7d1a333bce95"

//相关用户网址
#define path_url3 @"http://www.xiaohongshu.com/api/sns/v2/note/5747f10c14de41023fad5b2d/related?page=1&platform=Android&source=discovery&deviceId=0175546b-bb57-3a4e-97ba-6b40dbffadb7&versionName=4.4.100&channel=Store360&sid=session.1149096594494495643&lang=zh-Hans&t=1464610492&sign=d95988ed3660f09fe024b0ed72396fbf"

@interface DetailVC ()<WKUIDelegate,WKNavigationDelegate>

@property(retain,nonatomic)UIScrollView * scrollView;
@property(retain,nonatomic)WKWebView * webView;

@end

@implementation DetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self makeUI];
//    
//    [self getData];
    
    //直接获取网页UI
    [self getWebUI];
}

#pragma mark-初始化页面
-(void)getWebUI{
    
    WKWebViewConfiguration * configuration = [[WKWebViewConfiguration alloc]init];
    _webView = [[WKWebView alloc]initWithFrame:[UIScreen mainScreen].bounds configuration:configuration];
    
    //界面上代理
    _webView.UIDelegate = self;
    //导航栏代理
    _webView.navigationDelegate = self;
    
    //设置加载的网页地址
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:_url]]];
    //允许用手势前进和后退
    _webView.allowsBackForwardNavigationGestures = YES;
    
    [self.view addSubview:_webView];
    
//    //增加观察者模式，监听网页标题变化
    [_webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
//    //增加观察者模式，监听网页加载进度的变化
//    [_webView addObserver:self forKeyPath:@"" options:NSKeyValueObservingOptionNew context:nil];
}

#pragma mark 开始加载网页的时候执行的方法
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"开始加载网页");
}
#pragma mark 开始返回内容的时候执行该方法
-(void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    NSLog(@"开始返回内容了");
    
}
#pragma mark 加载完成的时候调用
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSLog(@"加载完成");
}
#pragma mark 加载失败
-(void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    NSLog(@"加载失败");
//    NSLog(@"%@",error.description);
}










#if 0
#pragma mark-初始化页面
-(void)makeUI{
    
}
#pragma mark-请求数据
-(void)getData{
    AFHTTPRequestOperationManager * manager1 = [AFHTTPRequestOperationManager manager];
    [manager1 GET:path_url1 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        DetailVCModel * model = [DetailVCModel new];
        
        NSDictionary * rootDict = responseObject;
        NSDictionary * dataDict = rootDict[@"data"];
        
        model.desc1 = dataDict[@"desc"];    //详细介绍
        NSString * likes = [NSString stringWithFormat:@"%@",dataDict[@"likes"]];
        model.zan = likes;//点赞人数
        NSString * collect = [NSString stringWithFormat:@"%@",dataDict[@"fav_count"]];
        model.collect = collect;    //收藏人数
        
        NSDictionary * userDict = dataDict[@"user"];
        model.user_name = userDict[@"nickname"];    // 用户名
        NSArray * imageArr = userDict[@"images_list"];
        NSMutableArray * images = [NSMutableArray array];
        if (images.count > 0) {
            for (NSDictionary * imageDict in imageArr) {
                NSString * imageUrl = imageDict[@"url"];
                [images addObject:imageUrl];
            }
            model.images = images;  //照片数组
        }
        
        NSArray * tagsArr = dataDict[@"tags"];
        NSMutableArray * tags = [NSMutableArray array];
        if (tagsArr.count > 0) {
            for (NSDictionary * tagDict in tagsArr) {
                [tags addObject:tagDict[@"name"]];
            }
            model.tags = tags;
        }
        
        /**
        当前用户属性
        @property (nonatomic, copy) NSString *user_name;  //用户名
         @property (nonatomic, copy) NSString *user_icon;  //用户头像
         @property (nonatomic, copy) NSArray *images;  //主题图片数组
         @property (nonatomic, copy) NSString *imageUrl;  //图片地址
         @property (nonatomic, copy) NSString *imageWidth;  //图片高度
         @property (nonatomic, copy) NSString *imageHeight;  //图片宽度
        @property (nonatomic, copy) NSString *desc1;  //详情介绍
        @property (nonatomic, copy) NSArray * tags; //标签数组
        @property (nonatomic, copy) NSString *collect;  //收藏数
        @property (nonatomic, copy) NSString *zan;  //点赞数
        */
        
        //在这里回调
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    AFHTTPRequestOperationManager * manager2 = [AFHTTPRequestOperationManager manager];
    [manager2 GET:path_url2 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary * rootDict = responseObject;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    AFHTTPRequestOperationManager * manager3 = [AFHTTPRequestOperationManager manager];
    [manager3 GET:path_url3 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary * rootDict = responseObject;
        NSArray * dataArray = rootDict[@"data"];
        
        for (NSDictionary * itemDict in dataArray) {
            
            RelativeUsersModel * model = [RelativeUsersModel new];
            
            model.desc = itemDict[@"desc"];
            NSString * zan = [NSString stringWithFormat:@"%@",itemDict[@"desc"]];
            model.zan_num = zan;
            model.time = itemDict[@"time"];
            
            NSDictionary * userDict = itemDict[@"user"];
            model.user_icon = userDict[@"images"];
            model.user_name = userDict[@"nickname"];
            
            NSArray * imagesArr = itemDict[@"images_list"];
            if (imagesArr.count > 0) {
                model.image = imagesArr[0];
                
                /**
                 相关用户属性
                 @property (nonatomic, copy) NSString *user_icon;  //用户头像
                 @property (nonatomic, copy) NSString *user_name;  //用户昵称
                 @property (nonatomic, copy) NSString *image;  //图片
                 @property (nonatomic, copy) NSString *desc;  //详情介绍
                 @property (nonatomic, copy) NSString *time;  //发表时间
                 @property (nonatomic, copy) NSString *zan_num;  //点赞数
                 */
                
            }
        }
        
        //在这里回调
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}
#endif



@end
