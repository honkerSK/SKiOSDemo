//
//  SKMagicMoveController.m
//  SKTransitonAdvance
//
//  Created by sunke on 16/8/17.
//  Copyright © 2016年 SK. All rights reserved.
//

#import "SKMagicMoveController.h"
#import "SKMagicMoveCell.h"
#import "SKMagicMovePushController.h"

@interface SKMagicMoveController ()<UINavigationControllerDelegate>


@end

@implementation SKMagicMoveController

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)init {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(150, 180);
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 10;
    
    self = [super initWithCollectionViewLayout:layout];
    
    return self;
}

 
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"神奇移动";
    self.collectionView.backgroundColor = [UIColor whiteColor];
    //注册cell
    [self.collectionView registerNib:[UINib nibWithNibName:@"SKMagicMoveCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backToRoot)];
    self.navigationItem.leftBarButtonItem = back;
}

- (void)backToRoot{
    
    //一定要给导航控制器设置代理
    self.navigationController.delegate = self;
    [self.navigationController popViewControllerAnimated:true];
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SKMagicMoveCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    return cell;
}

#pragma mark UICollectionViewDataSource代理方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    _currentIndexPath = indexPath;
    
    SKMagicMovePushController *magicPushVC = [[SKMagicMovePushController alloc] init];
    //设置导航控制器的代理为推出的控制器，可以达到自定义不同控制器的退出效果的目的
    //注意:一定要设置代理
    self.navigationController.delegate = magicPushVC;
    
    [self.navigationController pushViewController:magicPushVC animated:true];
    
}



@end
