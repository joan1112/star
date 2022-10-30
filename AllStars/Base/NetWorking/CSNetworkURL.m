//
//  CSNetworkURL.m
//  ComeSpeak
//
//  Created by Beyondream on 2020/9/25.
//  Copyright © 2020 XiaoLaiYingCai. All rights reserved.
//

#import "CSNetworkURL.h"

//**************************分享**************************//

/// 视频分享
NSString *const CS_HOME_VEDIO_SHARE = @"/videoSx?id=";

/// 图文分享
NSString *const CS_HOME_TEXT_SHARE = @"/textSx?id=";

/// 视频专辑分享
NSString *const CS_HOME_ALBUMVEDIO_SHARE = @"&type=text_album";

/// 图文专辑分享
NSString *const CS_HOME_ALBUMTEXT_SHARE = @"&type=video_album";

///启动页 /mobileBusiness/screen/getRandomPage
NSString *const CS_BASE_LAUCH = @"/mobileBusiness/screen/getRandomPage";

//**************************首页接口**************************//

/// 关注、取消关注   /mobileBusiness/myFollow
NSString *const CS_HOME_COLUMN_FOLLOW = @"/mobileBusiness/myFollow";

///收藏、取消收藏 /mobileBusiness/collect
NSString *const CS_HOME_COLLECT = @"/mobileBusiness/collect";

///点赞、取消点赞 /mobileBusiness/stars
NSString *const CS_HOME_ZAN = @"/mobileBusiness/stars";

///资源的评论列表 /mobileBusiness/comment/commentList
NSString *const CS_HOME_COMMENT_LIST = @"/mobileBusiness/comment/commentList";

///添加评论 /mobileBusiness/comment
NSString *const CS_HOME_COMMENT_ADD = @"/mobileBusiness/comment";

///举报评论 /mobileBusiness/report
NSString *const CS_HOME_COMMENT_REPORT = @"/mobileBusiness/report";

///会员权益 /mobileBusiness/ad/hyqy
NSString *const CS_HOME_AD_HUIYUANQUANYI = @"/mobileBusiness/ad/hyqy";

/// 首页获取一级栏目 /mobileBusiness/dictColumn/rootList
NSString *const CS_HOME_COLUMN_ROOTLIST = @"/mobileBusiness/dictColumn/rootList";

/// 首页根据栏目id获取专辑、视频、图文 /mobileBusiness/resourceInfo/rootDictColumn/pageList
NSString *const CS_HOME_COLUMN_ROOT_PAGE_LIST = @"/mobileBusiness/resourceInfo/rootDictColumn/pageList";

/// 我关注的人作品列表
NSString *const CS_HOME_MYFOLLOW = @"/mobileBusiness/myFollow/my";

/// 关注更多作者 /mobileBusiness/myFollow/more
NSString *const CS_HOME_FOLLOW_MOREAUTHOR = @"/mobileBusiness/myFollow/more";

/// 推荐-关注 /mobileBusiness/myFollow/recommend
NSString *const CS_HOME_RECOMMEND_FOLLOW = @"/mobileBusiness/myFollow/recommend";

/// 我的关注 /mobileBusiness/myFollow/all
NSString *const CS_HOME_MY_FOLLOW_ALL = @"/mobileBusiness/myFollow/all";

/// 首页-推荐 /mobileBusiness/recommend/resource
NSString *const CS_HOME_SUGGEST = @"/mobileBusiness/recommend/resource";

///首页推荐--置顶资源 /mobileBusiness/resourceInfo/top
NSString *const CS_HOME_SUGGEST_TOP = @"/mobileBusiness/resourceInfo/top";

/// 首页推荐banner /mobileBusiness/ad/code/index-top
NSString *const CS_HOME_SUGGEST_TOP_BANNER = @"/mobileBusiness/ad/code/index-top";

/// 会员权益banner /mobileBusiness/ad/code/index-hyqy
NSString *const CS_HOME_TOP_HYQY_BANNER = @"/mobileBusiness/ad/code/index-hyqy";

