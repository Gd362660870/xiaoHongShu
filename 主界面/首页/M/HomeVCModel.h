//
//  HomeVCModel.h
//  xiaoHongShu
//
//  Created by qf1 on 16/6/1.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeVCModel : NSObject

@property (nonatomic, copy) NSString *url;  //图片
@property (nonatomic, copy) NSString * image_height;    //图片高度
@property (nonatomic, copy) NSString * image_width;     //图片宽度
@property (nonatomic, copy) NSString *desc; //介绍
@property (nonatomic, copy) NSString *tag;  //标签
@property (nonatomic, copy) NSString *likes;    //点赞人数
@property (nonatomic, copy) NSString *user_name;    //楼主名
@property (nonatomic, copy) NSString *user_icon;    //楼主头像
@property (nonatomic, copy) NSString *user_id;    //楼主头像
@property (nonatomic, copy) NSString *user_url;  //图片

@end

