//
//  DetailVCModel.h
//  xiaoHongShu
//
//  Created by qf1 on 16/6/2.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailVCModel : NSObject

/** 当前用户属性 */
@property (nonatomic, copy) NSString *user_name;  //用户名
@property (nonatomic, copy) NSString *user_icon;  //用户头像
@property (nonatomic, copy) NSArray *images;  //主题图片数组
@property (nonatomic, copy) NSString *imageUrl;  //图片地址
//@property (nonatomic, copy) NSString *imageWidth;  //图片高度
//@property (nonatomic, copy) NSString *imageHeight;  //图片宽度
@property (nonatomic, copy) NSString *desc1;  //详情介绍
@property (nonatomic, copy) NSArray * tags; //标签数组
@property (nonatomic, copy) NSString *collect;  //收藏数
@property (nonatomic, copy) NSString *zan;  //点赞数

@end
