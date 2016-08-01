//
//  RelativeUsersModel.m
//  xiaoHongShu
//
//  Created by qf1 on 16/6/2.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import "RelativeUsersModel.h"

@implementation RelativeUsersModel

-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        self.image = dict[@"image"];  //图片
        self.desc = dict[@"desc"];  //详情介绍
        self.time = dict[@"time"];  //发表时间
        self.user_icon = dict[@"user_icon"];  //用户头像
        self.user_name = dict[@"user_name"];  //用户昵称
        self.zan_num = dict[@"zan_num"];  //点赞数
    }
    return self;
}


+(instancetype)relativeUserModelWithDict:(NSDictionary *)dict{
    return [[RelativeUsersModel alloc]initWithDict:dict];
}

@end
