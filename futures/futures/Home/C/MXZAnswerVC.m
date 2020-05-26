//
//  MXZAnswerVC.m
//  futures
//
//  Created by Francis on 2020/5/22.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "MXZAnswerVC.h"
#import "MXZAnswerCell.h"
#import "UIImage+OriginalImage.h"

@interface MXZAnswerVC ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MXZAnswerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"答题中心";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.tableView registerNib:[UINib nibWithNibName:@"MXZAnswerCell" bundle:nil] forCellReuseIdentifier:@"MXZAnswerCell"];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage originalImageWithName:@"ic_back_black"] style:UIBarButtonItemStyleDone target:self action:@selector(backPreView)];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
}


- (void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
}

-(void)backPreView{
    [self.navigationController popViewControllerAnimated:YES];
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



@end
