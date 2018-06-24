//
//  WZZPopViewController.m
//  弹出选择框
//
//  Created by 吴灶洲 on 2017/2/21.
//  Copyright © 2017年 吴灶洲. All rights reserved.
//

#import "WZZPopViewController.h"

@interface WZZPopViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *addArray;

@end

@implementation WZZPopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //弹出窗内容
    self.addArray = [[NSMutableArray alloc] initWithObjects:@"创建群聊",@"加好友／群", @"扫一扫",@"面对面快传", nil];
    
    [self setupView];
}
#pragma mark 创建 tableView
- (void)setupView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.scrollEnabled = NO;
    tableView.backgroundColor = [UIColor yellowColor];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    [self.tableView setSeparatorInset:UIEdgeInsetsZero ];
    //    [self.tableView setSeparatorColor:[UIColor whiteColor]];
}
#pragma mark tabelView 协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.addArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor yellowColor];
    //    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.text = self.addArray[indexPath.row];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"%zd",indexPath.row);
}
#pragma mark 重写 preferredContentSize, 返回 popover 的大小
/**
 *  此方法,会返回一个由UIKit子类调用后得到的Size ,此size即是完美适应调用此方法的UIKit子类的size
 *  得到此size后, 可以调用 调整弹框大小的方法 **preferredContentSize**配合使用
 *  重置本控制器的大小
 */
- (CGSize)preferredContentSize {
    if (self.presentingViewController && self.tableView != nil) {
        CGSize tempSize = self.presentingViewController.view.bounds.size;
        tempSize.width = 150;
        //返回一个完美适应tableView的大小的 size; sizeThatFits 返回的是最合适的尺寸, 但不会改变控件的大小
        CGSize size = [self.tableView sizeThatFits:tempSize];
        return size;
    }else{
        return [self preferredContentSize];
    }
}


@end
