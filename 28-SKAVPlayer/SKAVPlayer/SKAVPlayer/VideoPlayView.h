//
//  VideoPlayView.h


#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface VideoPlayView : UIView
/** 快速创建 */
+ (instancetype)videoPlayView;

/** 需要播放的视频资源 */
@property (nonatomic,copy) NSString *urlString;

/* 横屏包含在哪一个控制器中 */
@property (nonatomic, weak) UIViewController *contrainerViewController;

/// 播放远程视频
- (void)setUrlString:(NSString *)urlString;
/// 播放本地视频
- (void)setFilePathString:(NSString *)urlString;

@end
