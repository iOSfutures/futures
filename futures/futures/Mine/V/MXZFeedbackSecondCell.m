//
//  MXZFeedbackSecondCell.m
//  futures
//
//  Created by Francis on 2020/5/26.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "MXZFeedbackSecondCell.h"

@interface MXZFeedbackSecondCell()<UITextViewDelegate>

@end
@implementation MXZFeedbackSecondCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _addPicBtn.layer.cornerRadius = 6;
    _addPicBtn.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:0.7];
    self.contentTextView.delegate = self;
    self.picImage.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if(_textBlock){
        _textBlock(self.contentTextView.text);
    }
}

-(BOOL)textViewShouldEndEditing:(UITextView *)textView{
    return YES;
}

- (IBAction)addImg:(id)sender {
    if (_addImgBlock) {
        _addImgBlock(self);
    }
}


@end
