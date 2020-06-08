//
//  NetworkTool.swift
//  TheNewOne
//
//  Created by 孟子弘 on 2019/4/9.
//  Copyright © 2019年 mzh. All rights reserved.
//

import UIKit
import Alamofire
//let newsBaseUrl = "http://192.168.1.199"
let newsBaseUrl = "http://cqscrb.top:8085"
let baseUrl = "http://api.yysc.online"
let imageBaseUrl = "http://image.yysc.online"
//let baseUrl = "http://192.168.1.101:8080"
enum projectName:String {
    case Chess = "chess"
    case blockChain = "blockchain"
    case futures = "futures"
}

@objcMembers
@objc class ApiTool: NSObject {
    
     /// 注册 POST
    static let registUrl = baseUrl + "/system/register"
    /// 登录 POST
    static let loginUrl = baseUrl + "/system/login"
    /// 刷新 GET
    static let refreshInfoUrl = baseUrl + "/user/personal/getUser"
    ///发送验证码 POST
    static let sendCodeUrl = baseUrl + "/system/sendCode"
    /// 图形验证
    static let picVertifyCode = baseUrl + "/system/sendVerify"
    ///忘记密码
    static let forgetPswUrl = baseUrl + "/system/resetPassword"
    ///更新个人信息 POST
    static let updateInfoUrl = baseUrl + "/user/personal/getUser"
    //修改个人信息 POST
    static let changeInfoUrl = baseUrl + "/user/personal/updateUser"
    ///更新头像 POST
    static let updateAvatarUrl = baseUrl + "/user/upload_avatar"
    ///获取推荐用户列表 GET
    static let getRecommandUserListUrl = baseUrl + "/user/follow/getRecommandUserList"
    // 获取用户关注或者粉丝列表
    static let getFollowedUserListUrl = baseUrl + "/user/follow/getUserFollowList"
    ///获取用户说说列表 GET
    static let getUserTalkListUrl = baseUrl + "/user/talk/getTalkList/"
    ///获取说说列表 GET
    static let getTalkListUrl = baseUrl + "/user/talk/getTalkListWithBlock"
    ///获取推荐说说列表 GET
    static let getRecommendTalkListUrl = baseUrl + "/futures/queryTalk"/**"/user/talk/getRecommandTalk"**/
    ///获取说说信息 GET
    static let getTalkByIdUrl = baseUrl + "/user/talk/getTalkById"
    ///获取说说评论列表 GET
    static let getTalkCommentByIdUrl = baseUrl + "/user/talk/getCommentList"
    ///说说历史记录 GET
    static let getUserTalkHistory = baseUrl + "/user/userTalk/getUserTalkList"
    ///获取猜你喜欢 GET
    static let getWhatYouLikeUrl = baseUrl + "/user/talk/getWhatYouLikeList"
    ///获取banner
    static let getBannerUrl = baseUrl + "/banner/getBannerList"
    /// 发布说说 POST
    static let publishTalkUrl = baseUrl + "/user/talk/publishTalk"
    /// 模糊查询说说 POST
    static let searchTalkUrl = baseUrl + "/user/talk/searchTalk"
    ///获取签到信息 GET
    static let getSignListUrl = baseUrl + "/user/sign/getSignList"
    ///签到 POST
    static let checkInUrl = baseUrl + "/user/sign/signNow"
    ///是否今天签到 GET
    static let isCheckInUrl = baseUrl + "/user/sign/hasSign"
    /// 是否关注该用户 GET
    static let isFollowUrl = baseUrl + "/user/follow/isFollow"
    ///关注用户 POST
    static let followUrl = baseUrl + "/user/follow/follow"
    ///获取粉丝列表 GET
    static let getUserFansOrFollowerListUrl = baseUrl + "/user/follow/getUserFollowList"
    ///评论说说 POST
    static let commentTalkUrl = baseUrl + "/user/talk/commentTalk"
    ///浏览,点赞,转发说说 POST 类型(1-浏览 2-点赞 3-转发)
    static let nongTalkUrl = baseUrl + "/user/userTalk/userTalkOperation"
    ///举报说说 POST
    static let reportTalkUrl = baseUrl + "/user/talk/reportTalk"
    ///屏蔽说说或用户 POST type 1-用户 2-说说
    static let screenTalkUrl = baseUrl + "/user/personal/block"
    ///拉黑用户 POST
    static let screenUserUrl = baseUrl + "/user/talk/reportTalk"
    ///产业快讯
    static let productionNewsUrl = baseUrl + "/admin/getFinanceTalk"
    ///数据日历
    static let calendaNewsUrl = baseUrl + "/admin/getFinanceCalender"
    ///实时新闻
    static let timeNewsUrl = baseUrl + "/page/readNews"
    ///上传图片
    static let uploadImgUrl = imageBaseUrl + "/upload"
    ///发推送
    static let sendNotifacation = baseUrl + "/jiGuang/sendMsg"
    
