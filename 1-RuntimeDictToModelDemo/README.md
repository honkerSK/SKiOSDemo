# runtime-dictToModel
runtime 字典转模型

> 将后台JSON数据中的字典转成本地的模型，我们一般选用部分优秀的第三方框架，如SBJSON、JSONKit、MJExtension、YYModel等。但是，一些简单的数据，我们也可以尝试自己来实现转换的过程。


## 快速使用
当我们的请求到的数据不是很复杂, 也不希望引入第三方框架的时候, 可以使用下这个分类, 来实现字典转模型.

### 1.根据请求数据, 创建对应的模型类, 并根据字典中的键值对定义对应的属性
+ 创建模型原则: 从外层到内存, 一个类型字典对应一个模型
+ 示例程序中, 根据plist, 创建了三个类: ShopItem , AttrModel , ListItemModel 

![runtime-pic1.png](https://upload-images.jianshu.io/upload_images/126164-b08f62ddfa2ceaa4.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

+ 注意: 定义的属性名和字典中的键名字一致.

### 2.在分类中导入最外层模型

![runtime-pic2.png](https://upload-images.jianshu.io/upload_images/126164-7232ec2b19a8c4ef.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 3.最外层类中导入 NSObject+EnumDict 分类

![runtime-pic3.png](https://upload-images.jianshu.io/upload_images/126164-9b1b653825878152.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 4.遵守分类协议 ModelDelegate, 实现协议方法

![runtime-pic4.png](https://upload-images.jianshu.io/upload_images/126164-7ed2752967e441d8.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


### 5.控制器中, 导入最外层模型 ShopItem.h , 解析数据遍历数组, 并字典转模型

![runtime-pic5.png](https://upload-images.jianshu.io/upload_images/126164-5a93c23ce6b12585.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)



