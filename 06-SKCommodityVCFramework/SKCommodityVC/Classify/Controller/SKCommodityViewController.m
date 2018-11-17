//
//  SKCommodityViewController.m
//  SKCommodityVC
//
//  Created by sunke on 2017/3/27.
//  Copyright © 2017年 SK. All rights reserved.
//

#import "SKCommodityViewController.h"

// Vendors
#import <MJExtension/MJExtension.h>
#import <Masonry.h>

// Models
#import "SKClassGoodsItem.h"
#import "SKClassMianItem.h"

// Views
#import "SKClassCategoryCell.h"

#import "SKGoodsSortCell.h"
#import "SKBrandSortCell.h"
#import "SKBrandsSortHeadView.h"


@interface SKCommodityViewController ()<UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

/* tableView */
@property (strong , nonatomic)UITableView *tableView;
/* collectionViw */
@property (strong , nonatomic)UICollectionView *collectionView;

/* 左边数据 数组 */
@property (strong , nonatomic)NSMutableArray<SKClassGoodsItem *> *titleItemArr;
/* 右边数据 数组*/
@property (strong , nonatomic)NSMutableArray<SKClassMianItem *> *mainItemArr;

@end

static NSString *const SKClassCategoryCellID = @"SKClassCategoryCell";
static NSString *const SKGoodsSortCellID = @"SKGoodsSortCell";
static NSString *const SKBrandSortCellID = @"SKBrandSortCell";
static NSString *const SKBrandsSortHeadViewID = @"SKBrandsSortHeadView";


@implementation SKCommodityViewController

#pragma mark - LazyLoad
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.frame = CGRectMake(0, SKTopNavH, tableViewH, ScreenH - SKTopNavH);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_tableView];
        
        [_tableView registerClass:[SKClassCategoryCell class] forCellReuseIdentifier: SKClassCategoryCellID];
    }
    return _tableView;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.minimumInteritemSpacing = 3; //X
        layout.minimumLineSpacing = 5;  //Y
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [self.view addSubview:_collectionView];
        
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.frame = CGRectMake(tableViewH + 5, SKTopNavH, ScreenW - tableViewH - SKMargin, ScreenH - SKTopNavH);
        //注册Cell
        [_collectionView registerClass:[SKGoodsSortCell class] forCellWithReuseIdentifier:SKGoodsSortCellID];
        [_collectionView registerClass:[SKBrandSortCell class] forCellWithReuseIdentifier:SKBrandSortCellID];
        //注册Header
        [_collectionView registerClass:[SKBrandsSortHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:SKBrandsSortHeadViewID];
    }
    return _collectionView;
}



- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor redColor];
    
    //初始化
    [self setUpTab];
    
    //加载数据
    [self setUpData];
    
    
    

}

#pragma mark - 加载数据
- (void)setUpData
{
    _titleItemArr = [SKClassGoodsItem mj_objectArrayWithFilename:@"ClassifyTitles.plist"];
    _mainItemArr = [SKClassMianItem mj_objectArrayWithFilename:@"ClassiftyGoods01.plist"];
    //默认选择第一行（注意一定要在加载完数据之后）
    [_tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
}

#pragma mark - initizlize
- (void)setUpTab
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.backgroundColor = SKBGColor;
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    self.tableView.tableFooterView = [UIView new];
}


#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titleItemArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SKClassCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:SKClassCategoryCellID forIndexPath:indexPath];
    cell.titleItem = _titleItemArr[indexPath.row];
    
    return cell;
}

#pragma mark - <UITableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _mainItemArr = [SKClassMianItem mj_objectArrayWithFilename:_titleItemArr[indexPath.row].fileName];
    [self.collectionView reloadData];
}


#pragma mark - <UICollectionViewDataSource>
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _mainItemArr.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _mainItemArr[section].goods.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *gridcell = nil;
    if ([_mainItemArr[_mainItemArr.count - 1].title isEqualToString:@"热门品牌"]) {
        if (indexPath.section == _mainItemArr.count - 1) {//品牌
            SKBrandSortCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SKBrandSortCellID forIndexPath:indexPath];
            cell.subItem = _mainItemArr[indexPath.section].goods[indexPath.row];
            gridcell = cell;
        }
        else {//商品
            SKGoodsSortCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SKGoodsSortCellID forIndexPath:indexPath];
            cell.subItem = _mainItemArr[indexPath.section].goods[indexPath.row];
            gridcell = cell;
        }
    }else{//商品
        SKGoodsSortCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SKGoodsSortCellID forIndexPath:indexPath];
        cell.subItem = _mainItemArr[indexPath.section].goods[indexPath.row];
        gridcell = cell;
    }
    
    return gridcell;
}

//设置UICollectionView 的headerView
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {

    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader){

        SKBrandsSortHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:SKBrandsSortHeadViewID forIndexPath:indexPath];
        headerView.headTitle = _mainItemArr[indexPath.section];
        reusableview = headerView;
    }
    return reusableview;
}

#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([_mainItemArr[_mainItemArr.count - 1].title isEqualToString:@"热门品牌"]) {
        if (indexPath.section == _mainItemArr.count - 1) {//品牌
            return CGSizeMake((ScreenW - tableViewH - 6 - SKMargin)/3, 60);
        }else{//商品
            return CGSizeMake((ScreenW - tableViewH - 6 - SKMargin)/3, (ScreenW - tableViewH - 6 - SKMargin)/3 + 20);
        }
    }else{
        return CGSizeMake((ScreenW - tableViewH - 6 - SKMargin)/3, (ScreenW - tableViewH - 6 - SKMargin)/3 + 20);
    }
    return CGSizeZero;
}
#pragma mark - head宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(ScreenW, 25);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了个第%zd分组第%zd几个Item",indexPath.section,indexPath.row);
    
    
}

@end
