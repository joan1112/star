//
//  HFNoInternetView.h
//  MCC-AMS
//
//  Created by BOC002 on 2018/5/21.
//  Copyright © 2018年 BOC002. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HFNoInternetViewDelegate <NSObject>

- (void)reloadNetworkDataSource:(id)sender;

@end
@interface HFNoInternetView : UIView
@property (nonatomic, weak) id<HFNoInternetViewDelegate>delegate;
@end
