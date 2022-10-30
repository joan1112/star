//
//  MyCollectListCell.m
//  AllStars
//
//  Created by Mac on 2021/10/13.
//

#import "MyCollectListCell.h"
#import "BoxCardListCell.h"

@interface MyCollectListCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation MyCollectListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor clearColor];
        UIView *bgv = [[UIView alloc]initWithFrame:CGRectMake(15, 0, KScreenWidth-30, 135)];
        bgv.layer.cornerRadius = 10;
        bgv.layer.masksToBounds = YES;
        bgv.layer.borderColor = CLineColor.CGColor;
        bgv.layer.borderWidth = 1;
        bgv.backgroundColor = CNavBgColor;
        [self.contentView addSubview:bgv];
        
        self.titleL = [Tool createLabelWithFrame:CGRectMake(15, 0, 250, 40) textColor:CLineColor textFont:MYFONT(17) textAligion:NSTextAlignmentLeft labelText:@"上帝之鞭"];
        [bgv addSubview:self.titleL];
        
        self.myCollectionView.frame = CGRectMake(0, 40, KScreenWidth-30, 95);
        self.myCollectionView.backgroundColor = CNavBgColor;
        [bgv addSubview:self.myCollectionView];
    }
    return self;
}

#pragma mark ====== UICollectionViewDelegate ======
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BoxCardListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BoxCardListCell" forIndexPath:indexPath];
   
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectItemAtIndexPath:)]) {
//        [self.delegate didSelectItemAtIndexPath:indexPath];
//    }
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
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
