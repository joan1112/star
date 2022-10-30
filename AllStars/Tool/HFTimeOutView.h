//
//  HFTimeOutView.h
//  MCC-AMS
//
//  Created by BOC002 on 2018/5/23.
//  Copyright © 2018年 BOC002. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HFTimeOutViewDelegate <NSObject>

- (void)refreshNetworkDataSource:(id)sender;

@end
@interface HFTimeOutView : UIView
@property (nonatomic, weak) id<HFTimeOutViewDelegate>delegate;
@end
