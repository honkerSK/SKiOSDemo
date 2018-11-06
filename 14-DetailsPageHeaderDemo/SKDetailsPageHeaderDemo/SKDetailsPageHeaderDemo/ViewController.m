//
//  ViewController.m
//  SKDetailsPageHeaderDemo
//
//  Created by sunke on 7/11/2018.
//  Copyright © 2018 sunke. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+color.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

/** tableView开始位置 */
@property (nonatomic, assign) CGFloat oriOffsetY;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headConsH;

// 注意:不能用imageView的顶部Y值,要使用整个头部视图的Y
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headConsY;

/** label */
@property (nonatomic, weak) UILabel *label;

@end

@implementation ViewController


static NSString *ID = @"cell";

#define SKHeadH 200
#define SKHeadMinH 60

#define SKTabBarH 44


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    // 注册cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID ];
    
    // 设置导航条
    [self setUpNavBar];
    
    // 记录头部原始Y的偏移量
    _oriOffsetY = - (SKHeadH + SKTabBarH);
    
    // 设置tableView 额外顶部滚动区域244
    // tableView只要设置顶部额外滚动区域,就会把内容往下挤
    self.tableView.contentInset = UIEdgeInsetsMake(SKHeadH + SKTabBarH, 0, 0, 0);
    
    // 设置 导航条标题
    //1.添加label
    UILabel *label = [[UILabel alloc] init];
    label.text = @"微博个人详情页";
    //2.自动文字计算label大小
    [label sizeToFit];
    
    //3.设置label文字颜色,一开始为透明
    label.textColor = [UIColor colorWithWhite:0.0 alpha:0.0];
    //4.将设置好的label 保存给属性
    _label = label;
    //5.添加到navigationItem上
    self.navigationItem.titleView = label;
    
}

// 设置导航条
- (void)setUpNavBar {
    //1.设置当前控制器不要调节ScrollView
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //2.隐藏导航控制器
    
    // 将导航条背景色设置为透明
    // 必须传入UIBarMetricsDefault
    // 注意:传入空图片image对象,快速隐藏导航条背景图片
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
    
    //3.清空导航条阴影
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
}

#pragma mark - 监听滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //    NSLog(@"%f", scrollView.contentOffset.y);
    
    //1.获取当前滚动区域
    CGFloat curOffSetY = scrollView.contentOffset.y;
    
    //2.计算下当前用户滚动多少 = 当前Y - 原始位置Y
    CGFloat diffe = curOffSetY - _oriOffsetY;
    
    //    NSLog(@"diffe = %f", diffe);
    
    //3.修改头部视图的y值
    // 只能保证用户滚多少,头部视图就滚多少
    //    _headConsY.constant = 0 - diffe;
    
    //视觉差效果
    //3.1 计算下当前头部视图高度
    CGFloat h = SKHeadH - diffe;
    if (h < SKHeadMinH) {
        h = SKHeadMinH;
    }
    _headConsH.constant = h;
    
    //    NSLog(@"_headConsH = %f", h);
    //3.2 设置图片模式 aspectFill ,并且裁剪
    
    //4. 设置导航条透明度
    //4.1 设置alpha
    CGFloat alpha = diffe / (SKHeadH - SKHeadMinH);
    // alpha 为0 系统是进行设置
    if (alpha >= 1) {
        alpha = 0.99;
    }
    
    //4.2 设置颜色
    UIColor *white = [UIColor colorWithWhite:1.0 alpha:alpha];
    // 导入分类,使用分类方法
    UIImage *image = [UIImage imageWithColor:white];
    //4.3 设置导航背景图片透明度
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    
    // 5.修改label 文字颜色
    _label.textColor = [UIColor colorWithWhite:0.0 alpha:alpha];
    
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%lu", indexPath.row];
    
    return cell;
}





@end
