//
//  WalletInfoVC.h
//  AllStars
//
//  Created by Mac on 2021/11/25.
//

#import "RootViewController.h"

NS_ASSUME_NONNULL_BEGIN
@protocol WalletInfoVCDelegate <NSObject>

-(void)backToUpdateUser;

@end

@interface WalletInfoVC : RootViewController
@property(nonatomic,strong)NSString *address;
@property(nonatomic,strong)NSString *privateKey;
@property(nonatomic,strong)NSString *publicKey;
@property(nonatomic,weak)id<WalletInfoVCDelegate>deletate;
@end

NS_ASSUME_NONNULL_END
