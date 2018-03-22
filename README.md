# BSMenu
根据控件位置弹出的选择列表

## 使用方法

```Objective-C
    NSArray *array = @[@"苹果", @"香蕉", @"橘子", @"菠萝", @"苹果+香蕉+橘子+菠萝"];
    BSMenuViewController *menu = [[BSMenuViewController alloc] initWithList:array];
    [menu presentMenuControlelrOnView:sender];
    menu.menuSelectedCallBack = ^(NSUInteger selectedIndex) {
        NSLog(@"您点击了：%@", array[selectedIndex]);
    };
```

## 预览

![BSMenu](https://raw.githubusercontent.com/pianrendehaizhi/BSMenu/master/BSMenu.gif)