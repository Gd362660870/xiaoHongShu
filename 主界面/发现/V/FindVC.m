//
//  FindVC.m
//  xiaoHongShu
//
//  Created by 陈家劲 on 16/5/30.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import "FindCell.h"
#import "FindHeaderContentView.h"
#import "FindHeaderScrollView.h"
#import "FindVC.h"
#import "FindViewModel.h"
#import "SuperTableView.h"
#define CELL @"cell1"

@interface FindVC ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) FindViewModel* viewModel;
@property(nonatomic, strong) SuperTableView* tableView;
@property (nonatomic,strong) UILabel *headerTitle;
@property (nonatomic,strong) UIView *fooderTitle;
@property(nonatomic, strong) FindHeaderScrollView* headerscrollView;
@property(nonatomic, copy) NSMutableArray* dataArray;
@end

@implementation FindVC

- (void)viewDidLoad {
  [super viewDidLoad];
}

- (instancetype)initWithNavigationController:
    (UINavigationController*)navigationController {
  self = [super init];
  if (self) {
    self.viewModel = [[FindViewModel alloc]
        initWithNavigationController:navigationController];
    [self addViews];
    [self defineLayout];
    [self bindWithViewModel];
  }
  return self;
}

#pragma mark - 添加视图
- (void)addViews {
  [self.view addSubview:self.tableView];
}

#pragma mark - 适配
- (void)defineLayout {
}

#pragma mark - 关联
- (void)bindWithViewModel {
  [[self.viewModel.ModelSignal skip:1] subscribeNext:^(id x) {

    self.dataArray = x;
    [self.tableView reloadData];
  }];
}

#pragma mark - 初始化
-(UILabel *)headerTitle
{
    if (!_headerTitle) {
        _headerTitle =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
        [_headerTitle setBackgroundColor:[UIColor whiteColor]];
        [_headerTitle setText:@"      品质生活"];
        [_headerTitle setTextAlignment:NSTextAlignmentLeft];
        [_headerTitle setTextColor:[UIColor colorWithWhite:0.561 alpha:1.000]];
        [_headerTitle setFont:[UIFont systemFontOfSize:15]];
    }
    
    return _headerTitle;
}
- (NSMutableArray*)dataArray {
  if (!_dataArray) {
    _dataArray = [NSMutableArray new];
  }
  return _dataArray;
}
- (FindViewModel*)viewModel {
  if (!_viewModel) {
    _viewModel = [FindViewModel new];
  }
  return _viewModel;
}

- (SuperTableView*)tableView {
  if (!_tableView) {
    _tableView =
        [[SuperTableView alloc] initWithFrame:[UIScreen mainScreen].bounds
                                        style:UITableViewStyleGrouped];
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    [_tableView setTableHeaderView:self.headerscrollView];
      
      
  }
  return _tableView;
}
- (UIScrollView*)headerscrollView {
  if (!_headerscrollView) {
    _headerscrollView = [[FindHeaderScrollView alloc]
        initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    [_headerscrollView bindViewModel:self.viewModel];
  }
  return _headerscrollView;
}

#pragma mark - TableViewDele
//行数
- (NSInteger)tableView:(UITableView*)tableView
 numberOfRowsInSection:(NSInteger)section {
  return 1;
}

//设置行高的方法
- (CGFloat)tableView:(UITableView*)tableView
    heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    
     return [self.dataArray[indexPath.section][@"item"] count]/2 *105;
}

//根据分组，返回每个cell
- (UITableViewCell*)tableView:(UITableView*)tableView
        cellForRowAtIndexPath:(NSIndexPath*)indexPath {
  static NSString* cellId = @"cell";
  FindCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId];
  if (cell == nil) {
    cell = [[FindCell alloc] initWithStyle:UITableViewCellStyleValue1
                           reuseIdentifier:cellId];
  }
    NSLog(@"%f",cell.frame.size.height);

    
    [cell bindViewModel:self.viewModel endIndexPath:indexPath];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
  return cell;
}

//组数
- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView {
  return self.dataArray.count;
}



//组头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45;
    
//    /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator9.1.sdk/System/Library/Frameworks/UIKit.framework/Headers/UITableView.h:185:72: Expected ';' at end of declaration list
}

//组尾高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 40;
}


//返回分组的头部视图
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    return self.headerTitle;
}
//返回分组的尾部视图
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    [view setBackgroundColor:[UIColor redColor]];
    return view;
}



@end
