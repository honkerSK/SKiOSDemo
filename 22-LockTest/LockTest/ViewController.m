//
//  ViewController.m
//  LockTest
//
//  Created by sunke on 2020/4/7.
//  Copyright © 2020 sunke. All rights reserved.
//

#import "ViewController.h"
#include <pthread.h>
#import <libkern/OSAtomic.h>

#import <os/lock.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self test];
}


/*
 9种锁 性能测试
 在开发中，多线程编程是必不可少的，多线程的线程安全也是要考虑的，可能最有印象的应该还是atomic属性吧，其次就是GCD的dispatch_semaphore。于是就总结了一下，iOS开发中的线程安全措施。大致有如下几种：
 
 atomic属性
 
 @synchronize(对象)
 
 NSLock 需要提一下，lock、unlock方法必须在一个线程调用，这里说的很清楚
 
 NSRecursiveLock 递归锁，能在同一个线程多次请求不会死锁
 
 NSCondition
 
 NSConditionLock
 
 OSSpinLock 自旋锁，被弃用了，因为存在优先级反转问题，苹果已经弃用，并用os_unfair_lock作为替代。需要引入头文件 #import <libkern/OSAtomic.h>
 
 os_unfair_lock 不公平的锁，就是解决优先级反转问题。 需要引入头文件 #import <os/lock.h>
 
 pthread_mutex 创建需由pthread_attr_t参数，如果参数attr为空，则使用默认的互斥锁属性，默认属性为快速互斥锁 。互斥锁的属性在创建锁的时候指定，不同的锁类型在试图对一个已经被锁定的互斥锁加锁时表现不同。（#define PTHREAD_MUTEX_NORMAL
 #define PTHREAD_MUTEX_ERRORCHECK
 
 #define PTHREAD_MUTEX_RECURSIVE 三种属性）至于不同属性的性能，都是一家的，在这里就不比较了
 
 dispatch_semaphore
 
 既然有这么多的实现方式，当然要一较高下，选择自己喜欢的方式，于是写了下面的测试代码比较性能：
 
 */
- (void)test{
    NSMutableArray *timeArr = [NSMutableArray array];
    CFTimeInterval start,end,cost;
    NSInteger count = 100000;
    NSArray *nameArr = @[@"OSSpinLock",@"NSLock",@"dispatch_semaphore",@"pthread_mutex",@"NSCondition",@"NSConditionLock",@"NSRecursiveLock",@"@synchronized",@"os_unfair_lock"];
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated"
    {
        OSSpinLock lock = OS_SPINLOCK_INIT;
        start = CFAbsoluteTimeGetCurrent();
        for (int i = 0; i < count; i++) {
            OSSpinLockLock(&lock);
            OSSpinLockUnlock(&lock);
        }
        end = CFAbsoluteTimeGetCurrent();
        cost = end - start;
        [timeArr addObject:@(cost)];
    }
#pragma clang pop
    
    
    {
        NSLock *lock = [NSLock new];
        start = CFAbsoluteTimeGetCurrent();
        for (int i = 0; i < count; i++) {
            [lock lock];
            [lock unlock];
        }
        end = CFAbsoluteTimeGetCurrent();
        cost = end - start;
        [timeArr addObject:@(cost)];
    }
    
    
    
    {
        dispatch_semaphore_t lock =  dispatch_semaphore_create(1);
        start = CFAbsoluteTimeGetCurrent();
        for (int i = 0; i < count; i++) {
            dispatch_semaphore_wait(lock, DISPATCH_TIME_FOREVER);
            dispatch_semaphore_signal(lock);
        }
        end = CFAbsoluteTimeGetCurrent();
        cost = end - start;
        [timeArr addObject:@(cost)];
    }
    
    
    {
        pthread_mutex_t lock;
        pthread_mutex_init(&lock, NULL);
        start = CFAbsoluteTimeGetCurrent();
        for (int i = 0; i < count; i++) {
            pthread_mutex_lock(&lock);
            pthread_mutex_unlock(&lock);
        }
        end = CFAbsoluteTimeGetCurrent();
        cost = end - start;
        [timeArr addObject:@(cost)];
    }
    
    {
        NSCondition *lock = [NSCondition new];
        start = CFAbsoluteTimeGetCurrent();
        for (int i = 0; i < count; i++) {
            [lock lock];
            [lock unlock];
        }
        end = CFAbsoluteTimeGetCurrent();
        cost = end - start;
        [timeArr addObject:@(cost)];
    }
    
    {
        NSConditionLock *lock = [[NSConditionLock alloc] initWithCondition:1];
        start = CFAbsoluteTimeGetCurrent();
        for (int i = 0; i < count; i++) {
            [lock lock];
            [lock unlock];
        }
        end = CFAbsoluteTimeGetCurrent();
        cost = end - start;
        [timeArr addObject:@(cost)];
    }
    
    {
        NSRecursiveLock *lock = [NSRecursiveLock new];
        start = CFAbsoluteTimeGetCurrent();
        for (int i = 0; i < count; i++) {
            [lock lock];
            [lock unlock];
        }
        end = CFAbsoluteTimeGetCurrent();
        cost = end - start;
        [timeArr addObject:@(cost)];
    }
    
    {
        NSObject *lock = [NSObject new];
        start = CFAbsoluteTimeGetCurrent();
        for (int i = 0; i < count; i++) {
            @synchronized(lock) {}
        }
        end = CFAbsoluteTimeGetCurrent();
        cost = end - start;
        [timeArr addObject:@(cost)];
    }
    
    {
        os_unfair_lock_t unfairLock;
        unfairLock = &(OS_UNFAIR_LOCK_INIT);
        start = CFAbsoluteTimeGetCurrent();
        for (int i = 0; i < count; i++) {
            os_unfair_lock_lock(unfairLock);
            os_unfair_lock_unlock(unfairLock);
        }
        end = CFAbsoluteTimeGetCurrent();
        cost = end - start;
        [timeArr addObject:@(cost)];
    }
    
    for (int i = 0; i < timeArr.count; i++) {
        NSLog(@"------%@------%@\n",timeArr[i],nameArr[i]);
    }
    
    
}

