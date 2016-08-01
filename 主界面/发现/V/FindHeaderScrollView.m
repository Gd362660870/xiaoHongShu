//
//  FindHeaderScrollView.m
//  xiaoHongShu
//
//  Created by 陈家劲 on 16/6/2.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import "FindHeaderContentView.h"
#import "FindHeaderScrollView.h"
#import "FindViewModel.h"
#define CONTENT_WIDTH 200

@interface FindHeaderScrollView ()

@property(nonatomic, strong) FindViewModel *viewModel;

@end
@implementation FindHeaderScrollView

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self setBounces:NO];
    //        [self setPagingEnabled:YES];
    [self setShowsVerticalScrollIndicator:NO];
    [self setShowsHorizontalScrollIndicator:NO];
    [self setBackgroundColor:[UIColor grayColor]];
  }
  return self;
}
- (void)bindViewModel:(id)viewModel {
  self.viewModel = viewModel;

  @weakify(self)

      [[self.viewModel.headerModelSignal skip:1] subscribeNext:^(NSArray *x) {

        [self setContentSize:CGSizeMake((x.count + 2) * CONTENT_WIDTH,
                                        self.frame.size.height)];
        NSMutableArray *Marray = [NSMutableArray new];

        for (int i = 0; i < x.count; i++) {
          @strongify(self)

              UIView *view = [[UIView alloc]
                  initWithFrame:CGRectMake(i * CONTENT_WIDTH, 0, CONTENT_WIDTH,
                                           self.frame.size.height)];
          [view setBackgroundColor:[UIColor colorWithRed:0.949
                                                   green:0.965
                                                    blue:0.973
                                                   alpha:1.000]];
          FindHeaderContentView *contentView =
              [[NSBundle mainBundle] loadNibNamed:@"FindHeaderContentView"
                                            owner:self
                                          options:nil][0];

          //设置圆弧
          contentView.layer.masksToBounds = YES;
          [contentView.layer setCornerRadius:5];

          CGPoint point = {CONTENT_WIDTH / 2, view.center.y};
          contentView.center = point;

          [contentView.name setText:x[i][@"name"]];
          NSArray *imageArray = @[
            contentView.images1,
            contentView.images2,
            contentView.images3
          ];
          for (int j = 0; j < imageArray.count; j++) {
            UIImageView *image = imageArray[j];
            //设置圆弧
            image.layer.masksToBounds = YES;
            [image.layer setCornerRadius:5];
            [image sd_setImageWithURL:x[i][@"images"][j]];
          }

          //设置可变字体
          NSMutableAttributedString *str = [[NSMutableAttributedString alloc]
              initWithString:[NSString
                                 stringWithFormat:@"由 %@ 创建",
                                                  x[i][@"user"][@"nickname"]]];
          [str addAttribute:NSForegroundColorAttributeName
                      value:[UIColor colorWithWhite:0.816 alpha:1.000]
                      range:NSMakeRange(0, 1)];

          [str
              addAttribute:NSForegroundColorAttributeName
                     value:[UIColor colorWithWhite:0.603 alpha:1.000]
                     range:NSMakeRange(2, [x[i][@"user"][@"nickname"] length])];

          [str addAttribute:NSForegroundColorAttributeName
                      value:[UIColor colorWithWhite:0.816 alpha:1.000]
                      range:NSMakeRange([x[i][@"user"][@"nickname"] length] + 3,
                                        2)];

          [contentView.nickname setAttributedText:str];

          //添加URL
          contentView.URL = [NSString
              stringWithFormat:@"http://m.xiaohongshu.com/album/issue_%d",
                               x.count - i - 1];

          //添加视图
          [view addSubview:contentView];
          //          [self addSubview:view];

          //设置点击事件
          UITapGestureRecognizer *tap = [UITapGestureRecognizer new];
          [contentView addGestureRecognizer:tap];
          [Marray addObject:view];

          [tap.rac_gestureSignal subscribeNext:^(UITapGestureRecognizer *x) {

            FindHeaderContentView *view = (FindHeaderContentView *)x.self.view;

            self.viewModel.headerPuchURL = view.URL;

          }];
        }

        for (int i = 0; i < x.count; i++) {
          if (i == 0) {
            @strongify(self)

                UIView *view = [[UIView alloc]
                    initWithFrame:CGRectMake(i * CONTENT_WIDTH, 0,
                                             CONTENT_WIDTH,
                                             self.frame.size.height)];
            [view setBackgroundColor:[UIColor colorWithRed:0.949
                                                     green:0.965
                                                      blue:0.973
                                                     alpha:1.000]];
            FindHeaderContentView *contentView =
                [[NSBundle mainBundle] loadNibNamed:@"FindHeaderContentView"
                                              owner:self
                                            options:nil][0];

            //设置圆弧
            contentView.layer.masksToBounds = YES;
            [contentView.layer setCornerRadius:5];

            CGPoint point = {CONTENT_WIDTH / 2, view.center.y};
            contentView.center = point;

            [contentView.name setText:x[i][@"name"]];
            NSArray *imageArray = @[
              contentView.images1,
              contentView.images2,
              contentView.images3
            ];
            for (int j = 0; j < imageArray.count; j++) {
              UIImageView *image = imageArray[j];
              //设置圆弧
              image.layer.masksToBounds = YES;
              [image.layer setCornerRadius:5];
              [image sd_setImageWithURL:x[i][@"images"][j]];
            }

            //设置可变字体
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc]
                initWithString:[NSString stringWithFormat:@"由 %@ 创建",
                                                          x[i][@"user"][
                                                              @"nickname"]]];
            [str addAttribute:NSForegroundColorAttributeName
                        value:[UIColor colorWithWhite:0.816 alpha:1.000]
                        range:NSMakeRange(0, 1)];

            [str addAttribute:NSForegroundColorAttributeName
                        value:[UIColor colorWithWhite:0.603 alpha:1.000]
                        range:NSMakeRange(2,
                                          [x[i][@"user"][@"nickname"] length])];

            [str addAttribute:NSForegroundColorAttributeName
                        value:[UIColor colorWithWhite:0.816 alpha:1.000]
                        range:NSMakeRange(
                                  [x[i][@"user"][@"nickname"] length] + 3, 2)];

            [contentView.nickname setAttributedText:str];

            //添加URL
            contentView.URL = [NSString
                stringWithFormat:@"http://m.xiaohongshu.com/album/issue_%d",
                                 x.count - i - 1];

            //添加视图
            [view addSubview:contentView];
            //          [self addSubview:view];

            //设置点击事件
            UITapGestureRecognizer *tap = [UITapGestureRecognizer new];
            [contentView addGestureRecognizer:tap];
            [Marray addObject:view];

            [tap.rac_gestureSignal subscribeNext:^(UITapGestureRecognizer *x) {

              FindHeaderContentView *view =
                  (FindHeaderContentView *)x.self.view;

              self.viewModel.headerPuchURL = view.URL;

            }];
          }

          if (i == x.count - 1) {
            @strongify(self)

                UIView *view = [[UIView alloc]
                    initWithFrame:CGRectMake(i * CONTENT_WIDTH, 0,
                                             CONTENT_WIDTH,
                                             self.frame.size.height)];
            [view setBackgroundColor:[UIColor colorWithRed:0.949
                                                     green:0.965
                                                      blue:0.973
                                                     alpha:1.000]];
            FindHeaderContentView *contentView =
                [[NSBundle mainBundle] loadNibNamed:@"FindHeaderContentView"
                                              owner:self
                                            options:nil][0];

            //设置圆弧
            contentView.layer.masksToBounds = YES;
            [contentView.layer setCornerRadius:5];

            CGPoint point = {CONTENT_WIDTH / 2, view.center.y};
            contentView.center = point;

            [contentView.name setText:x[i][@"name"]];
            NSArray *imageArray = @[
              contentView.images1,
              contentView.images2,
              contentView.images3
            ];
            for (int j = 0; j < imageArray.count; j++) {
              UIImageView *image = imageArray[j];
              //设置圆弧
              image.layer.masksToBounds = YES;
              [image.layer setCornerRadius:5];
              [image sd_setImageWithURL:x[i][@"images"][j]];
            }

            //设置可变字体
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc]
                initWithString:[NSString stringWithFormat:@"由 %@ 创建",
                                                          x[i][@"user"][
                                                              @"nickname"]]];
            [str addAttribute:NSForegroundColorAttributeName
                        value:[UIColor colorWithWhite:0.816 alpha:1.000]
                        range:NSMakeRange(0, 1)];

            [str addAttribute:NSForegroundColorAttributeName
                        value:[UIColor colorWithWhite:0.603 alpha:1.000]
                        range:NSMakeRange(2,
                                          [x[i][@"user"][@"nickname"] length])];

            [str addAttribute:NSForegroundColorAttributeName
                        value:[UIColor colorWithWhite:0.816 alpha:1.000]
                        range:NSMakeRange(
                                  [x[i][@"user"][@"nickname"] length] + 3, 2)];

            [contentView.nickname setAttributedText:str];

            //添加URL
            contentView.URL = [NSString
                stringWithFormat:@"http://m.xiaohongshu.com/album/issue_%d",
                                 x.count - i - 1];

            //添加视图
            [view addSubview:contentView];
            //          [self addSubview:view];

            //设置点击事件
            UITapGestureRecognizer *tap = [UITapGestureRecognizer new];
            [contentView addGestureRecognizer:tap];
            [Marray insertObject:view atIndex:0];

            [tap.rac_gestureSignal subscribeNext:^(UITapGestureRecognizer *x) {

              FindHeaderContentView *view =
                  (FindHeaderContentView *)x.self.view;

              self.viewModel.headerPuchURL = view.URL;

            }];
          }
        }

        for (int i = 0; i < Marray.count; i++) {
          UIView *view = Marray[i];
          [view setFrame:CGRectMake(i * CONTENT_WIDTH, 0, CONTENT_WIDTH,
                                    self.frame.size.height)];
          [self addSubview:view];
        }

      }];
}

- (void)hahah {
  NSLog(@"dianshi ");
}

@end
