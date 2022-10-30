//
//  PicExplainListCell.m
//  AllStars
//
//  Created by Mac on 2021/10/12.
//

#import "PicExplainListCell.h"
#import "BoxCardListCell.h"
#import "VariableRoundedBorderView.h"

@interface PicExplainListCell()<UICollectionViewDelegate,UICollectionViewDataSource>
@end

@implementation PicExplainListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor clearColor];
        UIView *bgv = [[UIView alloc]initWithFrame:CGRectMake(15, 0, KScreenWidth-30, 105)];
        bgv.backgroundColor = kUIColorFromRGB(0x341D11);
        [self.contentView addSubview:bgv];
        
        self.myCollectionView.frame = CGRectMake(2, 0, KScreenWidth-32, 95);
        self.myCollectionView.backgroundColor = kUIColorFromRGB(0x341D11);
        [bgv addSubview:self.myCollectionView];
        
        UIView *line1 = [Tool createLinewithFrame:CGRectMake(0, 0, 1, 105) alpha:1];
        line1.backgroundColor = CLineColor;
        [bgv addSubview:line1];
        UIView *line2 = [Tool createLinewithFrame:CGRectMake(KScreenWidth-31, 0, 1, 105) alpha:1];
        line2.backgroundColor = CLineColor;
        [bgv addSubview:line2];
        
    }
    return self;
}

#pragma mark ====== UICollectionViewDelegate ======
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 7;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BoxCardListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BoxCardListCell" forIndexPath:indexPath];
   
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectItemAtIndexPath:)]) {
        [self.delegate didSelectItemAtIndexPath:indexPath];
    }
}

#pragma mark ====== init ======
- (UICollectionView *)myCollectionView {
    if (!_myCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        CGFloat width = ([UIScreen mainScreen].bounds.size.width - 60) / 5;
        layout.itemSize = CGSizeMake(width, 95);
        layout.minimumInteritemSpacing = 20;
        layout.minimumLineSpacing = 20;
        layout.sectionInset = UIEdgeInsetsMake(0,20, 0, 20);
        
        _myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _myCollectionView.delegate = self;
        _myCollectionView.dataSource = self;
        [_myCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([BoxCardListCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"BoxCardListCell"];
    }
    return _myCollectionView;
}
@end