//2020-04-07 17:00:16.235394+0800 GCDTest[5668:84471] ------0.001281976699829102------OSSpinLock
//2020-04-07 17:00:16.235555+0800 GCDTest[5668:84471] ------0.002921938896179199------NSLock
//2020-04-07 17:00:16.235644+0800 GCDTest[5668:84471] ------0.001798033714294434------dispatch_semaphore
//2020-04-07 17:00:16.235731+0800 GCDTest[5668:84471] ------0.002393960952758789------pthread_mutex
//2020-04-07 17:00:16.235817+0800 GCDTest[5668:84471] ------0.002889037132263184------NSCondition
//2020-04-07 17:00:16.235900+0800 GCDTest[5668:84471] ------0.008239030838012695------NSConditionLock
//2020-04-07 17:00:16.236029+0800 GCDTest[5668:84471] ------0.00510704517364502------NSRecursiveLock
//2020-04-07 17:00:16.236131+0800 GCDTest[5668:84471] ------0.01226794719696045------@synchronized
//2020-04-07 17:00:16.236236+0800 GCDTest[5668:84471] ------0.001694917678833008------os_unfair_lock

/*
 没有优先级反转的问题的话，osspinlock占有绝对优势，其次就是dispatch_semaphore，dispatch_semaphore和os_unfair_lock差距很小，其次就是pthread_mutex。其实在测试的时候呢，性能和次数是有关系的，即是说这几种锁在不同的情形下会发挥最好性能，次数量大的时候呢，性能排名就如上面一样。所以在项目中使用的话，就根据项目情况选择即可。
 */



// https://www.jianshu.com/p/938d68ed832c
//@synchronized
- (void)test1{
    
    NSObject *obj = [[NSObject alloc] init];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @synchronized(obj) {
            NSLog(@"需要线程同步的操作1 开始");
            sleep(3);
            NSLog(@"需要线程同步的操作1 结束");
        }
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);
        @synchronized(obj) {
            NSLog(@"需要线程同步的操作2");
        }
    });
    
}


// dispatch_semaphore
- (void)test2{
    
    dispatch_semaphore_t signal = dispatch_semaphore_create(1);
    dispatch_time_t overTime = dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_semaphore_wait(signal, overTime);
        NSLog(@"需要线程同步的操作1 开始");
        sleep(2);
        NSLog(@"需要线程同步的操作1 结束");
        dispatch_semaphore_signal(signal);
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);
        dispatch_semaphore_wait(signal, overTime);
        NSLog(@"需要线程同步的操作2");
        dispatch_semaphore_signal(signal);
    });
    
}

// overTime 3s > 2s
//    2020-04-07 16:03:17.991681+0800 GCDTest[3951:52976] 需要线程同步的操作1 开始
//    2020-04-07 16:03:19.997178+0800 GCDTest[3951:52976] 需要线程同步的操作1 结束
//    2020-04-07 16:03:19.997509+0800 GCDTest[3951:52977] 需要线程同步的操作2

//overTime 2s < 2s
//    2020-04-07 16:04:24.028199+0800 GCDTest[3987:53737] 需要线程同步的操作1 开始
//    2020-04-07 16:04:26.031217+0800 GCDTest[3987:53735] 需要线程同步的操作2
//    2020-04-07 16:04:26.031235+0800 GCDTest[3987:53737] 需要线程同步的操作1 结束



