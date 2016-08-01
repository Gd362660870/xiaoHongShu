//
//  FindHeaderContentView.h
//  xiaoHongShu
//
//  Created by 陈家劲 on 16/6/1.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FindHeaderContentView : UIView

@property(strong, nonatomic) IBOutlet UILabel *name;
@property(strong, nonatomic) IBOutlet UILabel *nickname;
@property(strong, nonatomic) IBOutlet UIImageView *images1;
@property(strong, nonatomic) IBOutlet UIImageView *images2;
@property(strong, nonatomic) IBOutlet UIImageView *images3;
@property(strong, nonatomic) NSString *URL;

@end
