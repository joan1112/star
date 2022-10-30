//
//  InviteIntroView.m
//  AllStars
//
//  Created by junqiang on 2022/3/4.
//

#import "InviteIntroView.h"
#import "CusPageControlWithView.h"
@interface InviteIntroView()
{
    CusPageControlWithView *pageView;

}
@property(nonatomic,strong)UIScrollView *introScroll;
@end
@implementation InviteIntroView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubview];
        [self addPageControl];
        [self addBackRow];
        
    }
    return self;
}

-(void)addBackRow{
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    back.frame = CGRectMake(10, kNavBarHeight-44, 44, 44);
    [back setImage:[UIImage imageNamed:@"nav_back_white"] forState:UIControlStateNormal];
    [self addSubview:back];
    [back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
}
-(void)back{
    if (self.goToNext) {
        self.goToNext(0);
    }
}
#pragma mark 创建UIPageControl
-(void)addPageControl{
    CGRect rectValue=CGRectMake(0, self.mj_h-60, KScreenWidth, 33);
    UIImage *currentImage=[UIImage imageNamed:@"slidePoint"];
    UIImage *pageImage=[UIImage imageNamed:@"slideCirclePoint"];;
    pageView=[CusPageControlWithView cusPageControlWithView:rectValue pageNum:4 currentPageIndex:0 currentShowImage:currentImage pageIndicatorShowImage:pageImage];
    [self addSubview:pageView];
}
-(void)initSubview{
    _introScroll = [[UIScrollView alloc]init];
    [self addSubview:_introScroll];
    _introScroll.frame=self.frame;
    _introScroll.pagingEnabled=YES;//设置分页
    _introScroll.showsHorizontalScrollIndicator=NO;
    _introScroll.bounces=NO;//设置不能弹回
    _introScroll.delegate=self;
    _introScroll.backgroundColor = kUIColorFromRGB(0x040827);
    _introScroll.contentSize=CGSizeMake(_introScroll.frame.size.width*4, 0);
    //添加图片
    NSArray *titleArr = @[@"【Share invitation link】 【Add a friend address manually】",@"Create daily management of social groups",@"【Friend consumption】Get rebate",@"Withdraw STAR to get earnings"];
    for (int i=0; i<4; i++) {
        UIImageView *imageView=[[UIImageView alloc]init];
        NSString *strImageName=[NSString stringWithFormat:@"intro%d",i+1];
        imageView.image=[UIImage imageNamed:strImageName];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.frame=CGRectMake(i*_introScroll.frame.size.width + 5,kNavBarHeight, self.mj_w-10, (self.mj_w-10)*1.1);
        [_introScroll addSubview:imageView];//将图片视图添加到ScrollView上面

        UILabel *des = [[UILabel alloc]initWithFrame:CGRectMake(i*_introScroll.frame.size.width+15, CGRectGetMaxY(imageView.frame), KScreenWidth-30, 80)];
        des.text = titleArr[i];
        des.textAlignment = NSTextAlignmentCenter;
        des.numberOfLines = 0;
        des.textColor = [UIColor whiteColor];
        des.font = [UIFont systemFontOfSize:18];
        [_introScroll addSubview:des];
        if (i==0) {
            UIButton *button=[[UIButton alloc]init];
            [button setTitle:@"Start" forState:UIControlStateNormal];
            button.titleLabel.font=[UIFont systemFontOfSize:18];
            button.backgroundColor=kUIColorFromRGB(0x147CE6);
            button.layer.cornerRadius=25;
            button.layer.masksToBounds=YES;
            button.layer.zPosition = 3;
          
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            button.frame=CGRectMake((KScreenWidth-180)/2,CGRectGetMaxY(des.frame),180,50);
            [button addTarget:self action:@selector(NextPage:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = 20;
            [_introScroll addSubview:button];
        }else{
            for (int j=0; j<2; j++) {
                UIButton *button=[[UIButton alloc]init];
                
                [button setTitle:@[@"Last",@"Next"][j] forState:UIControlStateNormal];
                button.titleLabel.font=[UIFont systemFontOfSize:18];
                button.backgroundColor=kUIColorFromRGB(0x147CE6);
                button.layer.cornerRadius=25;
                button.layer.masksToBounds=YES;
                button.layer.zPosition = 3;
              
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//                w-90
                CGFloat pd = (KScreenWidth-90)/2;
                button.frame=CGRectMake(i*_introScroll.frame.size.width+30+j*(30+pd),CGRectGetMaxY(des.frame),pd,50);
                [button addTarget:self action:@selector(NextPage:) forControlEvents:UIControlEventTouchUpInside];
                button.tag = j+100;
                [_introScroll addSubview:button];
            }
            
            
        }
    }
    [self addSubview:_introScroll];
}
#pragma mark ScrollView的代理
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat  getNum=scrollView.contentOffset.x/scrollView.frame.size.width;
    NSInteger pageValue=(NSInteger)(getNum+0.5);
    
    pageView.indexNumWithSlide=pageValue; // 这个属性中的Setting会调用很多次,所以在其里面判断前后值
   
}
-(void)NextPage:(UIButton*)sender
{
 
    if (sender.tag==20) {//第一页
        pageView.indexNumWithSlide = pageView.indexNumWithSlide+1;
        _introScroll.contentOffset = CGPointMake(KScreenWidth*pageView.indexNumWithSlide, 0);
    }else if(sender.tag ==100){
        pageView.indexNumWithSlide = pageView.indexNumWithSlide-1;
        _introScroll.contentOffset = CGPointMake(KScreenWidth*pageView.indexNumWithSlide, 0);
    }else{
        if(pageView.indexNumWithSlide==3){
            if (self.goToNext) {
                self.goToNext(1);
            }
        }else{
            pageView.indexNumWithSlide = pageView.indexNumWithSlide+1;
            _introScroll.contentOffset = CGPointMake(KScreenWidth*pageView.indexNumWithSlide, 0);
        }
       
    }
}
@end
