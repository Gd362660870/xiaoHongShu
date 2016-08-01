//
//  TopicYypeVM.h
//  xiaoHongShu
//
//  Created by 陈家劲 on 16/6/6.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import "SuperVM.h"
#import "TopicYypeHeaderM.h"

@interface TopicYypeVM : SuperVM<MethodList>
@property (nonatomic,strong)TopicYypeHeaderM *headerModel;


@end
