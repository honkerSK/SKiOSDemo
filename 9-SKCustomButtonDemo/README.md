# SKCustomButtonDemo
自定义按钮的5种方式


+ 方案1: 使用UIButton属性contentEdgeInsets、titleEdgeInsets、imageEdgeInsets；（基本的视图属性，三个属性的设置效果可在XIB或storyboard中观察出来，常用属性）。

+ 方案2：使用 -(void)layoutSubviews;方法，在这个方法中获取子视图UIImageView, UILabel重新对子视图的位置调整。（常用的方法）
 
+ 方案3：使用视图位置调整方法（这个用的少）
```
 - (CGRect)contentRectForBounds:(CGRect)bounds;
 - (CGRect)titleRectForContentRect:(CGRect)contentRect;
 - (CGRect)imageRectForContentRect:(CGRect)contentRect;
 ```

+ 方案4：不使用系统按钮的子视图属性，自己在自定义的控件上添上UIImageView和UILabel视图（常用的方法）
 
+ 方案5：使用objective-c中runtime的方法或属性替换，针对上面的方法和属性进行替换。
 
+ 注意点：在UIButton中titleLabel和imageView子视图属性是只读的，不可以直接修改。
