//
//  WalletRecvVC.m
//  AllStars
//
//  Created by Mac on 2021/11/8.
//

#import "WalletRecvVC.h"

@interface WalletRecvVC ()
@property(nonatomic,strong)UIImageView *QRV;
@end

@implementation WalletRecvVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSLocalizedString(@"接收", nil);
   
    [self setSubViews];
    [self loadImage];
//    self.QRV.image = [self getErWeiMaWithUrl:[[NSUserDefaults standardUserDefaults] objectForKey:@"address"]];

}
-(void)loadImage{
    dispatch_queue_t concurrent_queue = dispatch_queue_create("come.img", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(concurrent_queue, ^{
        UIImage *img = [self getErWeiMaWithUrl:[[NSUserDefaults standardUserDefaults] objectForKey:@"address"]];
          dispatch_async(dispatch_get_main_queue(), ^{
              self.QRV.image = img;
          });
      });
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

}
-(void)setSubViews{
    UIImageView *iconV = [Tool createImageViewWithFrame:CGRectMake((KScreenWidth-32)/2, 15, 32, 32) image:MYIMAGE(@"recv_icon") placeholderImge:nil];
    [self.view addSubview:iconV];
    UIView *bgv = [[UIView alloc]initWithFrame:CGRectMake(18, iconV.bottom+10, KScreenWidth-36, 270)];
    [self.view addSubview:bgv];
    bgv.layer.cornerRadius  = 8;
    bgv.layer.masksToBounds = YES;
    bgv.layer.borderColor = CLineColor.CGColor;
    bgv.layer.borderWidth = 1;
    
    UILabel *titleL = [Tool createLabelWithFrame:CGRectMake(0, 45, bgv.width, 20) textColor:CLineColor textFont:MYFONT(18) textAligion:NSTextAlignmentCenter labelText:@"BSC"];
    [bgv addSubview:titleL];
    
    UIView *qrBGV = [[UIView alloc]initWithFrame:CGRectMake((bgv.width-110)/2, titleL.bottom+20, 110, 110)];
    qrBGV.backgroundColor = [UIColor whiteColor];
    qrBGV.layer.cornerRadius = 5;
    qrBGV.layer.masksToBounds = YES;
    [bgv addSubview:qrBGV];
    
    self.QRV= [Tool createImageViewWithFrame:CGRectMake(5, 5, 100, 100) image:MYIMAGE(@"white") placeholderImge:nil];
    [qrBGV addSubview:self.QRV];
    
    UIImageView *addressV = [[UIImageView alloc]initWithFrame:CGRectMake((bgv.width-240)/2, qrBGV.bottom+20, 240, 34)];
    addressV.layer.cornerRadius = 5;
    addressV.layer.masksToBounds = YES;
    UIImage *bg = [UIColor gradientImageWithView:addressV fromColor:@"#C8AC7C" toColor:@"#F9EFBC" startPoint:CGPointMake(0, 0.5) endPoint:CGPointMake(1, 0.5) cornerRadius:5];
    addressV.backgroundColor = [UIColor colorWithPatternImage:bg];
    [bgv addSubview:addressV];
    UILabel *addressL = [Tool createLabelWithFrame:CGRectMake((addressV.width-100)/2, 0, 100, 34) textColor:CViewBgColor textFont:MYFONT(16) textAligion:NSTextAlignmentCenter labelText:[UserInfoConfig shareManager].address];
    addressL.lineBreakMode = NSLineBreakByTruncatingMiddle;
    [addressV addSubview:addressL];
    
//    UIImageView *tipV = [Tool createImageViewWithFrame:CGRectMake(18, bgv.bottom+15, 15, 15) image:MYIMAGE(@"tip_icon") placeholderImge:nil];
//    [self.view addSubview:tipV];
    
    UILabel *tipL = [Tool createLabelWithFrame:CGRectMake(18, bgv.bottom+10, KScreenWidth-36, 40) textColor:kUIColorFromRGB(0x999999) textFont:MYFONT(14) textAligion:NSTextAlignmentLeft labelText:NSLocalizedString(@" 本地址僅支持BSC資産收款，請勿用于其他幣種", nil)];
    tipL.numberOfLines = 0;
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:NSLocalizedString(@" 本地址僅支持BSC資産收款，請勿用于其他幣種", nil)];
       //NSTextAttachment可以将要插入的图片作为特殊字符处理
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
       //定义图片内容及位置和大小
    attch.image = [UIImage imageNamed:@"tip_icon"];
    attch.bounds = CGRectMake(0, 0, 15, 15);
       //创建带有图片的富文本
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
       
       //将图片放在最后一位
    //[attri appendAttributedString:string];
       //将图片放在第一位
    [attri insertAttributedString:string atIndex:0];
       //用label的attributedText属性来使用富文本
    tipL.attributedText = attri;
    
    [self.view addSubview:tipL];
    
    UIButton *copyBtn = [Tool createButtonWithFrame:CGRectMake(35, bgv.bottom+150, KScreenWidth-70, 50) title:NSLocalizedString(@"复制", nil) titleColor:kUIColorFromRGB(0xfffffff) textFont:MYFONT(18) backgroudColor:CNavBgColor target:self action:@selector(copyAction)];
    [self.view addSubview:copyBtn];
}

