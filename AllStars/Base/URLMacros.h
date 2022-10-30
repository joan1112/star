
#ifndef URLMacros_h
#define URLMacros_h
//内部版本号 每次发版递增
#define KVersionCode 1
/*
 将项目中所有的接口写在这里,方便统一管理,降低耦合
 这里通过宏定义来切换你当前的服务器类型,
 将你要切换的服务器类型宏后面置为真(即>0即可),其余为假(置为0)
 如下:现在的状态为测试服务器
 这样做切换方便,不用来回每个网络请求修改请求域名,降低出错事件
 */
#define DevelopSever                    (1)
#define ProductSever                    (0)

#if DevelopSever
/**开发服务器*/
//#define URL_BASE                             @"http://112.124.29.74:8181"//
#define URL_BASE                             @"http://192.168.0.60:8181"//

/**生产服务器*/
#elif ProductSever
#define URL_BASE                             @"https://www.allstarplay.games/"//后台服务器
#endif

/**接口地址*/
#define URL_home                        @"/v2/star/home/index"// 首页
#define URL_homeBanaer                  @"/app-api/collect/get_published_banner"//banner
#define URL_homePopUp                   @"/app-api/collect/get_published_popup"// 弹框数据
#define URL_cardList                    @"/v2/star/card/list"// 首页卡片列表
#define URL_initUser                    @"/v2/star/user/userInit"//初始化用户
#define URL_userInfo                    @"/v2/star/user/info"//用户基本信息
#define URL_userAssets                  @"/v2/star/user/assets"//用户资产信息
#define URL_userCard                    @"/v2/star/user/userCard"//用户卡片数据
#define URL_userInfo                    @"/v2/star/user/info"//用户基本信息
#define URL_cardSuit                    @"/v2/star/card/suit"//卡套配置
#define URL_cardTerm                    @"/v2/star/card/term"//期数配置
#define URL_cardTokenEvent              @"/v2/star/card/tokenIdEvent"//卡片生成事件
#define URL_projectList                 @"/v2/star/project/list"//功能列表
#define URL_addHash                     @"/v2/star/hash/add"//添加hash
#define URL_getCardCount                @"/app-api/collect/get_count_of_type"//抽卡
#endif /* URLMacros_h */
