//
//  FindVCHeaderModel.m
//  xiaoHongShu
//
//  Created by 陈家劲 on 16/5/31.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import "FindVCHeaderModel.h"

@implementation FindVCHeaderModel

@end

@implementation Data

+ (NSDictionary *)objectClassInArray {
  return @{ @"banners" : [Banners class] };
}

@end

@implementation Banners

+ (NSDictionary *)objectClassInArray {
  return @{ @"recommends" : [Recommends class] };
}

@end

@implementation Recommends

@end

@implementation User

@end
