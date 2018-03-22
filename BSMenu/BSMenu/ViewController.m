//
//  ViewController.m
//  BSMenu
//
//  Created by BiShuai on 2018/3/22.
//  Copyright © 2018年 BiShuai. All rights reserved.
//

#import "ViewController.h"
#import "BSMenuViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)btnAction:(UIButton *)sender {
    NSArray *array = @[@"苹果", @"香蕉", @"橘子", @"菠萝", @"苹果+香蕉+橘子+菠萝"];
    BSMenuViewController *menu = [[BSMenuViewController alloc] initWithList:array];
    [menu presentMenuControlelrOnView:sender];
    menu.menuSelectedCallBack = ^(NSUInteger selectedIndex) {
        NSLog(@"您点击了：%@", array[selectedIndex]);
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
