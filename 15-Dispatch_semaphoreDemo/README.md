# Dispatch_semaphoreDemo




![各个lock性能对比.png](https://upload-images.jianshu.io/upload_images/126164-c159b23a2006988a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 定义： 
+ 1> 信号量：就是一种可用来控制访问资源的数量的标识，设定了一个信号量，在线程访问之前，加上信号量的处理，则可告知系统按照我们指定的信号量数量来执行多个线程。

其实，这有点类似锁机制了，只不过信号量都是系统帮助我们处理了，我们只需要在执行线程之前，设定一个信号量值，并且在使用时，加上信号量处理方法就行了。

+ 2> 信号量主要有3个函数，分别是：
```
// 创建信号量 . 该函数接收一个long类型的参数, 返回一个dispatch_semaphore_t类型的信号量，值为传入的参数
dispatch_semaphore_t   dispatch_semaphore_create(long value)

//等待降低信号量 . 接收一个信号和时间值，若信号的信号量为0，则会阻塞当前线程，直到信号量大于0或者经过输入的时间值；若信号量大于0，则会使信号量减1并返回，程序继续住下执行
long  dispatch_semaphore_wait(dispatch_semaphore_t dsema, dispatch_time_t timeout)

// 提高信号量.  使信号量加1并返回
long dispatch_semaphore_signal(dispatch_semaphore_t dsema)

//dispatch_semaphore_wait() 与 dispatch_semaphore_signal() 成对使用
```

### dispatch_semaphore 简单使用
```objc
- (void)dispatchSignal{
    //crate的value表示，最多几个资源可访问
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(2);   
    dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
     
    //任务1
    dispatch_async(quene, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"run task 1");
        sleep(1);
        NSLog(@"complete task 1");
        dispatch_semaphore_signal(semaphore);       
    });<br>
    //任务2
    dispatch_async(quene, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"run task 2");
        sleep(1);
        NSLog(@"complete task 2");
        dispatch_semaphore_signal(semaphore);       
    });<br>
    //任务3
    dispatch_async(quene, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"run task 3");
        sleep(1);
        NSLog(@"complete task 3");
        dispatch_semaphore_signal(semaphore);       
    });   
}

```

+ 执行结果：

![log1](https://upload-images.jianshu.io/upload_images/126164-ac3797caa97516ab.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


总结：由于设定的信号值为2，先执行两个线程，等执行完一个，才会继续执行下一个，保证同一时间执行的线程数不超过2。

+ 这里我们扩展一下，假设我们设定信号值=1
```
dispatch_semaphore_create(1)
```

那么结果就是：

![log2.png](https://upload-images.jianshu.io/upload_images/126164-e42309a8981106ba.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


+ 如果设定信号值=3
```
dispatch_semaphore_create(3)
```
那么结果就是： 
![log3.png](https://upload-images.jianshu.io/upload_images/126164-dc208f728f0d6ea0.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


其实设定为3，就是不限制线程执行了，因为一共才只有3个线程。


### dispatch_semaphore 作用
+ dispatch_semaphore有两个主要应用 ：
1. 保持线程同步
2. 为线程加锁

#### dispatch_semaphore 保持线程同步
```objc
// dispatch_semaphore 保持线程同步
- (void)syncThread{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    __block int j = 0;
    dispatch_async(queue, ^{
        j = 100;
        dispatch_semaphore_signal(semaphore);
    });
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    NSLog(@"finish j = %d", j);
}
```
结果输出 j ＝ 100；
如果注掉dispatch_semaphore_wait这一行，则 j ＝ 0；
**原理：** 由于是将block异步添加到一个并行队列里面，所以程序在主线程跃过block直接到`dispatch_semaphore_wait`这一行，因为`semaphore`信号量为0，时间值为`DISPATCH_TIME_FOREVER`，所以当前线程会一直阻塞，直到block在子线程执行到`dispatch_semaphore_signal`，使信号量+1，此时`semaphore`信号量为1了，所以程序继续往下执行。这就保证了线程间同步了。


#### dispatch_semaphore 线程加锁
```objc
// dispatch_semaphore 线程加锁
- (void)lockThread{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    
    for (int i = 0; i < 100; i++) {
        dispatch_async(queue, ^{
            // 相当于加锁
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            NSLog(@"i = %d semaphore = %@", i, semaphore);
            // 相当于解锁
            dispatch_semaphore_signal(semaphore);
        });
    }
}

```
**原理：**当线程1执行到`dispatch_semaphore_wait`这一行时，`semaphore`的信号量为1，所以使信号量-1变为0，并且线程1继续往下执行；如果当在线程1NSLog这一行代码还没执行完的时候，又有线程2来访问，执行`dispatch_semaphore_wait`时由于此时信号量为0，且时间为`DISPATCH_TIME_FOREVER`,所以会一直阻塞线程2（此时线程2处于等待状态），直到线程1执行完NSLog并执行完`dispatch_semaphore_signal`使信号量为1后，线程2才能解除阻塞继续住下执行。以上可以保证同时只有一个线程执行NSLog这一行代码。




