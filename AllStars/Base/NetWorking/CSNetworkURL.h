//
//  CSNetworkURL.h
//  ComeSpeak
//
//  Created by Beyondream on 2020/9/25.
//  Copyright © 2020 XiaoLaiYingCai. All rights reserved.
//

#import <Foundation/Foundation.h>

//**************************分享**************************//

/// 视频分享
UIKIT_EXTERN NSString *const CS_HOME_VEDIO_SHARE;

/// 图文分享
UIKIT_EXTERN NSString *const CS_HOME_TEXT_SHARE;

/// 视频专辑分享
UIKIT_EXTERN NSString *const CS_HOME_ALBUMVEDIO_SHARE;

/// 图文专辑分享
UIKIT_EXTERN NSString *const CS_HOME_ALBUMTEXT_SHARE;

///启动页 /mobileBusiness/screen/getRandomPage
UIKIT_EXTERN NSString *const CS_BASE_LAUCH;

//**************************首页接口**************************//

/// 关注、取消关注   /mobileBusiness/myFollow
UIKIT_EXTERN NSString *const CS_HOME_COLUMN_FOLLOW;

///收藏、取消收藏 /mobileBusiness/collect
UIKIT_EXTERN NSString *const CS_HOME_COLLECT;

///点赞、取消点赞 /mobileBusiness/stars
UIKIT_EXTERN NSString *const CS_HOME_ZAN;

///资源的评论列表 /mobileBusiness/comment/commentList
UIKIT_EXTERN NSString *const CS_HOME_COMMENT_LIST;

///添加评论 /mobileBusiness/comment
UIKIT_EXTERN NSString *const CS_HOME_COMMENT_ADD;

///举报评论 /mobileBusiness/report
UIKIT_EXTERN NSString *const CS_HOME_COMMENT_REPORT;

///会员权益 /mobileBusiness/ad/hyqy
UIKIT_EXTERN NSString *const CS_HOME_AD_HUIYUANQUANYI;

/// 首页获取一级栏目 /mobileBusiness/dictColumn/rootList
UIKIT_EXTERN NSString *const CS_HOME_COLUMN_ROOTLIST;

/// 首页根据父级栏目id获取视频和图文和专辑 /mobileBusiness/resourceInfo/rootDictColumn/pageList
UIKIT_EXTERN NSString *const CS_HOME_COLUMN_ROOT_PAGE_LIST;

/// 我关注的人作品列表 /mobileBusiness/myFollow/my
UIKIT_EXTERN NSString *const CS_HOME_MYFOLLOW;

/// 关注更多作者 /mobileBusiness/myFollow/more
UIKIT_EXTERN NSString *const CS_HOME_FOLLOW_MOREAUTHOR;

/// 推荐-关注 /mobileBusiness/myFollow/recommend
UIKIT_EXTERN NSString *const CS_HOME_RECOMMEND_FOLLOW;

/// 我的关注 /mobileBusiness/myFollow/all
UIKIT_EXTERN NSString *const CS_HOME_MY_FOLLOW_ALL;

/// 首页-推荐 /mobileBusiness/recommend/resource
UIKIT_EXTERN NSString *const CS_HOME_SUGGEST;

///首页推荐--置顶资源 /mobileBusiness/resourceInfo/top
UIKIT_EXTERN NSString *const CS_HOME_SUGGEST_TOP;

/// 首页推荐banner /mobileBusiness/ad/code/index-top
UIKIT_EXTERN NSString *const CS_HOME_SUGGEST_TOP_BANNER;

/// 会员权益banner /mobileBusiness/ad/code/index-hyqy
UIKIT_EXTERN NSString *const CS_HOME_TOP_HYQY_BANNER;

/// 根据广告位code获取Ad /mobileBusiness/ad/code
UIKIT_EXTERN NSString *const CS_HOME_SUGGEST_ADMANAGER_CODE;

/// 首页推荐banner下的item /mobileBusiness/adManager/list
UIKIT_EXTERN NSString *const CS_HOME_SUGGEST_ADMANAGER_ITEM;

/// 首页推荐banner下的item学历教育 /mobileBusiness/credentialTemplate/list
UIKIT_EXTERN NSString *const CS_HOME_SUGGEST_CREDENT_EDU;

/// 我的直播房间列表/liveBusiness/room/my
UIKIT_EXTERN NSString *const CS_HOME_LIVING_ROOM_MY;

/// 直播中页面的置顶接口 /liveBusiness/room/topRoom
UIKIT_EXTERN NSString *const CS_HOME_LIVING_ROOM_TOP;