// NSLock
- (void)test3{
    //NSLock还提供了tryLock和lockBeforeDate:两个方法，前一个方法会尝试加锁，如果锁不可用(已经被锁住)，刚并不会阻塞线程，并返回NO。lockBeforeDate:方法会在所指定Date之前尝试加锁，如果在指定时间之前都不能加锁，则返回NO。
    
    NSLock *lock = [[NSLock alloc] init];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //[lock lock];
        [lock lockBeforeDate:[NSDate date]];
        NSLog(@"需要线程同步的操作1 开始");
        sleep(2);
        NSLog(@"需要线程同步的操作1 结束");
        [lock unlock];
        
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);
        if ([lock tryLock]) {//尝试获取锁，如果获取不到返回NO，不会阻塞该线程
            NSLog(@"锁可用的操作");
            [lock unlock];
        }else{
            NSLog(@"锁不可用的操作");
        }
        
        NSDate *date = [[NSDate alloc] initWithTimeIntervalSinceNow:3];
        if ([lock lockBeforeDate:date]) {//尝试在未来的3s内获取锁，并阻塞该线程，如果3s内获取不到恢复线程, 返回NO,不会阻塞该线程
            NSLog(@"没有超时，获得锁");
            [lock unlock];
        }else{
            NSLog(@"超时，没有获得锁");
        }
        
    });
    
}

//    2020-04-07 16:06:34.884920+0800 GCDTest[4063:55054] 需要线程同步的操作1 开始
//    2020-04-07 16:06:35.888687+0800 GCDTest[4063:55052] 锁不可用的操作
//    2020-04-07 16:06:36.889672+0800 GCDTest[4063:55054] 需要线程同步的操作1 结束
//    2020-04-07 16:06:36.890125+0800 GCDTest[4063:55052] 没有超时，获得锁



//NSRecursiveLock递归锁
- (void)test4{
    //    NSLock *lock = [[NSLock alloc] init];
    NSRecursiveLock *lock = [[NSRecursiveLock alloc] init];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        static void (^RecursiveMethod)(int);
        
        RecursiveMethod = ^(int value) {
            
            [lock lock];
            if (value > 0) {
                
                NSLog(@"value = %d", value);
                sleep(1);
                RecursiveMethod(value - 1);
            }
            [lock unlock];
        };
        
        RecursiveMethod(5);
    });
}

//2020-04-07 16:16:30.707962+0800 GCDTest[4356:60336] value = 5
//2020-04-07 16:16:31.712258+0800 GCDTest[4356:60336] value = 4
//2020-04-07 16:16:32.716170+0800 GCDTest[4356:60336] value = 3
//2020-04-07 16:16:33.719982+0800 GCDTest[4356:60336] value = 2
//2020-04-07 16:16:34.725540+0800 GCDTest[4356:60336] value = 1


// NSConditionLock条件锁
- (void)test5{
    NSMutableArray *products = [NSMutableArray array];
    
    NSInteger HAS_DATA = 1;
    NSInteger NO_DATA = 0;
    
    NSConditionLock *lock = [[NSConditionLock alloc] init];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        while (1) {
            [lock lockWhenCondition:NO_DATA];
            [products addObject:[[NSObject alloc] init]];
            NSLog(@"produce a product,总量:%zi",products.count);
            [lock unlockWithCondition:HAS_DATA];
            sleep(1);
        }
        
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        while (1) {
            NSLog(@"wait for product");
            [lock lockWhenCondition:HAS_DATA];
            [products removeObjectAtIndex:0];
            NSLog(@"custome a product");
            [lock unlockWithCondition:NO_DATA];
        }
        
    });
}

//2020-04-07 16:18:27.136452+0800 GCDTest[4425:61679] wait for product
//2020-04-07 16:18:27.136472+0800 GCDTest[4425:61682] produce a product,总量:1
//2020-04-07 16:18:27.136785+0800 GCDTest[4425:61679] custome a product
//2020-04-07 16:18:27.136882+0800 GCDTest[4425:61679] wait for product
//2020-04-07 16:18:28.137777+0800 GCDTest[4425:61682] produce a product,总量:1
//2020-04-07 16:18:28.138038+0800 GCDTest[4425:61679] custome a product


//NSCondition
- (void)test6{
    NSCondition *condition = [[NSCondition alloc] init];
    
    NSMutableArray *products = [NSMutableArray array];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        while (1) {
            [condition lock];
            if ([products count] == 0) {
                NSLog(@"wait for product");
                [condition wait];
            }
            [products removeObjectAtIndex:0];
            NSLog(@"custome a product");
            [condition unlock];
        }
        
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        while (1) {
            [condition lock];
            [products addObject:[[NSObject alloc] init]];
            NSLog(@"produce a product,总量:%zi",products.count);
            [condition signal];
            [condition unlock];
            sleep(1);
        }
        
    });
}

