//
//  TestViewController.m
//  FMDBManager
//
//  Created by aDu on 2017/2/8.
//  Copyright © 2017年 DuKaiShun. All rights reserved.
//

#import "TestViewController.h"
#import "SYFMDBManager.h"
#import "TestModel.h"

@interface TestViewController ()

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"测试";
    self.view.backgroundColor = [UIColor whiteColor];
}

//增
- (IBAction)add:(id)sender {
    TestModel *model = [[TestModel alloc] init];
    model.FLDBID = @"123";
    if ([[SYFMDBManager shareManager] insertModel:model]) {
        NSLog(@"增加成功");
        [self.dataArray addObject:model];
    } else {
        NSLog(@"增加失败");
    }
}

//删
- (IBAction)delete:(id)sender {
    //删除数据库所有数据
    if ([[SYFMDBManager shareManager] deleteDataBase]) {
        NSLog(@"删除成功");
    } else {
        NSLog(@"删除失败");
    }
    
    //删除所有数据
//    if ([[SYFMDBManager shareManager] deleteAllModel:[TestModel class]]) {
//        NSLog(@"删除成功%@", self.dataArray);
//    } else {
//        NSLog(@"删除失败%@", self.dataArray);
//    }
    
    //删除单条数据
//    if ([[SYFMDBManager shareManager] deleteModel:[TestModel class] byId:@"123"]) {
//        NSLog(@"删除成功%@", self.dataArray);
//    } else {
//        NSLog(@"删除失败%@", self.dataArray);
//    }
}

//查
- (IBAction)search:(id)sender {
    if ([[SYFMDBManager shareManager] searchModel:[TestModel class] byId:@"123"]) {
        NSLog(@"存在");
    } else {
        NSLog(@"不存在");
    }
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
