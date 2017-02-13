//
//  MyViewController.m
//  FMDBManager
//
//  Created by aDu on 2017/2/7.
//  Copyright © 2017年 DuKaiShun. All rights reserved.
//

#import "MyViewController.h"
#import "TestViewController.h"
#import "SYFMDBManager.h"
#import "MyCell.h"
#import "MyModel.h"


#define K_Cell @"cell"
@interface MyViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger number;

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"FMDB";
    self.navigationController.navigationBar.translucent = NO;
    
    [self.view addSubview:self.tableView];

//    if (![[SYFMDBManager shareManager] tableIsExist:[MyModel class]]) {
//        [[SYFMDBManager shareManager] createTable:[MyModel class]];
//    }
    
    MyModel *model = [[MyModel alloc] init];
    model.aId = [NSString stringWithFormat:@"标识:%@", @(101)];
    model.name = [NSString stringWithFormat:@"老王:%@", @(100)];
    model.age = [NSString stringWithFormat:@"年龄:%@", @(25)];
    if ([[SYFMDBManager shareManager] insertModel:model]) {
        [self.dataArray addObject:model];
    }
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"删除" style:UIBarButtonItemStyleDone target:self action:@selector(delete)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"查询" style:UIBarButtonItemStyleDone target:self action:@selector(searchData)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

//删除
- (void)delete {
    NSString *str = @"标识:101";
    if ([[SYFMDBManager shareManager] deleteModel:[MyModel class] byId:str]) {
        MyModel *my;
        for (MyModel *model in self.dataArray) {
            if ([model.aId isEqualToString:str]) {
                my = model;
            }
        }
        [self.dataArray removeObject:my];
        [self.tableView reloadData];
        NSLog(@"删除成功");
    } else {
        NSLog(@"删除失败，没有找到对应的数据");
    }
}

//增加3条
- (void)searchData {
    NSArray *array = [[SYFMDBManager shareManager] searchAllModel:[MyModel class] range:NSMakeRange(self.number, 3)];
    if (array.count != 0) {
        NSLog(@"===%d", array.count);
        [self.dataArray addObjectsFromArray:array];
    } else {
        for (int i = self.number; i < self.number + 3; i++) {
            MyModel *model = [[MyModel alloc] init];
            model.aId = [NSString stringWithFormat:@"标识:%@", @(100 + i)];
            model.name = [NSString stringWithFormat:@"老王:%@", @(i)];
            model.age = [NSString stringWithFormat:@"年龄:%@", @(10 + i)];
            if ([[SYFMDBManager shareManager] insertModel:model]) {
                [self.dataArray addObject:model];
            }
        }
        NSLog(@"---%@", @(self.dataArray.count));
    }
    [self.tableView reloadData];
    self.number = self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyCell *cell = [tableView dequeueReusableCellWithIdentifier:K_Cell forIndexPath:indexPath];
    MyModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TestViewController *testVC = [[TestViewController alloc] init];
    [self.navigationController pushViewController:testVC animated:YES];
}

#pragma mark - init

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:@"MyCell" bundle:nil] forCellReuseIdentifier:K_Cell];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _tableView.rowHeight = 70;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
