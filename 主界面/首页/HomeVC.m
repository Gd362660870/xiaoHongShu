//
//  HomeVC.m
//  xiaoHongShu
//
//  Created by 陈家劲 on 16/5/30.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

/**
 *** Assertion failure in -[SuperCollectionView _dequeueReusableViewOfKind:withIdentifier:forIndexPath:viewCategory:], /BuildRoot/Library/Caches/com.apple.xbs/Sources/UIKit_Sim/UIKit-3512.29.5/UICollectionView.m:3627
 2016-06-02 17:18:03.466 xiaoHongShu[2546:142763] *** Terminating app due to uncaught exception 'NSInternalInconsistencyException', reason: 'could not dequeue a view of kind: UICollectionElementKindCell with identifier SuperCollectionViewCell - must register a nib or a class for the identifier or connect a prototype cell in a storyboard'
 */

#import "HomeVC.h"
//#import "SuperCollectionView.h"
#import "HomeVCModel.h"
#import "DetailVC.h"
#import "WebVC.h"
#define Cell_W ([UIScreen mainScreen].bounds.size.width-10*3)/2
#define pathUrl @"http://www.xiaohongshu.com/api/sns/v2/homefeed?filter=&value=simple&platform=Android&source=discovery&deviceId=0175546b-bb57-3a4e-97ba-6b40dbffadb7&versionName=4.4.100&channel=Store360&sid=session.1149096594494495643&lang=zh-Hans&t=1464610232&sign=dcb04608fa20f00959ca92f4d89128cd"

@interface HomeVC ()<UICollectionViewDataSource,UICollectionViewDelegate,NetWorkDataBackProtoco>

@property(nonatomic, strong) HomeVCModel *homeModel;
//@property(nonatomic, strong) SuperCollectionView * collectionView;
@property(nonatomic, strong) UICollectionView * collectionView;
@property(nonatomic, strong) NSMutableArray * dataArray;

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArray = [NSMutableArray array];
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.homeModel = [HomeVCModel new];
        [self addViews];
        [self defineLayout];
        [self bindWithViewModel];
        [self getData];
    }
    return self;
}

#pragma mark - 0.初始化
-(HomeVCModel *)viewModel{
    if (!_homeModel) {
        _homeModel = [HomeVCModel new];
    }
    return _homeModel;
}
//-(SuperCollectionView *)collectionView{
-(UICollectionView *)collectionView{
    
    if (!_collectionView) {
        //实例化布局对象
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        //滑动方向
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        //cell的size
        layout.itemSize = CGSizeMake(Cell_W, 180);

        //每一组items和四个方向的间距值(上左下右)
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        
//        _collectionView = [[SuperCollectionView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) collectionViewLayout:layout];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        //注册
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}
#pragma mark-UICollectionView的代理方法
//控制组数(不写默认1)
//-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
//
//}
//每组的item个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArray.count;
}
//返回每一个item的cell
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //通过复用队列取得cell
    UICollectionViewCell * cell = [collectionView  dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    
    //遮盖之前的cell
    UIView * view = [[UIView alloc]initWithFrame:cell.contentView.frame];
    view.backgroundColor = [UIColor colorWithRed:234/255.0 green:251/255.0 blue:253/255.0 alpha:1.0];
    HomeVCModel * model;
    if (_dataArray.count != 0) {
        model = _dataArray[indexPath.row];
    }
    
    /**
     @property (nonatomic, copy) NSString *url;  //图片
     @property (nonatomic, copy) NSString * image_height;    //图片高度
     @property (nonatomic, copy) NSString * image_width;     //图片宽度
     @property (nonatomic, copy) NSString *desc; //介绍
     @property (nonatomic, copy) NSString *tag;  //标签
     @property (nonatomic, copy) NSString *likes;    //点赞人数
     @property (nonatomic, copy) NSString *user_name;    //楼主名
     @property (nonatomic, copy) NSString *user_icon;    //楼主头像
     */
    
    //    int image_height = [model.image_height integerValue]/[model.image_width integerValue]*(Cell_W);
    
    //图片
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Cell_W, 80)];
    [imageView sd_setImageWithURL:[NSURL URLWithString:model.url]  placeholderImage:[UIImage imageNamed:@"placeHoder1.png"]];
    [view addSubview:imageView];
    
    //详情
    UILabel * descLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame), Cell_W, 30)];
    descLabel.text = model.desc;
    descLabel.numberOfLines = 0;
    descLabel.font = [UIFont systemFontOfSize:12];
    [view addSubview:descLabel];
    //标签
    UILabel * tagLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(descLabel.frame)+5, Cell_W, 20)];
    tagLabel.text = model.tag;
    tagLabel.font = [UIFont systemFontOfSize:12];
    tagLabel.textColor = [UIColor grayColor];
    [view addSubview:tagLabel];
    //楼主头像
    UIImageView * iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(2, CGRectGetMaxY(tagLabel.frame)+5, 30, 30)];
    [iconImageView sd_setImageWithURL:[NSURL URLWithString:model.user_icon] placeholderImage:[UIImage imageNamed:@"placeHoder1.png"]];
    [view addSubview:iconImageView];
    // 圆角
    iconImageView.layer.cornerRadius = iconImageView.frame.size.width/2;
    // 剪裁 [子视图不能超过父视图]
    iconImageView.clipsToBounds = YES;
    //楼主昵称
    UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(iconImageView.frame)+5, CGRectGetMinY(iconImageView.frame), 50, 30)];
    nameLabel.font = [UIFont systemFontOfSize:12];
    nameLabel.text = model.user_name;
    [view addSubview:nameLabel];
    //点赞人数
    UILabel * zanLabel = [[UILabel alloc]initWithFrame:CGRectMake(Cell_W-20, CGRectGetMinY(iconImageView.frame), 20, 30)];
    zanLabel.text = model.likes;
    zanLabel.font = [UIFont systemFontOfSize:12];
    [view addSubview:zanLabel];
    //点赞图标
    UIImageView * zanImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(zanLabel.frame)-35, CGRectGetMinY(iconImageView.frame), 30, 30)];
    zanImageView.image = [UIImage imageNamed:@"zan_inlist.png"];
    [view addSubview:zanImageView];
    
    [cell.contentView addSubview:view];
    
    return cell;
}
#pragma mark-collectionView代理方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeVCModel * model = _dataArray[indexPath.row];
    DetailVC * detailVC = [DetailVC new];
    detailVC.url = model.user_url;
    NSLog(@"%@",detailVC.url);
    detailVC.title = @"笔记详情";
    
    
    WebVC *vc = [[WebVC alloc]initWithNavigationController:self.navigationController endURL:model.user_url];
    
    [self.navigationController pushViewController:vc animated:YES];

    
//    [self.navigationController pushViewController:detailVC animated:YES];
}
//请求数据
#pragma mark-2.getData
-(void)getData{
    NetWork * net = [NetWork new];
    net.delegate = self;
    [net getDataForHomeVC];
}
//数据回调
#pragma mark-3.callBack
-(void)DataCallBackForHomeVC:(NSArray *)array{
    
    [_dataArray addObjectsFromArray: array];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [_collectionView reloadData];
        
    });
    
}


#pragma mark - 1.添加视图
-(void)addViews{
    [self.view addSubview:self.collectionView];
}

#pragma mark - 2.适配
- (void)defineLayout {
    
}

#pragma mark - 3.关联
- (void)bindWithViewModel {
    
}
@end
