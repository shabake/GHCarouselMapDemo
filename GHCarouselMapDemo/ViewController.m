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

@interface ViewController ()<GHCarouselMapDelegate,GHCarouselMapDataSource>
@property (nonatomic , strong) NSArray *images;
@property (nonatomic , strong) NSArray *imagesArray;
@property (nonatomic , strong) GHCarouselMap *carouselMap0;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.images = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1549621373192&di=e291e4c71c2cc34fc165dafb48db20a8&imgtype=0&src=http%3A%2F%2Fimg0.ph.126.net%2FtvpBly3va7alxcVrVh29Bg%3D%3D%2F6631447097213070177.jpg",
                    @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1549621373192&di=861cce907a3e42a258efa544328ce61f&imgtype=0&src=http%3A%2F%2Fpic.rmb.bdstatic.com%2F3355f30ddd96c669bc481818e9de4b59.jpeg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1549621373192&di=9d3636bb9c72f5a592bc0bced1793258&imgtype=0&src=http%3A%2F%2Fp0.ifengimg.com%2Fpmop%2F2018%2F1105%2F915E16EFDA9722408C74080605A41985CEF19FED_size4183_w2688_h4032.jpeg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1549621373192&di=9f18bb398181bc1d537e46703a27cb1a&imgtype=0&src=http%3A%2F%2Fdingyue.nosdn.127.net%2FdOQah9WP3IDJbRcWxG9mEOFcbuA2ZXwa7j7n4lojUJqbd1535169668843compressflag.jpg"];
    
    [[GHLoadImagesHelper  sharedManager] loadImagesWithArray:self.images actionBlock:^(NSArray * _Nonnull imagesArray) {
        self.imagesArray = imagesArray;
        [self.carouselMap0 reloadData];
    }];
    
    GHCarouselMap *carouselMap = [[GHCarouselMap alloc]initWithFrame:CGRectMake(10, 88, [UIScreen mainScreen].bounds.size.width - 20, 80)];
    carouselMap.layer.masksToBounds = YES;
    carouselMap.layer.cornerRadius = 10;
    carouselMap.scrollDirection = GHCarouselMapScrollDirectionVertical;
    carouselMap.dataSource = self;
    carouselMap.dalegate = self;
    carouselMap.tag = 0;
    [self.view addSubview:carouselMap];
    
    GHCarouselMap *carouselMap0 = [[GHCarouselMap alloc]initWithFrame:CGRectMake(0, 200, [UIScreen mainScreen].bounds.size.width, 400)];
    carouselMap0.scrollDirection = GHCarouselMapScrollDirectionHorizontal;
    carouselMap0.dataSource = self;
    carouselMap0.dalegate = self;
    carouselMap0.tag = 1;
    self.carouselMap0 = carouselMap0;
    [self.view addSubview:carouselMap0];
}

- (NSInteger)countOfCellForCarouselMap:(GHCarouselMap *)carouselMap {
    return 4;
}

- (UIView *)carouselMap:(GHCarouselMap *)carouselMap cellAtIndex:(NSInteger)index {
    
    if (carouselMap.tag == 0) {
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
        return view;
    } else {
        UIImageView *imageView = [[UIImageView alloc]init];
        if (self.imagesArray.count > index) {
            imageView.image = self.imagesArray[index];
        } else {
            return nil;
        }
        return imageView;
    }
}

- (void)carouselMap: (GHCarouselMap *) carouselMap didSelectRowAtIndex:(NSInteger)index {
    NSLog(@"被点击");
}

@end