    ///修改密码
    static let modifyPswUrl = baseUrl + "/user/updatePwd"
    ///变更积分
    static let updatePointUrl = baseUrl + "/user/addintegral"
    ///阅读新闻
    static let readNewsUrl = baseUrl + "/page/readNews"
    
    //根据项目名获取说说列表
    static let getTalkListByProject = baseUrl + "/user/talk/getTalkListByProject"
    
}
@objcMembers
 class NetworkTool: NSObject {
    static let shared:NetworkTool = {
        let tools = NetworkTool()
        return tools
    }()
}


@objc extension NetworkTool {
    func get(_ urlString:String, viewcontroller:UIViewController?, params:[String:Any], success : @escaping ( _ responseObject : Any)->(), failture : @escaping (_ error : NSError)->()){
       
        Alamofire.request(urlString/*"https://www.ppfang.top/ppf/banner/selTransactionAndOnline.do"*/, method: .get, parameters:params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            
//            dprint(response.request?.url?.absoluteString ?? "")
            
            switch response.result {
            case .success(let value):
                do {
                    success(value)
                }
            case .failure(let error):
                do {
                    if viewcontroller != nil {
                       
                    }
                    
                    failture(error as NSError)
                }
                
            }
           
        }
    }
    
    func post(_ urlString:String, viewcontroller:UIViewController?, params:[String:Any],success : @escaping (_ responseObject : Any)->(), failture : @escaping (_ error : NSError)->()){
       
        Alamofire.request(urlString, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            
           
            print(response.request?.url?.absoluteString ?? "")
            switch response.result {
            case .success(let value):
                do {
                    success(value)
                }
            case .failure(let error):
                do {
                   
                    failture(error as NSError)
                }
                
            }
            
        }
    }
    
    func postJSON(_ urlString:String, viewcontroller:UIViewController?, params:[String:Any],success : @escaping (_ responseObject : Any)->(), failture : @escaping (_ error : NSError)->()){
       
        Alamofire.request(urlString, method: .post, parameters: params, encoding: JSONEncoding.default, headers: ["Content-Type":"application/json"]).responseJSON { (response) in
            print(response.request?.url?.absoluteString ?? "")
           
            switch response.result {
            case .success(let value):
                do {
                    success(value)
                }
            case .failure(let error):
                do {
                    
                    failture(error as NSError)
                }
                
            }
            
        }
    }
    
    func put(_ urlString:String, viewcontroller:UIViewController?, params:[String:Any],success : @escaping (_ responseObject : Any)->(), failture : @escaping (_ error : NSError)->()){
        
        Alamofire.request(urlString, method: .put, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            
            
            print(response.request?.url?.absoluteString ?? "")
            switch response.result {
            case .success(let value):
                do {
                    success(value)
                }
            case .failure(let error):
                do {
                    
                    failture(error as NSError)
                }
                
            }
            
        }
    }
    
    func putJSON(_ urlString:String, viewcontroller:UIViewController?, params:[String:Any],success : @escaping (_ responseObject : Any)->(), failture : @escaping (_ error : NSError)->()){
        
        Alamofire.request(urlString, method: .put, parameters: params, encoding: JSONEncoding.default, headers: ["Content-Type":"application/json"]).responseJSON { (response) in
            print(response.request?.url?.absoluteString ?? "")
            
            switch response.result {
            case .success(let value):
                do {
                    success(value)
                }
            case .failure(let error):
                do {
                    
                    failture(error as NSError)
                }
                
            }
            
        }
    }
    
