//
//  AddressListModel.h
//  AllStars
//
//  Created by Mac on 2021/11/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddressListModel : NSObject
@property (nonatomic,strong) NSString *selected;
@property (nonatomic, strong)NSString *pass;
@property (nonatomic, strong)NSString *address;
@property (nonatomic, strong)NSString *privteKey;
@property (nonatomic, strong)NSString *publickKey;
@property (nonatomic, strong)NSString *mnemonics;
@end

NS_ASSUME_NONNULL_END
