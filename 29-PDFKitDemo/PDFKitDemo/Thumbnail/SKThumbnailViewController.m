//
//  SKThumbnailViewController.m
//  PDFKitDemo
//
//  Created by sunke on 2020/9/20.
//  Copyright © 2020 KentSun. All rights reserved.
//

#import "SKThumbnailViewController.h"
#import "SKThumbnailCell.h"

NSString * const thumbnailCollectionViewCellID = @"thumbnailCollectionViewCellID";


@interface SKThumbnailViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
{
    dispatch_queue_t queue;
    NSCache *thumbnailCache;
}

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation SKThumbnailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Thumbnail";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancle" style:UIBarButtonItemStylePlain target:self action:@selector(dismissController)];
    
    queue = dispatch_queue_create("com.thumbnail.pdfview", DISPATCH_QUEUE_CONCURRENT);
    thumbnailCache = [[NSCache alloc] init];
    
    [self setupUI];
}

- (void)setupUI {
    [self.view addSubview:self.collectionView];
}

- (void)dismissController {
//    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:true];
}

#pragma mark - --- UICollectionView DataSource ---

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.pdfDocument.pageCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SKThumbnailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:thumbnailCollectionViewCellID forIndexPath:indexPath];
    
    PDFPage *page = [self.pdfDocument pageAtIndex:indexPath.item];
    
    cell.pageNum.text = page.label;
    
    NSString *key = [NSString stringWithFormat:@"%ld",(long)indexPath.item];
    
    UIImage *thumbnailImage = [thumbnailCache objectForKey:key];
    
    CGSize imageSize = CGSizeMake(cell.bounds.size.width * 2, cell.bounds.size.height * 2);
    
    if (thumbnailImage){
        cell.imgViewThumb.image = thumbnailImage;
    }else {
        dispatch_async(queue, ^{
            
            UIImage *thumbnailImage = [page thumbnailOfSize:imageSize forBox:kPDFDisplayBoxMediaBox];
            [self->thumbnailCache setObject:thumbnailImage forKey:key];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                cell.imgViewThumb.image = thumbnailImage;
                
            });
        });
    }
    
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

#pragma mark - --- UICollectionView Delegate ---

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    if (self.delegate && [self.delegate respondsToSelector:@selector(thumbnailViewController:didSelectAtIndex:)]) {
        [self.delegate thumbnailViewController:self didSelectAtIndex:indexPath];
    }
    [self.navigationController popViewControllerAnimated:true];

}

#pragma mark - --- setter & getter ---
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        CGFloat itemWidth = floor(([UIScreen mainScreen].bounds.size.width - 10 * 4) / 3.0);
        CGFloat itemHeight = itemWidth * 1.5;
        
        UICollectionViewFlowLayout  *flowlayout = [[UICollectionViewFlowLayout alloc] init];
        flowlayout.itemSize = CGSizeMake(itemWidth, itemHeight);
        flowlayout.minimumLineSpacing = 10;
        flowlayout.minimumInteritemSpacing = 10;
        flowlayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowlayout];
        _collectionView.backgroundColor = [UIColor grayColor];
        _collectionView.showsVerticalScrollIndicator = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[SKThumbnailCell class] forCellWithReuseIdentifier:thumbnailCollectionViewCellID];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    
    return _collectionView;
}

@end
