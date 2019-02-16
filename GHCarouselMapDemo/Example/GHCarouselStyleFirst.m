//
//  GHCarouselStyleFirst.m
//  GHCarouselMapDemo
//
//  Created by zhaozhiwei on 2019/2/16.
//  Copyright © 2019年 GHome. All rights reserved.
//

#import "GHCarouselStyleFirst.h"
#import "GHCarouselMap.h"
#import "GHLoadImagesHelper.h"

@interface GHCarouselStyleFirst()<GHCarouselMapDataSource>
@property (nonatomic , strong) GHCarouselMap *carouselMap;
@property (nonatomic , strong) NSArray *images;
@property (nonatomic , strong) NSArray *imagesArray;
@end
@implementation GHCarouselStyleFirst

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.images = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1549621373192&di=e291e4c71c2cc34fc165dafb48db20a8&imgtype=0&src=http%3A%2F%2Fimg0.ph.126.net%2FtvpBly3va7alxcVrVh29Bg%3D%3D%2F6631447097213070177.jpg",
                        @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1549621373192&di=861cce907a3e42a258efa544328ce61f&imgtype=0&src=http%3A%2F%2Fpic.rmb.bdstatic.com%2F3355f30ddd96c669bc481818e9de4b59.jpeg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1549621373192&di=9d3636bb9c72f5a592bc0bced1793258&imgtype=0&src=http%3A%2F%2Fp0.ifengimg.com%2Fpmop%2F2018%2F1105%2F915E16EFDA9722408C74080605A41985CEF19FED_size4183_w2688_h4032.jpeg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1549621373192&di=9f18bb398181bc1d537e46703a27cb1a&imgtype=0&src=http%3A%2F%2Fdingyue.nosdn.127.net%2FdOQah9WP3IDJbRcWxG9mEOFcbuA2ZXwa7j7n4lojUJqbd1535169668843compressflag.jpg"];
    
        [[GHLoadImagesHelper  sharedManager] loadImagesWithArray:self.images actionBlock:^(NSArray * _Nonnull imagesArray) {
            self.imagesArray = imagesArray;
            [self.carouselMap reloadData];
        }];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [self addSubview:self.carouselMap];
    self.carouselMap.frame = self.bounds;
}

- (NSInteger)countOfCellForCarouselMap:(GHCarouselMap *)carouselMap {
    return 4;
}

- (UIView *)carouselMap:(GHCarouselMap *)carouselMap cellAtIndex:(NSInteger)index {
    
    UIImageView *imageView = [[UIImageView alloc]init];
    if (self.imagesArray.count > index) {
        imageView.image = self.imagesArray[index];
    } else {
        return nil;
    }
    return imageView;
    
}

- (GHCarouselMap *)carouselMap {
    if (_carouselMap == nil) {
        _carouselMap = [[GHCarouselMap alloc]init];
        _carouselMap.dataSource = self;
        _carouselMap.scrollDirection = GHCarouselMapScrollDirectionHorizontal;
    }
    return _carouselMap;
}
@end
