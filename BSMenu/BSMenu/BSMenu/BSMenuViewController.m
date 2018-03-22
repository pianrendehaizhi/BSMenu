//
//  BSMenuViewController.m
//  2018年03月20日
//
//  Created by BiShuai on 2018/3/22.
//  Copyright © 2018年 BiShuai. All rights reserved.
//

#import "BSMenuViewController.h"
#define kBSKeyWindow [UIApplication sharedApplication].keyWindow
#define kBSMenuRowHight 40.0
#define kBSMenuFontSize 14.0
#define kBSMenuMargin 15.0

@interface BSMenuViewController ()
<UITableViewDelegate,
UITableViewDataSource> {
    CGFloat _menuX;
    CGFloat _menuY;
    CGFloat _menuW;
    CGFloat _menuH;
}

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) CGRect tableViewFrame;

@end

@implementation BSMenuViewController

- (instancetype)initWithList:(NSArray<NSString *> *)listArray {
    if (self = [super init]) {
        self.dataArray = listArray;
        NSString *temp = @"";
        for (NSString *string in self.dataArray) {
            if (string.length > temp.length) {
                temp = string;
            }
        }
        [self getTableVeiwSizeWithString:temp];
    }
    return self;
}

- (void)presentMenuControlelrOnView:(UIView *)view {
    self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [kBSKeyWindow.rootViewController presentViewController:self animated:NO completion:nil];
    [self getTableViewOriginWithView:view];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = self.view.bounds;
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(closeMenu) forControlEvents:UIControlEventTouchUpInside];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.layer.borderWidth = 1;
    self.tableView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.tableView.bounces = NO;
    self.tableView.separatorInset = UIEdgeInsetsZero;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tableView.frame = CGRectMake(_menuX, _menuY, _menuW, _menuH);
}

- (void)getTableVeiwSizeWithString:(NSString *)str {
    UIFont *font = [UIFont systemFontOfSize:kBSMenuFontSize];
    CGFloat width = [str boundingRectWithSize:CGSizeMake(1000, kBSMenuFontSize) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size.width + 2 * kBSMenuMargin;
    _menuW = MIN(self.view.bounds.size.width, width);
    _menuH = MIN(self.dataArray.count * kBSMenuRowHight, self.view.frame.size.height / 3 * 2);
}

- (void)getTableViewOriginWithView:(UIView *)view {
    CGRect frame = [view.superview convertRect:view.frame toView:self.view];
    
    if ((frame.origin.x + frame.size.width / 2 - _menuW / 2) < 0) {
        _menuX = 0;
    } else if ((frame.origin.x + frame.size.width / 2 + _menuW / 2) > self.view.bounds.size.width) {
        _menuX = self.view.bounds.size.width - _menuW;
    } else {
        _menuX = frame.origin.x + frame.size.width / 2 - _menuW / 2;
    }
    
    if (frame.origin.y + frame.size.height + _menuH < self.view.bounds.size.height) {
        _menuY = frame.origin.y + frame.size.height;
    } else {
        _menuY = frame.origin.y - _menuH;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kBSMenuRowHight;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _menuW, kBSMenuRowHight)];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:kBSMenuFontSize];
        label.tag = 666;
        [cell.contentView addSubview:label];
    }
    UILabel *label = [cell viewWithTag:666];
    label.text = self.dataArray[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self closeMenu];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (void)closeMenu {
    [self dismissViewControllerAnimated:NO completion:^{
        NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
        if (indexPath) {
            if (self.menuSelectedCallBack) {
                self.menuSelectedCallBack(indexPath.row);
            }
            [self.delegate BSMenuViewController:self selectedIndex:indexPath.row];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