/// 有直播课的日期接口 /liveBusiness/room/isHaveLive
UIKIT_EXTERN NSString *const CS_HOME_LIVING_DATE;

/// 有直播课的日期接口 /liveBusiness/room/liveNotice
UIKIT_EXTERN NSString *const CS_HOME_LIVING_LIVENOTICE;

///视频和图文资源大师课/mobileBusiness/resourceInfo/masterResource
UIKIT_EXTERN NSString *const CS_HOME_TEACHER_MASTER_RESOURCE;

///名师大咖 /mobileBusiness/recommend/famousTeacher
UIKIT_EXTERN NSString *const CS_HOME_TEACHER_FAMOUS;


/// 直播房间列表 /liveBusiness/room/living
UIKIT_EXTERN NSString *const CS_HOME_LIVING_ROOM;

///直播中 /mobileBusiness/resourceInfo/masterLiving
UIKIT_EXTERN NSString *const CS_HOME_MASTER_LIVING;

///无直播课程的资源显示 /mobileBusiness/resourceInfo/noLiving
UIKIT_EXTERN NSString *const CS_HOME_LIVING_NO_LIVING_SUGGEST;

/// 大咖名师列表 /mobileBusiness/recommend/famousTeacher
UIKIT_EXTERN NSString *const CS_HOME_FamousTeacher;

/// 免费课程列表 /mobileBusiness/subjectResource/pageList
UIKIT_EXTERN NSString *const CS_HOME_FreeClassList;

///查询有线下课的日期 /mobileBusiness/class/isHaveClass
UIKIT_EXTERN NSString *const CS_HOME_OFF_LINECLASS_DATA;
///查询某天列表 mobileBusiness/class/list
UIKIT_EXTERN NSString *const CS_HOME_OFF_LINECLASS_LIST;
///线下课详情 /mobileBusiness/class
UIKIT_EXTERN NSString *const CS_HOME_OFF_LINECLASS_DETAIL;

///线下课报名 /mobileBusiness/tLineClassApply
UIKIT_EXTERN NSString *const CS_HOME_OFF_LINECLASS_APPLY;

///视频、图文、校盈圈详情页 /mobileBusiness/resourceInfo/info
UIKIT_EXTERN NSString *const CS_HOME_RESOURCE_INFO;

///视频详情页面-根据栏目推荐视频 /mobileBusiness/resourceInfo/videoRecommend
UIKIT_EXTERN NSString *const CS_HOME_RESOURCE_INFO_DETAIL_VIDEORECOMMEND;

///图文详情页面-根据栏目推荐 /mobileBusiness/resourceInfo/textRecommend
UIKIT_EXTERN NSString *const CS_HOME_RESOURCE_INFO_DETAIL_TEXTRECOMMEND;



///根据专辑id获取视频 /mobileBusiness/video/pageList
UIKIT_EXTERN NSString *const CS_ALBUM_VIDEO_PAGELIST;

///根据专辑id获取图文 /mobileBusiness/text/pageList
UIKIT_EXTERN NSString *const CS_ALBUM_TEXT_PAGELIST;

///根据关键词 返回相关热点词 /search/elasticSearch/queryLog_hit_page
UIKIT_EXTERN NSString *const CS_HOME_ELASTICSEARCH_HITPAGE;

///根据关键词   返回搜索结果 /search/elasticSearch/queryEntity_hit_page
UIKIT_EXTERN NSString *const CS_HOME_ELASTICSEARCH_LIST;

///维护观看时长 /mobileBusiness/record/times
UIKIT_EXTERN NSString *const CS_HOME_VIDEO_RECORD_TEIMS;


//**************************登录注册接口**************************//

/// 移动端用户账户信息 /mobileBusiness/account/getInfo
UIKIT_EXTERN NSString *const CS_ACCOUNT_GETINFO_URL;

/// 用户注册 /system/mobileUser/register
UIKIT_EXTERN NSString *const CS_MOBILEUSER_REGIST_URL;

/// 发送验证码 /system/sms/sendCodeSms
UIKIT_EXTERN NSString *const CS_SENDCODE_SMS_URL;

/// 校验验证码 /system/sms/volidCode
UIKIT_EXTERN NSString *const CS_VOLID_CODE_URL;

/// 忘记密码 /system/mobileUser/updateMobilePass
UIKIT_EXTERN NSString *const CS_FORGET_PWD_URL;

/// 移动端查询用户信息 /system/mobileUser/mobileQueryInfo/getDetailInfo
UIKIT_EXTERN NSString *const CS_GETUSER_INFO_URL;

