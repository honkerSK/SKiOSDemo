# RuntimeDictToModelDemo
runtime 字典转模型

> 将后台JSON数据中的字典转成本地的模型，我们一般选用部分优秀的第三方框架，如SBJSON、JSONKit、MJExtension、YYModel等。但是，一些简单的数据，我们也可以尝试自己来实现转换的过程。


## 快速使用
当我们的请求到的数据不是很复杂, 也不希望引入第三方框架的时候, 可以使用下这个分类, 来实现字典转模型.

### 1.根据请求数据, 创建对应的模型类, 并根据字典中的键值对定义对应的属性
+ 创建模型原则: 从外层到内存, 一个类型字典对应一个模型
+ 示例程序中, 根据plist, 创建了三个类: ShopItem , AttrModel , ListItemModel 


<img src="https://github.com/honkerSK/SKiOSDemo/blob/master/1-RuntimeDictToModelDemo/runtime-pic1.png" width="500" alt="RuntimeDictToModelDemo"></img>


+ 注意: 定义的属性名和字典中的键名字一致.

### 2.在分类中导入最外层模型

<img src="https://github.com/honkerSK/SKiOSDemo/blob/master/1-RuntimeDictToModelDemo/runtime-pic2.png" width="500" alt="RuntimeDictToModelDemo"></img>


### 3.最外层类中导入 NSObject+EnumDict 分类

<img src="https://github.com/honkerSK/SKiOSDemo/blob/master/1-RuntimeDictToModelDemo/runtime-pic3.png" width="500" alt="RuntimeDictToModelDemo"></img>

### 4.遵守分类协议 ModelDelegate, 实现协议方法

<img src="https://github.com/honkerSK/SKiOSDemo/blob/master/1-RuntimeDictToModelDemo/runtime-pic4.png" width="500" alt="RuntimeDictToModelDemo"></img>


### 5.控制器中, 导入最外层模型 ShopItem.h , 解析数据遍历数组, 并字典转模型

<img src="https://github.com/honkerSK/SKiOSDemo/blob/master/1-RuntimeDictToModelDemo/runtime-pic5.png" width="500" alt="RuntimeDictToModelDemo"></img>