    func post(_ urlString:String, image:UIImage, viewcontroller:UIViewController?, params:[String:Any],success : @escaping (_ responseObject : Any)->(), failture : @escaping (_ error : NSError)->()){
       
        Alamofire.upload(multipartFormData: { (mutiData) in
            for (key,value) in params {
                
                if let content = value as? String {
                    mutiData.append(content.data(using: .utf8)!, withName: key)
                }
            }
            
            mutiData.append(image.jpegData(compressionQuality: 0.8)!, withName: "picture", fileName: "head.jpeg", mimeType: "image/jpeg")

        }, usingThreshold: SessionManager.multipartFormDataEncodingMemoryThreshold, to: urlString, method: .put, headers: nil) { (result) in
            switch result {
            case.success(let mutiRequest,false,nil):
                do {
                    mutiRequest.responseJSON(completionHandler: { (response) in
                        
                        switch response.result {
                        case.success(let value):
                            do {
                                success(value)
                            }
                        case.failure(let value):
                            do {
                                
                                failture(value as NSError)
                            }
                        }
                    })
                }
            case.failure(let error):
                do {
                    
                    
                    failture(error as NSError)
                }
                
            case .success( _, true, _):
                break
            case .success( _, _, .some(_)):
                break
            }
        }
        
        
    }
        
    func post(_ urlString:String, fileName:String,image:UIImage?, viewcontroller:UIViewController?, params:[String:Any],success : @escaping (_ responseObject : Any)->(), failture : @escaping (_ error : NSError)->()){
        
        Alamofire.upload(multipartFormData: { (mutiData) in
    
            for (key,value) in params {
                
                if let content = value as? String {
                    mutiData.append(content.data(using: .utf8)!, withName: key)
                }
            }
            if image != nil {
                mutiData.append(image!.jpegData(compressionQuality: 0.1)!, withName: fileName, fileName: "head.jpeg", mimeType: "image/jpeg")
            }
            
        }, usingThreshold: SessionManager.multipartFormDataEncodingMemoryThreshold, to: urlString, method: .post, headers: nil) { (result) in
            switch result {
            case.success(let mutiRequest,false,nil):
                do {
                    mutiRequest.responseJSON(completionHandler: { (response) in
                        
                        switch response.result {
                        case.success(let value):
                            do {
                                success(value)
                            }
                        case.failure(let value):
                            do {
                                failture(value as NSError)
                            }
                        }
                    })
                }
            case.failure(let error):
                do {
                    
                    failture(error as NSError)
                }
                
            case .success( _, true, _):
                break
            case .success( _, _, .some(_)):
                break
            }
        }
        
        
    }
    
    func postReturnString(_ urlString:String, fileName:String,image:UIImage?, viewcontroller:UIViewController?, params:[String:Any],success : @escaping (_ responseObject : Any)->(), failture : @escaping (_ error : Error)->()){
        
        Alamofire.upload(multipartFormData: { (mutiData) in
            for (key,value) in params {
                
                if let content = value as? String {
                    mutiData.append(content.data(using: .utf8)!, withName: key)
                }
            }
            if image != nil {
                mutiData.append(image!.jpegData(compressionQuality: 0.8)!, withName: fileName, fileName: "head.jpeg", mimeType: "image/jpeg")
            }
            
        }, usingThreshold: SessionManager.multipartFormDataEncodingMemoryThreshold, to: urlString, method: .post, headers: nil) { (result) in
            switch result {
            case.success(let mutiRequest,false,nil):
                do {
                    mutiRequest.responseString(completionHandler: { (response) in
                        switch response.result {
                        case .success(let result) :
                            do {
                                success(result)
                            }
                        case .failure(let result) :
                            do {
                                failture(result)
                            }
                        default:
                            break
                            
                        }
                    })
                    
                }
            case.failure(let error):
                do {
                    
                    failture(error as NSError)
                }
                
            case .success( _, true, _):
                break
            case .success( _, _, .some(_)):
                break
            }
        }
        
        
    }
}