/// 修改用户信息 /system/mobileUser/mobileEdit
UIKIT_EXTERN NSString *const CS_MOBILEEDIT_URL;

/// 用户登录 /auth/oauth/token
UIKIT_EXTERN NSString *const CS_USER_LOGIN_URL;

/// 用户是否是名师(后台无法用一个用户信息接口提供,此接口只为获取authentication字段 ,不做他用) /mobileBusiness/user/getDetailInfo
UIKIT_EXTERN NSString *const CS_GETUSER_DETAIL_INFO_URL;

//// 修改用户信息system/mobileUser/mobileEdit
UIKIT_EXTERN NSString *const CS_USER_MOBILE_EDIT;

///移动端职务 /system/dict/data/type/job_mobile
UIKIT_EXTERN NSString *const CS_SYSTEM_MOBILE_JOB;
///支付方式 /system/dict/data/type/pay_type
UIKIT_EXTERN NSString *const CS_SYSTEM_MOBILE_PAY_TYPE;
///产品类型 /system/dict/data/type/product_type
UIKIT_EXTERN NSString *const CS_SYSTEM_MOBILE_PRODUCT_TYPE;
///用户性别 /system/dict/data/type/sys_user_sex
UIKIT_EXTERN NSString *const CS_SYSTEM_MOBILE_USER_SEX;
///分享图片 /system/dict/data/type/shareImg
UIKIT_EXTERN NSString *const CS_SYSTEM_MOBILE_SHARE_IMG;
///举报类型 /system/dict/data/type/jubao_type
UIKIT_EXTERN NSString *const CS_SYSTEM_MOBILE_JUBAO_TYPE;
///模块类型 /system/dict/data/type/module_type
UIKIT_EXTERN NSString *const CS_SYSTEM_MOBILE_EDIT_MODULE_TYPE;
///爱好类型 /system/dict/data/type/hobby
UIKIT_EXTERN NSString *const CS_SYSTEM_MOBILE_EDIT_HOBBY;
///查询全国行政区划 system/district/getAllDistrict
UIKIT_EXTERN NSString *const CS_SYSTEM_MOBILE_GET_ALL_DISTRICT;
//查询机构 /system/org/queryParam/queryAllOrg
UIKIT_EXTERN NSString *const CS_SYSTEM_ORG_QUERYALLORG;


//**************************个人中心接口**************************//

///我的收藏 /mobileBusiness/collect/my
UIKIT_EXTERN NSString *const CS_MOBILE_MINE_COLLECT;

///我的证书 /mobileBusiness/credential/list
UIKIT_EXTERN NSString *const CS_MOBILE_MINE_CREDENTIAL;

///待付款个数 /mobileBusiness/order/orderList/notPayCount
UIKIT_EXTERN NSString *const CS_MOBILE_MINE_NOT_PAYCOUNT;

///全部订单 待支付 已支付 /mobileBusiness/order/orderList/type
UIKIT_EXTERN NSString *const CS_MOBILE_MINE_ORDER_LIST;

///评论和问答的个数    /mobileBusiness/myNotice/isReadCount
UIKIT_EXTERN NSString *const CS_MOBILE_MINE_NOTICE_READCOUNT;

///评论/点赞 /mobileBusiness/myNotice/commentAndStars
UIKIT_EXTERN NSString *const CS_MOBILE_MINE_NOTICE_COMMENT_STARS;

///系统消息已读 /mobileBusiness/myNotice/batch_update_read
UIKIT_EXTERN NSString *const CS_MOBILE_MINE_NOTICE_READ;

/// 资源存在不 /mobileBusiness/myNotice/isExist/
UIKIT_EXTERN NSString *const CS_MOBILE_MINE_NOTICE_ISEXIST;


///退出登录 /auth/token/logout
UIKIT_EXTERN NSString *const CS_MOBILE_AUTH_LOGOUT;

///作者信息 个人主页 /mobileBusiness/resourceInfo/authorInfo
UIKIT_EXTERN NSString *const CS_MOBILE_AUTHOR_INFO;

///作者发布的资源 /mobileBusiness/resourceInfo/authorResource
UIKIT_EXTERN NSString *const CS_MOBILE_AUTHOR_RESOURCE;

///新增作业上传 /mobileBusiness/work
UIKIT_EXTERN NSString *const CS_MOBILE_HOMEWORK_UPLOAD;

/// 分销 /system/dict/data/type/fenxiao_img
UIKIT_EXTERN NSString *const CS_SYSTEM_FENXIAO;

