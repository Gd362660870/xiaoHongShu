//
//  FindCell.m
//  xiaoHongShu
//
//  Created by 陈家劲 on 16/6/3.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import "FindCell.h"
#import "FindViewModel.h"
#define SCREEN_IMAGERVIEW_WIDTH \
  (([UIScreen mainScreen].bounds.size.width - (15 * 3)) / 2.f)

@interface FindCell ()

@property(nonatomic, retain) FindViewModel *viewModel;
//@property(nonatomic, strong) NSArray *dataArray;


@end

@implementation FindCell
-(void)bindViewModel:(id)viewModel endIndexPath:(NSIndexPath *)indexPath
{
    self.viewModel = viewModel;
    [self.viewModel.ModelSignal subscribeNext:^(NSArray *x) {

        int num = 0;
          for (int i = 0; i < ([x[indexPath.section][@"item"] count] + 1)/2; i++) {
        
              for (int j = 0; j < 2; j ++) {
                      SuperImageView *imageView = [[SuperImageView alloc]
                          initWithFrame:CGRectMake(15 + (SCREEN_IMAGERVIEW_WIDTH + 15) * j,
                                                   i * 105, SCREEN_IMAGERVIEW_WIDTH, 90)];
                  //图片设置圆弧
                  imageView.layer.masksToBounds = YES;
                  [imageView.layer setCornerRadius:10];
                  [imageView setUserInteractionEnabled:YES];
        
        
                  //图片点击事件
                  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]init];
                  [imageView addGestureRecognizer:tap];
                  
                  [[tap rac_gestureSignal] subscribeNext:^(id x) {
                      
                      NSLog(@"%@",[x class]);
                      [self.viewModel.puchSubject sendNext:x];
                      
                  }];
                  
        
                  //赋值
                  imageView.ID = x[indexPath.section][@"item"][num][@"oid"];
                  imageView.type =x[indexPath.section][@"type"];
                      [imageView sd_setImageWithURL:[NSURL URLWithString:x[indexPath.section][@"item"][num][@"image"]]];
                 
                  
                      [self addSubview:imageView];
                  num ++;
              }
        
          }
        
        
    }];
    
}


#pragma mark - 初始化



@end
