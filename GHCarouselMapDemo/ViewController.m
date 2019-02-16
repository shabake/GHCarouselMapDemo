//
//  ViewController.m
//  GHKit
//
//  Created by zhaozhiwei on 2019/1/26.
//  Copyright © 2019年 GHome. All rights reserved.
//

#import "ViewController.h"
#import "GHCarouselMap.h"
#import "GHLoadImagesHelper.h"
#import "GHCarouselStyleFirst.h"
#import "GHCarouselStyleSecond.h"

@interface ViewController ()<GHCarouselMapDelegate,GHCarouselMapDataSource,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong) UITableView *tableView;
@property (nonatomic , strong) NSArray *images;
@property (nonatomic , strong) NSArray *imagesArray;
@property (nonatomic , strong) GHCarouselMap *carouselMap0;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11.0, *)) {
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.view = self.tableView;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [[UILabel alloc]init];
    label.textAlignment = NSTextAlignmentCenter;

    if (section == 0) {
        label.text = @"样式一";
    } else if (section == 1) {
        label.text = @"样式二";
    }
    return label;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 60;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        GHCarouselStyleFirst *cell = [tableView dequeueReusableCellWithIdentifier:@"GHCarouselStyleFirstID"];
        return cell;
    } else if (indexPath.section == 1) {
        GHCarouselStyleSecond *cell = [tableView dequeueReusableCellWithIdentifier:@"GHCarouselStyleSecondID"];
        return cell;
    } else {
        return [UITableViewCell new];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 400;
    } else if (indexPath.section == 1) {
        return 100;
    } else {
        return 0.01;
    }
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[GHCarouselStyleFirst class] forCellReuseIdentifier:@"GHCarouselStyleFirstID"];
        [_tableView registerClass:[GHCarouselStyleSecond class] forCellReuseIdentifier:@"GHCarouselStyleSecondID"];
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}
@end
