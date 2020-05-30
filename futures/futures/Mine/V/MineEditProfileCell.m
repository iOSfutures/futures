//
//  MineEditProfileCell.m
//  futures
//
//  Created by Ssiswent on 2020/5/27.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "MineEditProfileCell.h"
#import "UserModel.h"

@interface MineEditProfileCell()

@property (weak, nonatomic) IBOutlet UITextField *signatureTextF;


@end

@implementation MineEditProfileCell

- (void)setUser:(UserModel *)user
{
    _user = user;
    _signatureTextF.text = user.signature;
}

@end
