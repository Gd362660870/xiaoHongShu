//
//  FindVCHeaderModel.h
//  xiaoHongShu
//
//  Created by 陈家劲 on 16/5/31.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Data, Banners, Recommends, User;
@interface FindVCHeaderModel : NSObject

@property(nonatomic, assign) NSInteger result;

@property(nonatomic, strong) Data *data;

@end

@interface Data : NSObject

@property(nonatomic, strong) NSArray<Banners *> *banners;

@property(nonatomic, copy) NSString *search_placeholder;

@end

@interface Banners : NSObject

@property(nonatomic, copy) NSString *type;

@property(nonatomic, strong) NSArray<Recommends *> *recommends;

@end

@interface Recommends : NSObject

@property(nonatomic, copy) NSString *oid;

@property(nonatomic, copy) NSString *type;

@property(nonatomic, strong) User *user;

@property(nonatomic, copy) NSString *name;

@property(nonatomic, strong) NSArray<NSString *> *images;

@property(nonatomic, copy) NSString *link;

@end

@interface User : NSObject

@property(nonatomic, copy) NSString *userid;

@property(nonatomic, copy) NSString *nickname;

@end
