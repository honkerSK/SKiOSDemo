//
//  SKEssenceViewController.m
//  SKTopSlideTitleBar
//
//  Created by sunke on 2017/7/23.
//  Copyright © 2017年 SK. All rights reserved.
//

#import "SKEssenceViewController.h"

//controller
#import "SKAllTableVC.h"
#import "SKPictureTableVC.h"
#import "SKVideoTableVC.h"
#import "SKVoiceTableVC.h"
#import "SKWordTableVC.h"

//view
#import "SKTitleButton.h"


@interface SKEssenceViewController () <UIScrollViewDelegate>
/** 用来显示所有子控制器view的scrollView */
@property (nonatomic, weak) UIScrollView *scrollView;
/** 标题栏 */
@property (nonatomic, weak) UIView *titlesView;
/** 标题下划线 */
@property (nonatomic, weak) UIView *titleUnderline;
/** 上一次点击的标题按钮 */
@property (nonatomic, weak) SKTitleButton *previousClickedTitleButton;

@end

@implementation SKEssenceViewController

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];

    //1.设置导航条内容
    [self setupNavBar];
    
    //2.初始化子控制器
    [self setupChildVcs];
    
    //3.初始化scrollView
    [self setupScrollView];
    
    //4.初始化标题栏
    [self setupTitlesView];
    
    //5.默认显示第0个子控制器的view
    [self addChildVcViewIntoScrollView:0];
    
    
}


/* 1.设置导航条内容 */
- (void)setupNavBar{
    //左边
    UIBarButtonItem *leftItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"nav_item_game_icon"] lightImage:[UIImage imageNamed:@"nav_item_game_click_icon"] target:self action:@selector(game)];
    
    self.navigationItem.leftBarButtonItem =  leftItem;
    
    //右边
    UIBarButtonItem *rightItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"navigationButtonRandom"] lightImage:[UIImage imageNamed:@"navigationButtonRandomClick"] target:self action:@selector(random)];
    
    self.navigationItem.rightBarButtonItem =  rightItem;
    
    //中间 titleView
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
}

- (void)game {
    NSLog(@"点击游戏按钮");
}

- (void)random {
    NSLog(@"点击随机按钮");
}


/**
 *  2.初始化子控制器
 */
- (void)setupChildVcs {
    [self addChildViewController:[[SKAllTableVC alloc] init]];
    [self addChildViewController:[[SKVideoTableVC alloc] init]];
    [self addChildViewController:[[SKVoiceTableVC alloc] init]];
    [self addChildViewController:[[SKPictureTableVC alloc] init]];
    [self addChildViewController:[[SKWordTableVC alloc] init]];
}


/**
 *  3.初始化scrollView
 */
- (void)setupScrollView {
    NSInteger count = self.childViewControllers.count;
    
    // 不要去自动调整scrollView的内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.delegate = self;
    // 点击状态栏时,这个scrollView不需要滚动到顶部
    scrollView.scrollsToTop = NO;
    scrollView.frame = self.view.bounds;
    scrollView.backgroundColor = [UIColor greenColor];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    // 其他设置
    scrollView.contentSize = CGSizeMake(count * scrollView.sk_width, 0);
    scrollView.pagingEnabled = YES;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
}

/**
 *  4.初始化标题栏
 */
- (void)setupTitlesView {
    UIView *titlesView = [[UIView alloc] init];
    titlesView.frame = CGRectMake(0, SKNavBarMaxY, self.view.sk_width, SKTitlesViewH);
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    // 标题按钮
    [self setupTitleButtons];
    
    // 下划线
    [self setupTitleUnderline];
}

/**
 *  下划线
 */
- (void)setupTitleUnderline {
    // 取出标题按钮
    SKTitleButton *firstTitleButton = self.titlesView.subviews.firstObject;
    
    UIView *titleUnderline = [[UIView alloc] init];
    CGFloat titleUnderlineH = 2;
    CGFloat titleUnderlineY = self.titlesView.sk_height - titleUnderlineH;
    titleUnderline.frame = CGRectMake(0, titleUnderlineY, 0, titleUnderlineH);
    titleUnderline.backgroundColor = [firstTitleButton titleColorForState:UIControlStateSelected];
    [self.titlesView addSubview:titleUnderline];
    self.titleUnderline = titleUnderline;
    
    // 新点击的按钮 -> 红色
    firstTitleButton.selected = YES;
    self.previousClickedTitleButton = firstTitleButton;
    
    // 下划线
    [firstTitleButton.titleLabel sizeToFit];
    self.titleUnderline.sk_width = firstTitleButton.titleLabel.sk_width + 10;
    self.titleUnderline.sk_centerX = firstTitleButton.sk_centerX;
}