/// 根据广告位code获取Ad /mobileBusiness/ad/code
NSString *const CS_HOME_SUGGEST_ADMANAGER_CODE = @"/mobileBusiness/ad/code";

/// 首页推荐banner下的item /mobileBusiness/adManager/list
NSString *const CS_HOME_SUGGEST_ADMANAGER_ITEM = @"/mobileBusiness/adManager/list";

/// 首页推荐banner下的item学历教育 /mobileBusiness/credentialTemplate/list
NSString *const CS_HOME_SUGGEST_CREDENT_EDU = @"/mobileBusiness/credentialTemplate/list";

// 我的直播房间列表/liveBusiness/room/my
NSString *const CS_HOME_LIVING_ROOM_MY = @"/liveBusiness/room/my";

// 直播中页面的置顶接口 /liveBusiness/room/topRoom
NSString *const CS_HOME_LIVING_ROOM_TOP = @"/liveBusiness/room/topRoom";

// 有直播课的日期接口 /liveBusiness/room/isHaveLive
NSString *const CS_HOME_LIVING_DATE = @"/liveBusiness/room/isHaveLive";

// 有直播课的日期接口 /liveBusiness/room/liveNotice
NSString *const CS_HOME_LIVING_LIVENOTICE = @"/liveBusiness/room/liveNotice";

//视频和图文资源大师课/mobileBusiness/resourceInfo/masterResource
NSString *const CS_HOME_TEACHER_MASTER_RESOURCE = @"/mobileBusiness/resourceInfo/masterResource";

///名师大咖 /mobileBusiness/recommend/famousTeacher
NSString *const CS_HOME_TEACHER_FAMOUS = @"/mobileBusiness/recommend/famousTeacher";


// 直播房间列表 /liveBusiness/room/living
NSString *const CS_HOME_LIVING_ROOM = @"/liveBusiness/room/living";

///直播中 /mobileBusiness/resourceInfo/masterLiving
NSString *const CS_HOME_MASTER_LIVING = @"/mobileBusiness/resourceInfo/masterLiving";

//无直播课程的资源显示 /mobileBusiness/resourceInfo/noLiving
NSString *const CS_HOME_LIVING_NO_LIVING_SUGGEST = @"/mobileBusiness/resourceInfo/noLiving";

// 大咖名师列表 /mobileBusiness/recommend/famousTeacher
NSString *const CS_HOME_FamousTeacher = @"/mobileBusiness/recommend/famousTeacher";

// 免费课程列表 /mobileBusiness/subjectResource/pageList
NSString *const CS_HOME_FreeClassList = @"/mobileBusiness/subjectResource/pageList";

//查询有线下课的日期 /mobileBusiness/class/isHaveClass
NSString *const CS_HOME_OFF_LINECLASS_DATA = @"/mobileBusiness/class/isHaveClass";

//查询某天列表 mobileBusiness/class/list
NSString *const CS_HOME_OFF_LINECLASS_LIST = @"/mobileBusiness/class/list";

//线下课详情 /mobileBusiness/class
NSString *const CS_HOME_OFF_LINECLASS_DETAIL = @"/mobileBusiness/class";

///线下课报名 /mobileBusiness/tLineClassApply
NSString *const CS_HOME_OFF_LINECLASS_APPLY = @"/mobileBusiness/tLineClassApply";

///视频、图文、校盈圈详情页 /mobileBusiness/resourceInfo/info
NSString *const CS_HOME_RESOURCE_INFO = @"/mobileBusiness/resourceInfo/info";


//视频详情页面-根据栏目推荐视频 /mobileBusiness/resourceInfo/videoRecommend
NSString *const CS_HOME_RESOURCE_INFO_DETAIL_VIDEORECOMMEND = @"/mobileBusiness/resourceInfo/videoRecommend";

///图文详情页面-根据栏目推荐 /mobileBusiness/resourceInfo/textRecommend
NSString *const CS_HOME_RESOURCE_INFO_DETAIL_TEXTRECOMMEND = @"/mobileBusiness/resourceInfo/textRecommend";


