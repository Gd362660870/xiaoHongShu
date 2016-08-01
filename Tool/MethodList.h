//
//  MethodList.h
//  xiaoHongShu
//
//  Created by 陈家劲 on 16/6/3.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  方法列表：多种可复用方法集合
 */
@protocol MethodList <NSObject>

@optional
/**
 *  初始化时传入导航
 */
-(instancetype)initWithNavigationController:(UINavigationController *)navigationController;

/**
 *  初始化时传入导航和URL
 */
-(instancetype)initWithNavigationController:(UINavigationController *)navigationController endURL:(NSString *)url;

/**
 *  初始化时传入导航和URL
 */
-(instancetype)initWithNavigationController:(UINavigationController *)navigationController endURL:(NSString *)ID endType:(NSString *)type;

@end