//2020-04-07 16:25:07.629381+0800 GCDTest[4630:65365] produce a product,总量:1
//2020-04-07 16:25:07.629703+0800 GCDTest[4630:65366] custome a product
//2020-04-07 16:25:07.629848+0800 GCDTest[4630:65366] wait for product
//2020-04-07 16:25:08.630943+0800 GCDTest[4630:65365] produce a product,总量:1
//2020-04-07 16:25:08.631245+0800 GCDTest[4630:65366] custome a product
//2020-04-07 16:25:08.631394+0800 GCDTest[4630:65366] wait for product

// pthread_mutex
//需要导入 #include <pthread.h>
- (void)test7{
    __block pthread_mutex_t theLock;
    pthread_mutex_init(&theLock, NULL);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        pthread_mutex_lock(&theLock);
        NSLog(@"需要线程同步的操作1 开始");
        sleep(3);
        NSLog(@"需要线程同步的操作1 结束");
        pthread_mutex_unlock(&theLock);
        
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);
        pthread_mutex_lock(&theLock);
        NSLog(@"需要线程同步的操作2");
        pthread_mutex_unlock(&theLock);
        
    });
}

/*
 1：pthread_mutex_init(pthread_mutex_t * mutex,const pthread_mutexattr_t attr);
 初始化锁变量mutex。attr为锁属性，NULL值为默认属性。
 2：pthread_mutex_lock(pthread_mutex_t* mutex);加锁
 3：pthread_mutex_tylock(pthread_mutex_t* mutex);加锁，但是与2不一样的是当锁已经在使用的时候，返回为EBUSY，而不是挂起等待。
 4：pthread_mutex_unlock(pthread_mutex_t* mutex);释放锁
 5：pthread_mutex_destroy(pthread_mutex_t* *mutex);使用完后释放
 
 */

//2020-04-07 16:35:50.932300+0800 GCDTest[4954:71013] 需要线程同步的操作1 开始
//2020-04-07 16:35:53.937679+0800 GCDTest[4954:71013] 需要线程同步的操作1 结束
//2020-04-07 16:35:53.937989+0800 GCDTest[4954:71014] 需要线程同步的操作2


// pthread_mutex(recursive)
- (void)test8{
    __block pthread_mutex_t theLock;
    //pthread_mutex_init(&theLock, NULL);
    
    pthread_mutexattr_t attr;
    pthread_mutexattr_init(&attr);
    pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE);
    pthread_mutex_init(&theLock, &attr);
    pthread_mutexattr_destroy(&attr);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        static void (^RecursiveMethod)(int);
        
        RecursiveMethod = ^(int value) {
            
            pthread_mutex_lock(&theLock);
            if (value > 0) {
                
                NSLog(@"value = %d", value);
                sleep(1);
                RecursiveMethod(value - 1);
            }
            pthread_mutex_unlock(&theLock);
        };
        
        RecursiveMethod(5);
    });
}

//2020-04-07 16:41:58.907267+0800 GCDTest[5126:74111] value = 5
//2020-04-07 16:41:59.908422+0800 GCDTest[5126:74111] value = 4
//2020-04-07 16:42:00.910467+0800 GCDTest[5126:74111] value = 3
//2020-04-07 16:42:01.910926+0800 GCDTest[5126:74111] value = 2
//2020-04-07 16:42:02.911543+0800 GCDTest[5126:74111] value = 1


//OSSpinLock
// 需要引入头文件 #import <libkern/OSAtomic.h>
// os_unfair_lock 不公平的锁，就是解决优先级反转问题。 需要引入头文件 #import <os/lock.h>

- (void)test9{
    __block OSSpinLock theLock = OS_SPINLOCK_INIT;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        OSSpinLockLock(&theLock);
        NSLog(@"需要线程同步的操作1 开始");
        sleep(3);
        NSLog(@"需要线程同步的操作1 结束");
        OSSpinLockUnlock(&theLock);
        
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        OSSpinLockLock(&theLock);
        sleep(1);
        NSLog(@"需要线程同步的操作2");
        OSSpinLockUnlock(&theLock);
        
    });
}

//2020-04-07 16:50:01.310631+0800 GCDTest[5387:79450] 需要线程同步的操作1 开始
//2020-04-07 16:50:04.311236+0800 GCDTest[5387:79450] 需要线程同步的操作1 结束
//2020-04-07 16:50:05.371286+0800 GCDTest[5387:79451] 需要线程同步的操作2




// os_unfair_lock
//1、OS_UNFAIR_LOCK_INIT ，初始化锁
//2、os_unfair_lock_lock ，获得锁
//3、os_unfair_lock_unlock ，解锁
- (void)test10{
    
    
    
}


@end