///根据专辑id获取视频 /mobileBusiness/video/pageList
NSString *const CS_ALBUM_VIDEO_PAGELIST = @"/mobileBusiness/video/pageList";

///根据专辑id获取图文 /mobileBusiness/text/pageList
NSString *const CS_ALBUM_TEXT_PAGELIST = @"/mobileBusiness/text/pageList";

///根据关键词 返回相关热点词 /search/elasticSearch/queryLog_hit_page
NSString *const CS_HOME_ELASTICSEARCH_HITPAGE = @"/search/elasticSearch/queryLog_hit_page";

///根据关键词   返回搜索结果 /search/elasticSearch/queryEntity_hit_page
NSString *const CS_HOME_ELASTICSEARCH_LIST = @"/search/elasticSearch/queryEntity_hit_page";

///维护观看时长 /mobileBusiness/record/times
NSString *const CS_HOME_VIDEO_RECORD_TEIMS = @"/mobileBusiness/record/times";



//**************************登录注册接口**************************//

/// 移动端用户账户信息 /mobileBusiness/account/getInfo
NSString *const CS_ACCOUNT_GETINFO_URL = @"/mobileBusiness/account/getInfo";

/// 用户注册 /system/mobileUser/register
NSString *const CS_MOBILEUSER_REGIST_URL = @"/system/mobileUser/register";

/// 发送验证码 /system/sms/sendCodeSms
NSString *const CS_SENDCODE_SMS_URL = @"/system/sms/sendCodeSmsSlide";

/// 校验验证码 /system/sms/volidCode
NSString *const CS_VOLID_CODE_URL = @"/system/captcha/get";

/// 忘记密码 /system/mobileUser/updateMobilePass
NSString *const CS_FORGET_PWD_URL = @"/system/mobileUser/updateMobilePass";

/// 移动端查询用户信息 /system/mobileUser/mobileQueryInfo/getDetailInfo
NSString *const CS_GETUSER_INFO_URL = @"/system/mobileUser/mobileQueryInfo/getDetailInfo";

// 修改用户信息 /system/mobileUser/mobileEdit
NSString *const CS_MOBILEEDIT_URL = @"/system/mobileUser/mobileEdit";

// 用户登录 /auth/oauth/token
NSString *const CS_USER_LOGIN_URL = @"/auth/oauth/token";

/// 用户是否是名师(后台无法用一个用户信息接口提供,此接口只为获取authentication字段 ,不做他用) /mobileBusiness/user/getDetailInfo
NSString *const CS_GETUSER_DETAIL_INFO_URL = @"/mobileBusiness/user/getDetailInfo";

//// 修改用户信息/system/mobileUser/mobileEdit
NSString *const CS_USER_MOBILE_EDIT = @"/system/mobileUser/mobileEdit";

///移动端职务 /system/dict/data/type/job_mobile
NSString *const CS_SYSTEM_MOBILE_JOB = @"/system/dict/data/type/job_mobile";
///支付方式 /system/dict/data/type/pay_type
NSString *const CS_SYSTEM_MOBILE_PAY_TYPE = @"/system/dict/data/type/pay_type";
///产品类型 /system/dict/data/type/product_type
NSString *const CS_SYSTEM_MOBILE_PRODUCT_TYPE = @"/system/dict/data/type/product_type";
///用户性别 /system/dict/data/type/sys_user_sex
NSString *const CS_SYSTEM_MOBILE_USER_SEX = @"/system/dict/data/type/sys_user_sex";
///分享图片 /system/dict/data/type/shareImg
NSString *const CS_SYSTEM_MOBILE_SHARE_IMG = @"/system/dict/data/type/shareImg";
///举报类型 /system/dict/data/type/jubao_type
NSString *const CS_SYSTEM_MOBILE_JUBAO_TYPE = @"/system/dict/data/type/jubao_type";
///校盈圈模块类型 /system/dict/data/type/module_type
NSString *const CS_SYSTEM_MOBILE_EDIT_MODULE_TYPE = @"/system/dict/data/type/module_type";
///爱好类型 /system/dict/data/type/hobby
NSString *const CS_SYSTEM_MOBILE_EDIT_HOBBY = @"/system/dict/data/type/hobby";
///查询全国行政区划 /system/district/getAllDistrict
NSString *const CS_SYSTEM_MOBILE_GET_ALL_DISTRICT = @"/system/district/getAllDistrict";

