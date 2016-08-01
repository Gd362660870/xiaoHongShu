//
//  FindViewModel.h
//  xiaoHongShu
//
//  Created by 陈家劲 on 16/6/1.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FindVCHeaderModel.h"
#import "SuperVM.h"
#import "MethodList.h"
@interface FindViewModel : SuperVM<MethodList>

@property(nonatomic, strong) RACSignal *headerModelSignal;
@property(nonatomic, strong) RACSignal *ModelSignal;
@property(nonatomic, strong) NSString *headerPuchURL;




@end
