//
//  BuyResultView.m
//  AllStars
//
//  Created by Mac on 2021/10/12.
//

#import "BuyResultView.h"
#import "BoxCardListCell.h"
@interface BuyResultView()<UICollectionViewDelegate,UICollectionViewDataSource>{
    
}
@property(nonatomic,strong)UICollectionView *myCollectionView;
@end

@implementation BuyResultView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.bgView.layer.borderWidth = 1;
    self.bgView.layer.borderColor = kUIColorFromRGB(0xE1CF9D).CGColor;
    self.bgView.layer.cornerRadius = 15;
    self.bgView.layer.masksToBounds = YES;
    
    [self.receiveBtn setBackgroundColor:[UIColor colorWithPatternImage:MYIMAGE(@"receiveMedal")]];
    [self.receiveBtn setTitle:@"" forState:UIControlStateNormal];
    [self.againBtn setBackgroundColor:[UIColor colorWithPatternImage:MYIMAGE(@"playAgain")]];
    [self.againBtn setTitle:@"" forState:UIControlStateNormal];
    
    [self.bgView addSubview:self.myCollectionView];

}

-(UICollectionView*)myCollectionView{
    if (!_myCollectionView) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.itemSize = CGSizeMake(67, 95);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 30, 0, 30);
        flowLayout.minimumInteritemSpacing = 35;
        flowLayout.minimumLineSpacing = 20;
        
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 100, KScreenWidth-30, self.bgView.height-100) collectionViewLayout:flowLayout];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.backgroundColor = [UIColor clearColor];
        [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([BoxCardListCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"BoxCardListCell"];
        
        _myCollectionView = collectionView;
    }
    return _myCollectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
   
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BoxCardListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BoxCardListCell" forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
