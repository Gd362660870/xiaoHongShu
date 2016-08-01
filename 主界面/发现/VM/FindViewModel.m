
//
//发现-更多品质生活
// http://www.xiaohongshu.com/api/sns/v1/explore/scenarios?deviceId=A690A122-FA58-43C3-BC5D-EDD3E8BD84C4&lang=zh-Hans&page=1&platform=iOS&sid=session.1149095021761557778&sign=f2e515e90b6cbbdd177304a4048afd6c&t=1464954864
//
//发现-更多全球购物
// http://www.xiaohongshu.com/api/sns/v1/explore/tags?deviceId=A690A122-FA58-43C3-BC5D-EDD3E8BD84C4&lang=zh-Hans&page=1&platform=iOS&sid=session.1149095021761557778&sign=8e544bd86c4914b53153b1668cb0b532&t=1464955083&type=destination

//发现接口
static NSString *const headerModelUrl =
    @"http://www.xiaohongshu.com/api/sns/v2/explore/"
    @"banner?deviceId=A690A122-FA58-43C3-BC5D-EDD3E8BD84C4&lang=zh-Hans&"
    @"platform=iOS&sid=session.1149095021761557778&sign="
    @"19ea2c04a29f73225858b7e71af0a200&t=1464696741";

#import "FindViewModel.h"
#import "WebVC.h"
#import "TopicYypeVC.h"
@interface FindViewModel ()

//@property(nonatomic, strong) AFHTTPRequestOperationManager *manager;
@property(nonatomic, strong) FindVCHeaderModel *Model;
@property(nonatomic, strong) UINavigationController *NAV;
@end

@implementation FindViewModel

- (instancetype)initWithNavigationController:
    (UINavigationController *)navigationController {
  self = [super init];
  if (self) {
    _Model = [FindVCHeaderModel new];
    _NAV = navigationController;
      
      //获取信号
    [self getSignal];

  }
  return self;
}

- (void)getSignal {
 
    //网络请求
    [self getData];
    //页面跳转
    [self pushPage];
    
}

#pragma mark - 网络请求
-(void)getData
{
    @weakify(self)
    [[[self.manager rac_GET:headerModelUrl parameters:nil] map:^id(id x) {
        RACTupleUnpack(NSString * key) = x;
        return key;
    }] subscribeNext:^(id x) {
        @strongify(self)[self.Model setValuesForKeysWithDictionary:x];
    }];

}

#pragma mark - 页面跳转
-(void)pushPage
{
    @weakify(self)
    //网页跳转
    [[RACObserve(self, headerPuchURL) skip:1] subscribeNext:^(id x) {
        
        @strongify(self)
        WebVC *vc = [[WebVC alloc] initWithNavigationController:self.NAV endURL:x];
        NSLog(@"%@",self.NVC);
        [self.NAV pushViewController:vc animated:YES];
        
    }];
    
    
    [self.puchSubject subscribeNext:^(UITapGestureRecognizer *x) {
        
        @strongify(self)
        SuperImageView *imageView = (SuperImageView *)x.self.view;
        
        TopicYypeVC*VC = [[TopicYypeVC alloc]initWithNavigationController:self.NAV];
        
        VC.type = imageView.type;
        VC.ID = imageView.ID;
        
        [self.NAV pushViewController:VC animated:YES];

        
    }];

}
#pragma mark - 初始化

- (RACSignal *)headerModelSignal {
  if (!_headerModelSignal) {
    _headerModelSignal =
        [RACObserve(self, Model.data.banners) map:^id(id value) {
          return value[0][@"recommends"];
        }];
  }
  return _headerModelSignal;
}

- (RACSignal *)ModelSignal {
  if (!_ModelSignal) {
    _ModelSignal =
        [RACObserve(self, Model.data.banners) map:^id(NSArray *value) {

          NSMutableArray *mArray = [NSMutableArray new];
            
          for (NSDictionary *dict in value) {
            if ([dict[@"scenario"] count] > 0) {
                NSDictionary *dict1 = @{@"item":dict[@"scenario"],@"type":dict[@"type"]};
                [mArray addObject:dict1];
                
            } else if ([dict[@"events"] count] > 0) {
                NSDictionary *dict1 = @{@"item":dict[@"events"],@"type":dict[@"type"]};
                [mArray addObject:dict1];

            } else if ([dict[@"boards"] count] > 0) {
                NSDictionary *dict1 = @{@"item":dict[@"boards"],@"type":dict[@"type"]};
                [mArray addObject:dict1];

            } else if ([dict[@"destination"][@"banners"] count] > 0) {
              NSLog(@"banners");
                NSDictionary *dict1 = @{@"item":dict[@"destination"][@"banners"],@"type":dict[@"type"]};
                [mArray addObject:dict1];
            }
          }

          return mArray;
        }];
  }
  return _ModelSignal;
}

@end
