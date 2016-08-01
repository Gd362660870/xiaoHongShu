//
//  TopicYypeHeaderM.h
//  xiaoHongShu
//
//  Created by 陈家劲 on 16/6/7.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import <Foundation/Foundation.h>


@class Data1,Scenario_Info1,Relatedgoods_List1,Recommendtags_List1,Tag_Info1;
@interface TopicYypeHeaderM : NSObject


@property (nonatomic, assign) NSInteger result;

@property (nonatomic, strong) Data1 *data;


@end

@interface Data1 : NSObject

@property (nonatomic, strong) NSArray<Relatedgoods_List1 *> *relatedgoods_list;

@property (nonatomic, assign) BOOL has_more_related_goods;
@property (nonatomic, strong) Tag_Info1 *tag_info;

@property (nonatomic, strong) Scenario_Info1 *scenario_info;

@property (nonatomic, strong) NSArray<Recommendtags_List1 *> *recommendtags_list;

@end


@interface Tag_Info1 : NSObject

@property (nonatomic, copy) NSString *category;

@property (nonatomic, assign) NSInteger fans_total;

@property (nonatomic, copy) NSString *share_link;

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *ename;

@property (nonatomic, assign) NSInteger likes_total;

@property (nonatomic, assign) BOOL inlikes;

@property (nonatomic, assign) BOOL canfollow;

@property (nonatomic, copy) NSString *oid;

@property (nonatomic, assign) NSInteger discovery_total;

@property (nonatomic, copy) NSString *name;

@end


@interface Scenario_Info1 : NSObject

@property (nonatomic, copy) NSString *category;

@property (nonatomic, assign) NSInteger fans_total;

@property (nonatomic, copy) NSString *share_link;

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, copy) NSString *Newname_valuepair0;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *ename;

@property (nonatomic, assign) NSInteger likes_total;

@property (nonatomic, assign) BOOL inlikes;

@property (nonatomic, assign) BOOL canfollow;

@property (nonatomic, copy) NSString *oid;

@property (nonatomic, assign) NSInteger discovery_total;

@property (nonatomic, copy) NSString *name;

@end

@interface Relatedgoods_List1 : NSObject

@property (nonatomic, assign) NSInteger discount_price;

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, assign) NSInteger price;

@property (nonatomic, copy) NSString *link;

@end

@interface Recommendtags_List1 : NSObject

@property (nonatomic, copy) NSString *oid;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *link;

@end

