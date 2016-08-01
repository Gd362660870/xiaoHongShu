//
//  TopicYypeVC.m
//  xiaoHongShu
//
//  Created by 陈家劲 on 16/6/6.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import "TopicYypeVC.h"
#import "TopicYypeVM.h"
@interface TopicYypeVC ()

@property (nonatomic,strong)TopicYypeVM *viewModel;
@property (strong, nonatomic) IBOutlet UIScrollView *scorllView;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation TopicYypeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addViews];
    [self defineLayout];
    [self bindWithViewModel];
    
}

-(instancetype)initWithNavigationController:(UINavigationController *)navigationController
{
    self = [super init];
    if (self) {
        self.viewModel = [[TopicYypeVM alloc]initWithNavigationController:navigationController];
        NSLog(@"%@",navigationController);
        
       
        
    }
    return self;
}


#pragma mark-添加视图
-(void)addViews
{
    
}
#pragma mark-适配
-(void)defineLayout
{
    
}

#pragma 关联
-(void)bindWithViewModel
{
    RAC(self,viewModel.ID) = RACObserve(self, ID);
    RAC(self,viewModel.type) = RACObserve(self, type);
    
    
}



@end
