//
//  CommunityDynamicModel.h
//  futures
//
//  Created by Ssiswent on 2020/5/20.
//  Copyright © 2020 Francis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@class UserModel;

@interface CommunityDynamicModel : BaseModel


@property (nonatomic, copy)NSString *content;
@property (nonatomic, copy)NSString *picture1;
@property (nonatomic, copy)NSString *picture2;
@property (nonatomic, strong)UserModel *user;

//"browserCount": 0,
//"commentCount": 0,
//"content": "在全球的体育明星中商业价值最高的是葡萄牙足球运动员C罗，他的老对手阿根廷足球运动员梅西紧随其后，美国篮球运动员库里和詹姆斯分列第3、第4，巴西足球运动员内马尔排在第5，中国排球运动员朱婷排在第6，她是目前中国体育商业价值最高的运动员。\r\n\r\n来自塞尔维亚的网球运动员德约科维奇排在第7，美国篮球运动员杜兰特排在第8，中国足球运动员武磊排在第9，中国排球运动员张常宁排在第10，来自中美的运动员各自占据了前十的三个席位。\r\n\r\n国乒世界冠军许昕、刘诗雯分别排在第11位和第12位，美国篮球运动员林书豪排在第13位，国乒世界冠军樊振东、张继科、丁宁分别排在第14位、15位和16位，中国田径运动员谢震业排在第17位，法国足球运动员博格巴排在第18位，中国短道速滑运动员武大靖排在第19位，瑞士网球运动员费德勒排在第20位。易建联的落选令人稍感意外。\r\n\r\n来自中国的体育运动员占据了20人中一半的席位，来自乒乓球、排球、足球、田径、短道速滑五个项目，武大靖是唯一上榜的冬季项目运动员。\r\n\r\n而在中国90后现役体育商业明星价值榜单top20里，从榜首开始依次是:朱婷、武磊、张常宁、许昕、刘诗雯、樊振东、丁宁、谢震业、武大靖、刘湘、徐嘉余、陈梦、林高远、袁心玥、龚翔宇、颜骏凌、郭艾伦、王蔷、王曼昱、傅园慧。国乒7人上榜，女排4人紧随其后，游泳3人。",
//"displayBig": true,
//"enable": true,
//"forwardCount": 0,
//"hasZan": false,
//"id": 1606,
//"picture": "http://image.yysc.online/files/2020/4/27/8df7b73a7820f4aef47864f2a6c5fccf.jpg",
//"publishTime": 1590597836000,
//"user": {
//    "album": "",
//    "fansCount": 0,
//    "followCount": 0,
//    "head": "http://image.yysc.online/",
//    "id": 1485,
//    "nickName": "不一样的你",
//    "password": "123456",
//    "phone": "13877541133",
//    "project": {
//        "id": 34,
//        "key": "sport1",
//        "name": "体育中文"
//    },
//    "projectKey": "sport1",
//    "signature": "不一样的烟火",
//    "talkCount": 0,
//    "type": 0,
//    "uuid": "c885443d97854abb956a03be820b86f3"
//},
//"userId": 1485,
//"video": null,
//"videoId": 0,
//"zanCount": 0

@end

NS_ASSUME_NONNULL_END