//查询机构 /system/org/queryParam/queryAllOrg
NSString *const CS_SYSTEM_ORG_QUERYALLORG = @"/system/org/queryParam/queryAllOrg";






//**************************个人中心接口**************************//

///我的收藏 /mobileBusiness/collect/my
NSString *const CS_MOBILE_MINE_COLLECT = @"/mobileBusiness/collect/my";

///我的证书 /mobileBusiness/credential/list
NSString *const CS_MOBILE_MINE_CREDENTIAL = @"/mobileBusiness/credential/list";

///待付款个数 /mobileBusiness/order/orderList/notPayCount
NSString *const CS_MOBILE_MINE_NOT_PAYCOUNT = @"/mobileBusiness/order/orderList/notPayCount";

///全部订单 待支付 已支付 /mobileBusiness/order/orderList/type
NSString *const CS_MOBILE_MINE_ORDER_LIST = @"/mobileBusiness/order/orderList/type";

///评论和问答的个数    /mobileBusiness/myNotice/isReadCount
NSString *const CS_MOBILE_MINE_NOTICE_READCOUNT = @"/mobileBusiness/myNotice/isReadCount";
///评论/点赞 /mobileBusiness/myNotice/commentAndStars
NSString *const CS_MOBILE_MINE_NOTICE_COMMENT_STARS = @"/mobileBusiness/myNotice/commentAndStars";

///系统消息已读 /mobileBusiness/myNotice/batch_update_read
NSString *const CS_MOBILE_MINE_NOTICE_READ = @"/mobileBusiness/myNotice/batch_update_read";

/// 资源存在不 /mobileBusiness/myNotice/isExist/
NSString *const CS_MOBILE_MINE_NOTICE_ISEXIST = @"/mobileBusiness/myNotice/isExist";

///退出登录 /auth/token/logout
NSString *const CS_MOBILE_AUTH_LOGOUT = @"/auth/token/logout";

///作者信息 个人主页 /mobileBusiness/resourceInfo/authorInfo
NSString *const CS_MOBILE_AUTHOR_INFO = @"/mobileBusiness/resourceInfo/authorInfo";

///作者发布的资源 /mobileBusiness/resourceInfo/authorResource
NSString *const CS_MOBILE_AUTHOR_RESOURCE = @"/mobileBusiness/resourceInfo/authorResource";

///新增作业上传 /mobileBusiness/work
NSString *const CS_MOBILE_HOMEWORK_UPLOAD = @"/mobileBusiness/work";

/// 分销 /system/dict/data/type/fenxiao_img
NSString *const CS_SYSTEM_FENXIAO = @"/system/dict/data/type/fenxiao_img";

/// 邀请好友 /system/dict/data/type/shareImg
NSString *const CS_SYSTEM_SHARE_FRIEND = @"/system/dict/data/type/shareImg";

///意见反馈 /mobileBusiness/adviceFeedback
NSString *const CS_MOBILE_FEEDBACK = @"/mobileBusiness/adviceFeedback";

// 收益明细 /mobileBusiness/accountRecord/listCashRecord
NSString *const CS_MOBILE_LIST_CASH_RECORD = @"/mobileBusiness/accountRecord/listCashRecord";

/// 获取内购充值金额 /system/dict/data/type/ios_daibi_type
NSString *const CS_SYSTEM_DAIBI_TYPE = @"/system/dict/data/type/ios_daibi_type";

///  提现到ZFB /mobileBusiness/order/cashOut/aliPay
NSString *const CS_MOBILE_CASHOUT_ALIPAY = @"/mobileBusiness/order/cashOut/aliPay";

