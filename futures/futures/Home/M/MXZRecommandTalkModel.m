//
//  MXZRecommandTalkModel.m
//  futures
//
//  Created by Francis on 2020/5/29.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "MXZRecommandTalkModel.h"

@implementation MXZRecommandTalkModel
+ (NSDictionary*) JSONKeyPathsByPropertyKey{
    return @{
             NSStringFromSelector(@selector(content)):@"content",
             };
}
@end
