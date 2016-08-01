
#import "TopicYypeVM.h"

#import "TopicYypeCellM.h"

@interface TopicYypeVM()


@property (nonatomic,strong)NSDictionary *URL;

@end

@implementation TopicYypeVM

-(instancetype)initWithNavigationController:(UINavigationController *)navigationController
{
    self = [super init];
    if (self) {
        
        self.NVC = navigationController;
//        _headerModel = [TopicYypeHeaderM new];
        
//        获取信号
        [self getSignal];
        //网络请求
        [self getData];
        //页面跳转
        [self pushPage];
        
    }
    return self;

}
#pragma mark- 获取信号
- (void)getSignal {
    
    
    
}

#pragma mark- 网络请求
-(void)getData
{
    
    @weakify(self);
//    self.headerModel = [TopicYypeHeaderM new];
    
    [[[[RACSignal combineLatest:@[RACObserve(self, ID),RACObserve(self, type)] reduce:^id(NSString *ID,NSString *type){
        
        if (!ID ||!type) {
            return nil;
        }else
        {
            //搭配
            if ([type isEqualToString:@"scenario"]) {
                
                NSString *header =[NSString stringWithFormat:@"http://www.xiaohongshu.com/api/sns/v1/scenario/%@?deviceId=A690A122-FA58-43C3-BC5D-EDD3E8BD84C4&lang=zh-Hans&mode=explore&platform=iOS&sid=session.1149095021761557778&sign=8863cd4f57d831d522b6c43a95c49f31&t=1464954548",ID];
                
                NSString *cell = [NSString stringWithFormat:@"http://www.xiaohongshu.com/api/sns/v1/note/scenario/%@?deviceId=A690A122-FA58-43C3-BC5D-EDD3E8BD84C4&lang=zh-Hans&num=30&page=1&platform=iOS&sid=session.1149095021761557778&sign=bd058ca93c7bdc1f53af55d19f5341e5&t=1464954549",ID];
                
                NSDictionary *dict = @{@"header":header,@"cell":cell};
                return dict;
                
                //地标
            }else if([type isEqualToString:@"destination"])
            {
                NSString *header =[NSString stringWithFormat:@"http://www.xiaohongshu.com/api/sns/v1/tag/%@?deviceId=A690A122-FA58-43C3-BC5D-EDD3E8BD84C4&lang=zh-Hans&mode=explore&platform=iOS&sid=session.1149095021761557778&sign=f6f18459bfe731fd1bbbba0e902a6831&t=1464953634",ID];
                
                NSString *cell = [NSString stringWithFormat:@"http://www.xiaohongshu.com/api/sns/v1/note/tag/%@?deviceId=A690A122-FA58-43C3-BC5D-EDD3E8BD84C4&lang=zh-Hans&num=30&page=1&platform=iOS&sid=session.1149095021761557778&sign=68c23f816ba54223a36f38d0dccd04db&t=1464953635",ID];
                
                NSDictionary *dict = @{@"header":header,@"cell":cell};
                return dict;
            }
        }
        
        
        return nil;
        
        
        
    }] distinctUntilChanged] skip:1]subscribeNext:^(id x) {
        
        
//        @strongify(self);
        self.URL = x;
        
        
        //cell接口请求
        [[self.manager rac_GET:self.URL[@"cell"] parameters:nil] subscribeNext:^(id x) {
            
//            RACTupleUnpack(id z) = x;
            
            
      
            
            
        } error:^(NSError *error) {
            
            NSLog(@"cell -----  %@",error);
        }];
        
        
        //头部视图接口请求
        [[self.manager rac_GET:self.URL[@"header"] parameters:nil] subscribeNext:^(id x) {
            
            RACTupleUnpack(id z) = x;
            
            @strongify(self);
            
            [ self.headerModel setValuesForKeysWithDictionary:z];
            NSLog(@"%@",self.headerModel);
            
        } error:^(NSError *error) {
            
            NSLog(@"cell -----  %@",error);
        }];
        
      
    }];
    
    

    
    
}

#pragma mark- 页面跳转
-(void)pushPage
{
    
}

//#pragma mark- 初始化
-(TopicYypeHeaderM *)headerModel
{
    if (!_headerModel) {
        _headerModel = [[TopicYypeHeaderM alloc]init];
    }
    return  _headerModel;
}



@end