/// 用户协议接口 /mobileBusiness/agree/selectAgree
 NSString *const CS_MOBILE_USER_AGREEMENT = @"/mobileBusiness/agree/selectAgree";










//**************************直播接口**************************//

// 直播推流 /liveBusiness/room/roomInfo
NSString *const CS_MOBILEEDIT_PushStream = @"/liveBusiness/room/pushStream";

// 直播拉流 /liveBusiness/room/pullStream
NSString *const CS_MOBILEEDIT_PullStream = @"/liveBusiness/room/pullStream";

// 直播禁言 /liveBusiness/roomWatchRecord/forbid
NSString *const CS_MOBILEEDIT_WatchLiveForbid = @"/liveBusiness/roomWatchRecord/forbid";

// 直播踢人 /liveBusiness/roomWatchRecord/kickOut
NSString *const CS_MOBILEEDIT_LiveRoomKickOut = @"/liveBusiness/roomWatchRecord/kickOut";

// 直播全场禁言 /liveBusiness/room/roomForbid
NSString *const CS_MOBILEEDIT_LiveRoomForbid = @"/liveBusiness/room/roomForbid";

// 直播关闭 /liveBusiness/room/liveClose
NSString *const CS_MOBILEEDIT_LiveClose = @"/liveBusiness/room/liveClose";

// 直播观看数 /liveBusiness/room/watchCount
NSString *const CS_MOBILEEDIT_LiveWatchCount = @"/liveBusiness/room/watchCount";





//**************************分类接口**************************//

// 栏目数据 /mobileBusiness/dictColumn/columnTree
 NSString *const CS_MOBILEEDIT_columnTree = @"/mobileBusiness/dictColumn/columnTree";

// 作者的资源 /mobileBusiness/resourceInfo/authorResource
 NSString *const CS_MOBILEEDIT_authorResource = @"/mobileBusiness/resourceInfo/authorResource";

// 图文专辑详情 /mobileBusiness/text/pageList
NSString *const CS_MOBILEEDIT_AlbumTextDetail = @"/mobileBusiness/text/pageList";

// 视频专辑详情 /mobileBusiness/video/pageList
NSString *const CS_MOBILEEDIT_AlbumVideoDetail = @"/mobileBusiness/video/pageList";

/// 栏目价格获取 /mobileBusiness/dictColumn/isBuy
 NSString *const CS_MOBILEEDIT_Column_isBuy = @"/mobileBusiness/dictColumn/isBuy";

///直播预约 /mobileBusiness/roomAppointment
NSString *const CS_MOBILEEDIT_ROOM_APPOINTMENT = @"/mobileBusiness/roomAppointment";


//**************************我的学习接口**************************//
///学习内容     /mobileBusiness/myStudy/history
 NSString *const CS_MOBILE_MINE_StudyList = @"/mobileBusiness/myStudy/history";
///学习统计       /mobileBusiness/myStudy/statistical /mobileBusiness/myStudy/lineChart
 NSString *const CS_MOBILE_MINE_StudyStatistical=@"/mobileBusiness/myStudy/statistical";
///折线图       /mobileBusiness/myStudy/lineChart
 NSString *const CS_MOBILE_MINE_StudylineChart=@"/mobileBusiness/myStudy/lineChart";

//**************************学习记录接口**************************//
///学习课程     //mobileBusiness/record/learnCourse
 NSString *const CS_MOBILE_MINE_learnCourse = @"/mobileBusiness/record/learnCourse";
///课程详情      /mobileBusiness/record/albumCourse
 NSString *const CS_MOBILE_MINE_albumCourse = @"/mobileBusiness/record/albumCourse";

//**************************订单支付相关接口**************************//
/// 创建支付订单    /mobileBusiness/order/createOrder
NSString *const CS_MOBILEEDIT_CREATE_ORDER = @"/mobileBusiness/order/createOrder";
NSString *const CS_MOBILEEDIT_IOSPAY = @"/mobileBusiness/order/queryIosPayStatus";

//版本更新     /mobileBusiness/version/max/ios
NSString *const CS_MOBILE_VERSION = @"/mobileBusiness/version/max/ios";
