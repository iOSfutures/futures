//
//  MXZAnswerVC.m
//  futures
//
//  Created by Francis on 2020/5/22.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "MXZAnswerVC.h"
#import "MXZAnswerCell.h"

@interface MXZAnswerVC ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MXZAnswerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"MXZAnswerCell" bundle:nil] forCellReuseIdentifier:@"MXZAnswerCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"MXZAnswerCell";
    MXZAnswerCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil){
        cell = [[NSBundle mainBundle]loadNibNamed:@"MXZAnswerCell" owner:self options:nil].firstObject;
    }
    return cell;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
}


- (void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
}

@end
