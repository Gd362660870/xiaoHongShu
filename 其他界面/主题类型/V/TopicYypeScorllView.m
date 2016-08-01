//
//  TopicYypeScorllView.m
//  xiaoHongShu
//
//  Created by 陈家劲 on 16/6/7.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import "TopicYypeScorllView.h"
#import "TopicYypeVM.h"
@interface TopicYypeScorllView()

@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)TopicYypeVM *viewModel;

@end

@implementation TopicYypeScorllView

-(void)bindView:(id)view endModel:(id)viewModel
{
    _scrollView = view;
    _viewModel = viewModel;
    
    
    
}

@end
