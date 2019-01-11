# SKTransitonAdvance 转场动画的手势交互

### 一.实现转场动画需要封装两个类:

+ 一个是转场动画管理者,专门用于处理转场动画,
+ 一个手势管理者类,专门管理手势交互.

### 二.转场动画管理者

**实现步骤:**

+ 1.遵守协议<UIViewControllerAnimatedTransitioning>
负责切换的具体内容，也即“切换中应该发生什么”

+ 2.实现协议中两个方法:
```objc
//系统给出一个切换上下文，我们根据上下文环境返回这个切换所需要的花费时间
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
} 
//在进行切换的时候将调用该方法，我们对于切换时的UIView的设置和动画都在这个方法中完成
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {  }
```
+ 3.在调用animateTransition: 方法时候,需要获得两个控制器:原来控制器和做动画的控制器,使用以下方法获取.
```
//通过viewControllerForKey取出转场前后的两个控制器，这里toVC就是vc1、fromVC就是vc2
UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
```

+ 4.在调用animateTransition: 方法时候,对源控制器视图截图,
使用方法 snapshotViewAfterScreenUpdates:
snapshotViewAfterScreenUpdates可以对某个视图截图，我们采用对这个截图做动画代替直接对源控制器做动画，因为在手势过渡中直接使用vc1动画会和手势有冲突，如果不需要实现手势的话，就可以不是用截图视图

+ 5. containerView概念: 
如果要对视图做转场动画，视图就必须要加入containerView中才能进行，可以理解containerView管理者所有做转场动画的视图
 + 6.使用UIView的动画延时方法,做动画

### 三.动画控制器需要遵守协议, 实现方法


+ 控制器之间转场需要遵守<UIViewControllerTransitioningDelegate>协议,实现以下方法:
```
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source;

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed;
```

+ 导航器之间跳转需要遵守<UINavigationControllerDelegate> 协议,实现以下方法:
```
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {}
```

### 四.手势管理者

+ 1.定义手势管理者,继承自UIPercentDrivenInteractiveTransition
从iOS 7开始, 添加一个交互式切换类 UIPercentDrivenInteractiveTransition.
在手势识别中只需要告诉这个类的实例当前的状态百分比如何，系统便根据这个百分比和我们之前设定的迁移方式为我们计算当前应该的UI渲染

+ 2.根据手势状态,分别调用这个几个方法
```
-(void)updateInteractiveTransition:(CGFloat)percentComplete;
更新百分比，一般通过手势识别的长度之类的来计算一个值，然后进行更新。

-(void)cancelInteractiveTransition; 报告交互取消，返回切换前的状态
–(void)finishInteractiveTransition; 报告交互完成，更新到切换后的状态
```
+ 3.控制器之间model转场,实现 <UIViewControllerTransitioningDelegate> 协议中手势方法
```
- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator;

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator;
```
