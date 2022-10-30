//
//  CSNetworkConfig.h
//  ComeSpeak
//
//  Created by Beyondream on 2020/9/5.
//  Copyright © 2020 XiaoLaiYingCai. All rights reserved.
//

#ifndef CSNetworkConfig_h
#define CSNetworkConfig_h


#define KisDebugNet 0 // 正式网络 上架记得推送开关打开
//#define KisDebugNet 1 // 测试网络,版本号双数

#if KisDebugNet == 0 // 正式
#pragma mark ---正式环境下的地址---
#define mainServerURL @"http://www.allstarplay.games"
//#define mainServerURL @"https://m.allstarplay.games"
#define chainID  56
#define rpcURL @"https://bsc-dataseed1.binance.org/"
#define magicBox @"https://m.allstarplay.games/box/"
#define starToken @"0xf01FB092941b001Db370AC71609B927CCf982333"
#define stlToken @"0x7dce345614A8054A36f915960b00E5D7b65EF1c2"
#define buildBaseUrl @"https://homes.allstarplay.games/"
#define bdd @"https://m.allstarplay.games/bdd/"
#elif KisDebugNet == 1 // 测试
#pragma mark ---测试环境下的地址---
//#define mainServerURL @"http://74.82.216.141:8181"
#define mainServerURL @"http://112.124.29.74:8089"
#define chainID  97
#define rpcURL @"https://data-seed-prebsc-1-s1.binance.org:8545/"
//#define magicBox @"http://192.168.0.25:8082/game.html?local=en_US"
#define magicBox @"http://192.168.0.9:8080/box/"
#define starToken @"0x4B99fF643083C8c4B7A097D375ba4c1051d25d75"
#define stlToken @"0x4B99fF643083C8c4B7A097D375ba4c1051d25d75"
#define bdd @"http://192.168.0.9:8081/bdd/"
//
//#define buildBaseUrl @"http://112.124.29.74/"
#define buildBaseUrl @"https://homes.allstarplay.games/"

#endif

#endif /* CSNetworkConfig_h */
