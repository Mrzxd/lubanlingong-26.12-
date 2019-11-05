//
//  PublishController.m
//  鲁班零工
//
//  Created by 张昊 on 2019/10/12.
//  Copyright © 2019 张兴栋. All rights reserved.
//

#import "PublishController.h"


@interface PublishController ()

@end

@implementation PublishController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self setUpNav];
}

- (void)setUpNav
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"header_back_icon"] style:UIBarButtonItemStyleDone target:self action:@selector(pop)];
    self.navigationItem.leftBarButtonItem = backItem;
}

- (void)pop
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end


