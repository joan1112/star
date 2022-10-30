//
//  HomeCardScrollView.m
//  AllStars
//
//  Created by Mac on 2021/10/14.
//

#import "HomeCardScrollView.h"
#import "HomeCardListVewCell.h"
#import "WeakProxy.h"
@interface HomeCardScrollView()<UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,assign) int currentPage;

@end

@implementation HomeCardScrollView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.collectionView];
        [self invalidateTimer];
        // 移動到開頭
//        [_collectionView setContentOffset:CGPointMake(0, 0)];
//        [_collectionView reloadData];
//        _currentPage = 2;
//        [self setupTimer];
    }
    return self;
}
-(UICollectionView*)collectionView{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.itemSize = CGSizeMake((KScreenWidth-110), 310);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 20, 0, 0);
        flowLayout.minimumInteritemSpacing = 20;
        flowLayout.minimumLineSpacing = 20;
        
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 310) collectionViewLayout:flowLayout];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.backgroundColor = [UIColor clearColor];
        [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([HomeCardListVewCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"HomeCardListVewCell"];
        
        _collectionView = collectionView;
    }
    return _collectionView;
}


#pragma mark -Timer

- (void)setupTimer{
    [self invalidateTimer];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:[WeakProxy proxyWithTarget:self] selector:@selector(autoNextPage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)invalidateTimer{
    [self.timer invalidate];
}

- (void)autoNextPage{
//    if (_dataArr.count < 1) {
//        return; // 只有一個值,不需要輪播
//    }
    // 新的目標頁數
//    _currentPage = (_currentPage + 1) % _dataArr.count;
    _currentPage = (_currentPage + 1) % 20;
    NSLog(@"autoNextPage %d",_currentPage);
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_currentPage inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}

//解决当父View释放时，当前视图因为被Timer强引用而不能释放的问题
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (!newSuperview) {
        [self invalidateTimer];
    }
}

//解决当timer释放后 回调scrollViewDidScroll时访问野指针导致崩溃
- (void)dealloc {
    _collectionView.delegate = nil;
    _collectionView.dataSource = nil;
    [self.timer invalidate];
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    _currentPage = (int)targetContentOffset ->x  / KScreenWidth;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self invalidateTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
//    [self setupTimer];
}

#pragma mark  - UICollectionViewDataSource & UICollectionViewDelegate & UICollectionViewDelegateFlowLayout

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeCardListVewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeCardListVewCell" forIndexPath:indexPath];
    HeroCardInfoModel *model = self.dataArr[indexPath.row];
    cell.contentL.text = model.desc;
    cell.nameL.text = model.name;
    NSString *colorS = [self getColorWithValue:model.quality];
    cell.nameL.textColor = [Tool hexColor:colorS];
    [cell.imageV sd_setImageWithURL:[NSURL URLWithString:model.imageUrl]];
    cell.frameV.image = MYIMAGE([Tool getFrameNameWithValue:model.quality.integerValue]);
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //
}
-(NSString*)getColorWithValue:(NSString*)value {
    //红橙金紫蓝
    if (value.intValue == 5) {
        return @"#FF3749";
    }else if (value.intValue == 4) {
        return @"#FF7200";
    }
    else if (value.intValue == 3) {
        return @"#FFD800";
    }
    else if (value.intValue == 2) {
        return @"#8B3EFF";
    }
    else{
        return @"#3EA6FF";
    }
}

@end

