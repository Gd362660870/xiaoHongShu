

#import "NetWork.h"
#import "HomeVCModel.h"

@implementation NetWork

-(void)getDataForHomeVC{
    
    NSString * pathUrl = [NSString stringWithFormat:@"http://www.xiaohongshu.com/api/sns/v2/homefeed?filter=&value=simple&platform=Android&source=discovery&deviceId=0175546b-bb57-3a4e-97ba-6b40dbffadb7&versionName=4.4.100&channel=Store360&sid=session.1149096594494495643&lang=zh-Hans&t=1464610232&sign=dcb04608fa20f00959ca92f4d89128cd"];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    [manager GET:pathUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary * rootDict = responseObject;
        
        NSArray * dataArray = rootDict[@"data"];
        
        NSMutableArray * modelArray = [NSMutableArray array];
        
        for (NSDictionary * itemDict in dataArray) {
            HomeVCModel * model = [HomeVCModel new];
            [modelArray addObject:model];
            
            model.desc = itemDict[@"desc"];
            model.user_id = itemDict[@"id"];
            model.user_url = itemDict[@"share_link"];
            NSString * likes = [NSString stringWithFormat:@"%@",itemDict[@"likes"]];
            model.likes = likes;
            
            NSArray * imageArr = itemDict[@"images_list"];
            if (imageArr.count > 0) {
                NSDictionary * imageDict = imageArr[0];
                model.url = imageDict[@"url"];
                NSString * height = [NSString stringWithFormat:@"%@",imageDict[@"height"]];
                NSString * width = [NSString stringWithFormat:@"%@",imageDict[@"width"]];
                model.image_height = height;
                model.image_width = width;
            }
            NSDictionary * recommendDict = itemDict[@"recommend"];
            model.tag = recommendDict[@"desc"];
            NSDictionary * userDict = itemDict[@"user"];
            model.user_icon = userDict[@"images"];
            model.user_name = userDict[@"nickname"];
        }
        //有需要再验证数据
        //        NSLog(@"%@",modelArray);
        //        HomeVCModel * model = modelArray[1];
        //        NSLog(@"1 = %@",model.url);
        //        NSLog(@"2 = %@",model.image_height);
        //        NSLog(@"3 = %@",model.image_width);
        //        NSLog(@"4 = %@",model.desc);
        //        NSLog(@"5 = %@",model.tag);
        //        NSLog(@"6 = %@",model.likes);
        //        NSLog(@"7 = %@",model.user_name);
        //        NSLog(@"8 = %@",model.user_icon);
        
        /**
         @property (nonatomic, copy) NSString *url;  //图片
         @property (nonatomic, copy) NSString * image_height;    //图片高度
         @property (nonatomic, copy) NSString * image_width;     //图片宽度
         @property (nonatomic, copy) NSString *desc; //介绍
         @property (nonatomic, copy) NSString *tag;  //标签
         @property (nonatomic, copy) NSString *likes;    //点赞人数
         @property (nonatomic, copy) NSString *user_name;    //楼主名
         @property (nonatomic, copy) NSString *user_icon;    //楼主头像
         */
        
        [self.delegate DataCallBackForHomeVC:modelArray];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}

@end
