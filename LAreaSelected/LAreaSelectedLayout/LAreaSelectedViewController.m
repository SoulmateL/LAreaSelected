//
//  LAreaSelectedViewController.m
//  LAreaSelected
//
//  Created by 俊杰  廖 on 2017/3/8.
//  Copyright © 2017年 俊杰  廖. All rights reserved.
//

#import "LAreaSelectedViewController.h"
#import "LAreaSelectedLayout.h"
#import "CollectionViewCell.h"
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface LAreaSelectedViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,LAreaSelectedDelegate>
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSDictionary *datas;
@property (nonatomic,strong) UITableView *tableview;
@property (nonatomic,strong) NSArray *county;
@property (nonatomic,strong) NSArray *province;
@property (nonatomic,assign) NSInteger currentProvince;
@end
static CGFloat provinceFontSize = 17;
static CGFloat countyFontSize = 20;
@implementation LAreaSelectedViewController

- (instancetype)initSelectedViewControllerWithDatas:(NSDictionary *)datas {
    if (self = [super init]) {
        self.datas = datas;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableview];
    [self.view addSubview:self.collectionView];
    self.navigationController.navigationBar.translucent = NO;
}



#pragma UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.province.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"province";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.font = [UIFont systemFontOfSize:provinceFontSize];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.text = self.province[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _currentProvince = indexPath.row;
    [self.collectionView reloadData];
}

#pragma UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSLog(@"%ld",self.county.count);
    
    return self.county.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"county" forIndexPath:indexPath];
    cell.label.frame = cell.bounds;
    cell.label.text = self.county[indexPath.row];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"选择了%@",self.county[indexPath.row]);
}

#pragma LAreaSelectedDelegate

- (CGFloat)minimumLineSpacing:(UICollectionViewLayout *)layout {
    return 10;
}
- (CGFloat)minimumInteritemSpacing:(UICollectionViewLayout *)layout {
    return 10;
}

- (UIEdgeInsets)collectionEdgeInsets:(UICollectionViewLayout *)layout {
    return  UIEdgeInsetsMake(10, 10, 10, 10);
}

- (CGSize)getContentSize:(UICollectionViewLayout *)layout indexPath:(NSIndexPath *)indexPath {
    NSString *text = self.county[indexPath.row];
    CGSize size = [text sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:countyFontSize]}];
    return size;
}

- (UITableView *)tableview {
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 120, ScreenHeight) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _currentProvince = 0;
        [_tableview selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
    }
    return _tableview;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        LAreaSelectedLayout *layout = [[LAreaSelectedLayout alloc] init];
        layout.delegate = self;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(120, 0, ScreenWidth-120, ScreenHeight) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"county"];
    }
    return _collectionView;
}

//数据源可根据不同的数据结构做出相应的改变
- (NSArray *)province {
    if (!_province) {
      
        _province = [self.datas allKeys];
    }
    return _province;
}

- (NSArray *)county {
    NSString *currentProvinceName = self.province[_currentProvince];
    _county = [self.datas objectForKey:currentProvinceName];
    return _county;
}

@end
