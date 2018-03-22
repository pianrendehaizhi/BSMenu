//
//  BSMenuViewController.h
//  2018年03月20日
//
//  Created by BiShuai on 2018/3/22.
//  Copyright © 2018年 BiShuai. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BSMenuViewController;

@protocol BSMenuViewControllerDelegate <NSObject>

- (void)BSMenuViewController:(BSMenuViewController *)menu selectedIndex:(NSUInteger)selectedIndex;

@end;

@interface BSMenuViewController : UIViewController

- (instancetype)initWithList:(NSArray<NSString *> *)listArray;
- (void)presentMenuControlelrOnView:(UIView *)view;
- (void)closeMenu;

@property (nonatomic, assign, readonly) NSUInteger selectedIndex;
@property (nonatomic, copy) void(^menuSelectedCallBack)(NSUInteger selectedIndex);
@property (nonatomic, weak) id <BSMenuViewControllerDelegate> delegate;

@end