/// 邀请好友 /system/dict/data/type/shareImg
UIKIT_EXTERN NSString *const CS_SYSTEM_SHARE_FRIEND;

///意见反馈 /mobileBusiness/adviceFeedback
UIKIT_EXTERN NSString *const CS_MOBILE_FEEDBACK;

/// 收益明细 /mobileBusiness/accountRecord/listCashRecord
UIKIT_EXTERN NSString *const CS_MOBILE_LIST_CASH_RECORD;

/// 获取内购充值金额 /system/dict/data/type/ios_daibi_type
UIKIT_EXTERN NSString *const CS_SYSTEM_DAIBI_TYPE;

///  提现到ZFB /mobileBusiness/order/cashOut/aliPay
UIKIT_EXTERN NSString *const CS_MOBILE_CASHOUT_ALIPAY;


/// 用户协议接口 /mobileBusiness/agree/selectAgree
UIKIT_EXTERN NSString *const CS_MOBILE_USER_AGREEMENT;



//**************************直播接口**************************//

// 直播推流 /liveBusiness/room/roomInfo mobileBusiness/dictColumn/columnTree
UIKIT_EXTERN NSString *const CS_MOBILEEDIT_PushStream;

// 直播拉流 /liveBusiness/room/pullStream
UIKIT_EXTERN NSString *const CS_MOBILEEDIT_PullStream;

// 直播禁言 /liveBusiness/roomWatchRecord/forbid
UIKIT_EXTERN NSString *const CS_MOBILEEDIT_WatchLiveForbid;

// 直播踢人 /liveBusiness/roomWatchRecord/kickOut
UIKIT_EXTERN NSString *const CS_MOBILEEDIT_LiveRoomKickOut;

// 直播全场禁言 /liveBusiness/room/roomForbid
UIKIT_EXTERN NSString *const CS_MOBILEEDIT_LiveRoomForbid;

// 直播关闭 /liveBusiness/room/liveClose
UIKIT_EXTERN NSString *const CS_MOBILEEDIT_LiveClose;

// 直播观看数 /liveBusiness/room/watchCount
UIKIT_EXTERN NSString *const CS_MOBILEEDIT_LiveWatchCount;









//**************************分类接口**************************//



// 栏目数据 / mobileBusiness/dictColumn/columnTree
UIKIT_EXTERN NSString *const CS_MOBILEEDIT_columnTree;

// 作者的资源 /mobileBusiness/resourceInfo/authorResource
UIKIT_EXTERN NSString *const CS_MOBILEEDIT_authorResource;

// 图文专辑详情 /mobileBusiness/text/pageList
UIKIT_EXTERN NSString *const CS_MOBILEEDIT_AlbumTextDetail;

// 视频专辑详情 /mobileBusiness/video/pageList
UIKIT_EXTERN NSString *const CS_MOBILEEDIT_AlbumVideoDetail;

/// 栏目价格获取 /mobileBusiness/dictColumn/isBuy
UIKIT_EXTERN NSString *const CS_MOBILEEDIT_Column_isBuy;

///直播预约 /mobileBusiness/roomAppointment
UIKIT_EXTERN NSString *const CS_MOBILEEDIT_ROOM_APPOINTMENT;



//**************************我的学习接口**************************//
///学习历史     /mobileBusiness/myStudy/history
UIKIT_EXTERN NSString *const CS_MOBILE_MINE_StudyList;
///学习统计       /mobileBusiness/myStudy/statistical
UIKIT_EXTERN NSString *const CS_MOBILE_MINE_StudyStatistical;
///折线图       /mobileBusiness/myStudy/lineChart
UIKIT_EXTERN NSString *const CS_MOBILE_MINE_StudylineChart;

//**************************学习记录接口**************************//
///学习课程     //mobileBusiness/record/learnCourse
UIKIT_EXTERN NSString *const CS_MOBILE_MINE_learnCourse;
///课程详情      /mobileBusiness/record/albumCourse
UIKIT_EXTERN NSString *const CS_MOBILE_MINE_albumCourse;


//**************************订单支付相关接口**************************//
/// 创建支付订单    /mobileBusiness/order/createOrder
UIKIT_EXTERN NSString *const CS_MOBILEEDIT_CREATE_ORDER;
UIKIT_EXTERN NSString *const CS_MOBILEEDIT_IOSPAY;



//版本更新     /mobileBusiness/version/max/ios
UIKIT_EXTERN NSString *const CS_MOBILE_VERSION;
