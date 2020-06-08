//
//  MineEditProfileCell.m
//  futures
//
//  Created by Ssiswent on 2020/5/27.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "MineEditProfileCell.h"
#import "UserModel.h"

@interface MineEditProfileCell()<UITextFieldDelegate>

@end

@implementation MineEditProfileCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.signatureTextF.delegate = self;
}

- (void)setUser:(UserModel *)user
{
    _user = user;
    self.signatureTextF.text = user.signature;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if([self.delegate respondsToSelector:@selector(mineEditProfileCellDidEndEditing:changedSignature:)])
    {
        [self.delegate mineEditProfileCellDidEndEditing:self changedSignature:self.signatureTextF.text];
    }
}

@end
