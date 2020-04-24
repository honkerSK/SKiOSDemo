# SKTopSlideTitleBarFramework

顶部滑动标题栏

<img src="https://github.com/honkerSK/SKiOSDemo/blob/master/08-SKTopSlideTitleBarFramework/SKTopSlideTitleBarFramework.gif" width="500" alt="SKTopSlideTitleBarFramework"></img>


原理:
+ 1.将精华控制器(SKEssenceViewController)中的所有子控制器的view添加到scrollView 上.
+ 2.scrollView滑动完毕的时候调用(速度减为0的时候调用), scrollView 代理方法
```
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
NSInteger index = scrollView.contentOffset.x / scrollView.sk_width;
SKTitleButton *titleButton = self.titlesView.subviews[index];
[self titleButtonClick:titleButton];
}

```

+ 3.自定义菜单按钮 监听按钮点击, 做动画,添加index位置的子控制器view到scrollView中
```
- (void)titleButtonClick:(SKTitleButton *)titleButton

```