-(void)copyAction{
    [self.view showToastWithText:NSLocalizedString(@"复制成功", nil)];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = [UserInfoConfig shareManager].address;
}
- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size
{
CGRect extent = CGRectIntegral(image.extent);
CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));

//1.创建bitmap;
size_t width = CGRectGetWidth(extent) * scale;
size_t height = CGRectGetHeight(extent) * scale;
CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
CIContext *context = [CIContext contextWithOptions:nil];
CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
CGContextScaleCTM(bitmapRef, scale, scale);
CGContextDrawImage(bitmapRef, extent, bitmapImage);

//2.保存bitmap到图片
CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
CGContextRelease(bitmapRef);
CGImageRelease(bitmapImage);
return [UIImage imageWithCGImage:scaledImage];
}
- (UIImage *)getErWeiMaWithUrl:(NSString *)url{
    // 1、创建滤镜对象
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 恢复滤镜的默认属性
    [filter setDefaults];
    // 2、设置数据
    NSString *string_data = url;
    // 将字符串转换成 NSdata (虽然二维码本质上是字符串, 但是这里需要转换, 不转换就崩溃)
    NSData *qrImageData = [string_data dataUsingEncoding:NSUTF8StringEncoding];
    
    // 设置过滤器的输入值, KVC赋值
    [filter setValue:qrImageData forKey:@"inputMessage"];
    
//    // 3、获得滤镜输出的图像
    CIImage *outputImage = [filter outputImage];
//    // 图片小于(27,27),我们需要放大
//    outputImage = [outputImage imageByApplyingTransform:CGAffineTransformMakeScale(20, 20)];
    // 4、将CIImage类型转成UIImage类型
//    UIImage *start_image = [UIImage imageWithCIImage:outputImage];
    UIImage *start_image = [self createNonInterpolatedUIImageFormCIImage:outputImage withSize:[UIScreen mainScreen].bounds.size.width];

    // - - - - - - - - - - - - - - - - 添加中间小图标 - - - - - - - - - - - - - - - -
    // 5、开启绘图, 获取图形上下文 (上下文的大小, 就是二维码的大小)
    UIGraphicsBeginImageContext(start_image.size);
    // 把二维码图片画上去 (这里是以图形上下文, 左上角为(0,0)点
    [start_image drawInRect:CGRectMake(0, 0, start_image.size.width, start_image.size.height)];
    // 再把小图片画上去
    NSString *icon_imageName = @"qr_icon";
    UIImage *icon_image = [UIImage imageNamed:icon_imageName];
    CGFloat icon_imageW = start_image.size.width*0.3;
    CGFloat icon_imageH = icon_imageW;
    CGFloat icon_imageX = (start_image.size.width - icon_imageW) * 0.5;
    CGFloat icon_imageY = (start_image.size.height - icon_imageH) * 0.5;
    [icon_image drawInRect:CGRectMake(icon_imageX, icon_imageY, icon_imageW, icon_imageH)];
    // 6、获取当前画得的这张图片
    UIImage *final_image = UIGraphicsGetImageFromCurrentImageContext();
    // 7、关闭图形上下文
    UIGraphicsEndImageContext();
    return final_image;
}
@end
