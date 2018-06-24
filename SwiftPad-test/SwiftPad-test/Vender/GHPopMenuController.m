//
//  GHPopMenuController.m
//  弹出选择框
//
//  Created by jinjin on 2018/6/23.
//  Copyright © 2018年 吴灶洲. All rights reserved.
//

#import "GHPopMenuController.h"
#import "CollectionViewCell.h"

@interface GHPopMenuController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *addArray;
@end

@implementation GHPopMenuController

- (void)viewDidLoad {
    [super viewDidLoad];
    //弹出窗内容
    self.addArray = [[NSMutableArray alloc] initWithObjects:@"群聊",@"好友", @"扫扫",@"快传", nil];
    
    [self setupView];
}

#pragma mark 创建 tableView
- (void)setupView {
    UICollectionViewFlowLayout * flow = [[UICollectionViewFlowLayout alloc] init];
    flow.itemSize = CGSizeMake(50, 30);
    flow.minimumInteritemSpacing = 0;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:flow];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.scrollEnabled = NO;
    collectionView.backgroundColor = [UIColor yellowColor];
    [collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"CELL"];
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
//    [self.tableView setSeparatorInset:UIEdgeInsetsZero ];
    //    [self.tableView setSeparatorColor:[UIColor whiteColor]];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.addArray.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionViewCell * cell = (CollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    cell.label.text = _addArray[indexPath.row];
    return cell;
}
#pragma mark 重写 preferredContentSize, 返回 popover 的大小
/**
 *  此方法,会返回一个由UIKit子类调用后得到的Size ,此size即是完美适应调用此方法的UIKit子类的size
 *  得到此size后, 可以调用 调整弹框大小的方法 **preferredContentSize**配合使用
 *  重置本控制器的大小
 */
- (CGSize)preferredContentSize {
    if (self.presentingViewController && _collectionView != nil) {
//        CGSize tempSize = self.presentingViewController.view.bounds.size;
//        tempSize.width = 150;
//        //返回一个完美适应tableView的大小的 size; sizeThatFits 返回的是最合适的尺寸, 但不会改变控件的大小
//        CGSize size = [_collectionView sizeThatFits:tempSize];
        CGSize size = CGSizeMake(50*4, 30);
        return size;
    }else{
        return [self preferredContentSize];
    }
}

@end