/**
 *  标题按钮
 */
- (void)setupTitleButtons {
    NSArray *titles = @[@"全部", @"视频", @"声音", @"图片", @"段子"];
    NSUInteger count = titles.count;
    CGFloat titleButtonH = self.titlesView.sk_height;
    CGFloat titleButtonW = self.titlesView.sk_width / count;
    
    for (NSInteger i = 0; i < count; i++) {
        SKTitleButton *titleButton = [[SKTitleButton alloc] init];
        titleButton.tag = i;
        [titleButton setTitle:titles[i] forState:UIControlStateNormal];
        [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        titleButton.frame = CGRectMake(i * titleButtonW, 0, titleButtonW, titleButtonH);
        [self.titlesView addSubview:titleButton];
    }
}

#pragma mark - 其他
/**
 *  5.添加index位置的子控制器view到scrollView中
 */
- (void)addChildVcViewIntoScrollView:(NSInteger)index {
    // 取出index位置对应的子控制器
    UIViewController *childVc = self.childViewControllers[index];
    if (childVc.isViewLoaded) return;
    //    if (childVc.view.superview) return;
    //    if (childVc.view.window) return;
    //    if ([self.scrollView.subviews containsObject:childVc.view]) return;
    
    // 设置frame
    childVc.view.frame = CGRectMake(index * self.scrollView.sk_width, 0, self.scrollView.sk_width, self.scrollView.sk_height);
    // 添加
    [self.scrollView addSubview:childVc.view];
    
    //SKLog(@"childVc.view.frame.y-%f", childVc.view.sk_y);
}

#pragma mark - <UIScrollViewDelegate>
/**
 *  scrollView滑动完毕的时候调用(速度减为0的时候调用)
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x / scrollView.sk_width;
    SKTitleButton *titleButton = self.titlesView.subviews[index];
    [self titleButtonClick:titleButton];
}


#pragma mark - 监听点击
/**
 *  监听标题按钮点击
 */
- (void)titleButtonClick:(SKTitleButton *)titleButton {
    // 修改按钮的状态
    // 上一个点击的按钮 -> 暗灰色
    self.previousClickedTitleButton.selected = NO;
    // 新点击的按钮 -> 红色
    titleButton.selected = YES;
    self.previousClickedTitleButton = titleButton;
    
    NSInteger index = titleButton.tag;
    [UIView animateWithDuration:0.25 animations:^{
        // 下划线
        self.titleUnderline.sk_width = titleButton.titleLabel.sk_width + 10;
        self.titleUnderline.sk_centerX = titleButton.sk_centerX;
        
        // 滑动scrollView到对应的子控制器界面
        CGPoint offset = self.scrollView.contentOffset;
        offset.x = index * self.scrollView.sk_width;
        self.scrollView.contentOffset = offset;
    } completion:^(BOOL finished) {
        // 添加index位置的子控制器view到scrollView中
        [self addChildVcViewIntoScrollView:index];
    }];
    
    // 控制scrollView的scrollsToTop属性
    for (NSInteger i = 0; i < self.childViewControllers.count; i++) {
        UIViewController *childVc = self.childViewControllers[i];
        
        // 如果控制器的view没有被创建,跳过
        if (!childVc.isViewLoaded) continue;
        
        // 如果控制器的view不是scrollView,就跳过
        if (![childVc.view isKindOfClass:[UIScrollView class]]) continue;
        
        // 如果控制器的view是scrollView
        UIScrollView *scrollView = (UIScrollView *)childVc.view;
        scrollView.scrollsToTop = (i == index);
        //        if (i == index) { // 被点击按钮对应的子控制器
        //            scrollView.scrollsToTop = YES;
        //        } else {
        //            scrollView.scrollsToTop = NO;
        //        }
    }
}


@end
