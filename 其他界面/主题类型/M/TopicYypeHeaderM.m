//
//  TopicYypeHeaderM.m
//  xiaoHongShu
//
//  Created by 陈家劲 on 16/6/7.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import "TopicYypeHeaderM.h"

@implementation TopicYypeHeaderM



@end





@implementation Data1

//重写数据模型映射方法
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

+ (NSDictionary *)objectClassInArray{
    return @{@"relatedgoods_list" : [Relatedgoods_List1 class], @"recommendtags_list" : [Recommendtags_List1 class]};
}

@end

@implementation Tag_Info1

@end


@implementation Scenario_Info1

//重写数据模型映射方法
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"Newname-valuepair0"])
    {
        self.Newname_valuepair0=value;
    }
}


@end


@implementation Relatedgoods_List1

//重写数据模型映射方法
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"])
    {
        self.ID=value;
    }
}

@end


@implementation Recommendtags_List1

@end


