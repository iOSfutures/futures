//
//  RHDJMacroUrlHeader.h
//  SCRBProject1
//
//  Created by zdh on 2019/6/25.
//  Copyright © 2019 zdh. All rights reserved.
//
//
//#ifndef MacroUrlHeader_h
//#define MacroUrlHeader_h
//
//#endif /* MacroUrlHeader_h */
#define BARNNER_URL @"/banner/getBannerList" //轮播图
#define GETMESSAGECODE_URL @"/system/sendCode" //获取验证码
#define LOGIN_URL   @"/system/login"
#define REGISTER_URL @"/system/register" //注册
#define RESETPWD_URL @"/system/resetPassword" //重置密码
#define HOMEVIEWNEWS_URL @"/futures/queryTalk" //首页推荐请求
#define RECOMMENEDATTENTION_URL @"/user/follow/getRecommandUserList" //推荐关注
#define RECOMMENDTALKLILST_URL @"/user/talk/getRecommandTalk" // 推荐说活列表
#define CALENDARDATALIST_URL @"/admin/getFinanceCalender" // 财经日历列表
#define USERSIGINHISTORY_URL @"/user/sign/getSignList" //用户签到接口
#define TODYHASSIGNIN_URL @"/user/sign/hasSign" //是否今天签到
#define SIGNIN_URL @"/user/sign/signNow" //签到
#define FINACETALK_URL @"/admin/getFinanceTalk" //财经说说
#define FINACEAFFAIRS_URL @"/admin/getFinanceAffairs" //财经大事
#define USERISFOLLOW_URL @"/user/follow/isFollow" //是否已经关注
#define USERFOLLOW_URL @"/user/follow/follow" // 关注
#define GAMESVIDEOLIST_URL @"/admin/game/queryGameVideo" //游戏视频
#define EVENTSLIST_URL @"/admin/game/querySchedule" //赛事 赛程列表
#define GAMEINFOMATIONS_URL @"/admin/game/querySchoolCityLeague"//获取游戏资讯
#define GETTALKLIST_URL @"/user/talk/getTalkListByProject" //根据项目名获取说说
#define GETGAEMINFODETAIL_URL @"/admin/game/queryMatchInfo" //获取比赛详情
#define UPLOADPIC_URL @"/system/uploadPicture" //上传图片
#define UPDATEUSERINFO_URL @"/user/personal/updateUser" //更新个人信息
#define GETUSERTALKLIST_URL(userId) [NSString stringWithFormat:@"/user/talk/getTalkList/%@",userId] // 获取用户说说
#define GETUSERLISTBYID_URL @"/user/personal/getUser" //获取用户信息
#define GETUSERTALKDISCUSSLIST_URL @"/user/talk/getCommentList" //获取用户说说评论列表
#define GETUSERMESSAGELIST_URL @"/user/personal/userMessage" //获取用户消息
#define SCREENUSERORTALK @"/user/personal/block" //屏蔽用户或者说说
#define REPORTUSERTALK @"/user/talk/reportTalk" //举报用户说说
#define GETUSERINFOBYID_URL @"/user/personal/queryUser" //根据id获取用户信息
