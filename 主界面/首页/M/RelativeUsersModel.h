//
//  RelativeUsersModel.h
//  xiaoHongShu
//
//  Created by qf1 on 16/6/2.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RelativeUsersModel : NSObject

/** 相关用户属性 */
@property (nonatomic, copy) NSString *image;  //图片
@property (nonatomic, copy) NSString *desc;  //详情介绍
@property (nonatomic, copy) NSString *time;  //发表时间
@property (nonatomic, copy) NSString *user_icon;  //用户头像
@property (nonatomic, copy) NSString *user_name;  //用户昵称
@property (nonatomic, copy) NSString *zan_num;  //点赞数

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)relativeUserModelWithDict:(NSDictionary *)dict;

@end
