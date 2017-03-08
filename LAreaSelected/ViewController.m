//
//  ViewController.m
//  LAreaSelected
//
//  Created by 俊杰  廖 on 2017/3/7.
//  Copyright © 2017年 俊杰  廖. All rights reserved.
//

#import "ViewController.h"
#import "LAreaSelectedViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)ss:(id)sender {
    NSString *dataPath = [[NSBundle mainBundle] pathForResource:@"AreaData" ofType:@"plist"];
    NSDictionary *data = [[NSDictionary alloc] initWithContentsOfFile:dataPath];
    LAreaSelectedViewController *vc = [[LAreaSelectedViewController alloc] initSelectedViewControllerWithDatas:data];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
