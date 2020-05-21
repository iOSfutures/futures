//
//  MXZFullSecondSectionCell.m
//  futures
//
//  Created by Francis on 2020/5/20.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "MXZFullSecondSectionCell.h"

@implementation MXZFullSecondSectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    NSString *str1 = @"我们目前的股票市场，是一个单边市场。\n";

    NSString *str2 = @"股市涨的时候大家都赚钱，跌的时候大家都无可奈何地赔钱。股票指数期货的出现使股市成为双边市场。无论股市上升或下跌，只要预测准确，就能赚钱。\n";
    NSString *str3 = @"因此，股指期货如何操作?\n";
    NSString *str4 = @"对个人而言，股票指数期货市场将是一个大有可为的市场。\n";
    self.firstLabel.text = [NSString stringWithFormat:@"%@\n%@\n%@\n%@", str1,str2,str3,str4];
    str1 = @"第一、当个人投资者预测股市将上升时，可买入股票现货增加持仓，也可以买入股票指数期货合约。这两种方式在预测准确时都可盈利。相比之下，买卖股票指数期货的交易手续费比较便宜。\n";

    str2 = @"第二、当个人投资者预测股市将下跌时，可卖出已有的股票现货，也可卖出股指期货合约。卖出现货是将以前的账面盈利变成实际盈利，是平仓行为，当股市真的下跌时，不再能盈利。而卖出股指期货合约，是从对将来的正确预测中获利，是开仓行为。由于有了卖空机制，当股市下跌时，即使手中没有股票，也能通过卖出股指期货合约获得盈利。\n";

    str3 = @"第三、对持有股票的长期投资者，或者出于某种原因不能抛出股票的投资锁定利润、转移风险。\n";
                            
    self.secondLabel.text = [NSString stringWithFormat:@"%@\n%@\n%@",str1,str2,str3];
    
    self.thirdLabel.text = @"买卖股票指数期货相当于证券指数化，与大市同步；另外，买卖股票指数期货还分散了个股风险，真正做到不把鸡蛋放在一个篮子里。";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
