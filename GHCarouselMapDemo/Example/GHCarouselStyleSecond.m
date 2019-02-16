//
//  GHCarouselStyleSecond.m
//  GHCarouselMapDemo
//
//  Created by zhaozhiwei on 2019/2/16.
//  Copyright © 2019年 GHome. All rights reserved.
//

#import "GHCarouselStyleSecond.h"
#import "GHCarouselMap.h"

@interface GHCarouselStyleSecond()<GHCarouselMapDataSource>
@property (nonatomic , strong) GHCarouselMap *carouselMap;

@end

@implementation GHCarouselStyleSecond

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    for (UIView *view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    [self.contentView addSubview:self.carouselMap];
    self.carouselMap.frame = CGRectMake(10, 10, self.bounds.size.width - 20, self.bounds.size.height - 20);
}

- (NSInteger)countOfCellForCarouselMap:(GHCarouselMap *)carouselMap {
    return 4;
}

- (UIView *)carouselMap:(GHCarouselMap *)carouselMap cellAtIndex:(NSInteger)index {
    
    UIView *view = [[UIView alloc]init];    
    view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 200, 40)];
    [view addSubview: label];
    label.textColor = [UIColor darkGrayColor];
    label.text = [NSString stringWithFormat:@" ★ 第%ld张图片我是标题啊",(long)index];
    
    UILabel *details = [[UILabel alloc]initWithFrame:CGRectMake(20, 40, 200, 40)];
    [view addSubview: details];
    details.text = @"我是详情";
    
    details.textColor = [UIColor orangeColor];
    
    UIButton *button = [[UIButton alloc]init];
    button.backgroundColor = [UIColor orangeColor];
    [button setTitle:@"预定" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 5;
    
    button.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 60 -30, (80 - 21 ) *0.5, 60, 21);
    [view addSubview: button];
    
    return view;

}


- (GHCarouselMap *)carouselMap {
    if (_carouselMap == nil) {
        _carouselMap = [[GHCarouselMap alloc]init];
        _carouselMap.dataSource = self;
        _carouselMap.scrollDirection = GHCarouselMapScrollDirectionVertical;
        _carouselMap.layer.masksToBounds = YES;
        _carouselMap.layer.cornerRadius = 10;
    }
    return _carouselMap;
}

@end
