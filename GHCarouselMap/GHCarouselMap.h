//
//  GHCarouselMap.h
//  GHKit
//
//  Created by zhaozhiwei on 2019/2/6.
//  Copyright © 2019年 GHome. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/** 滚动方向枚举 */
typedef NS_ENUM (NSUInteger,GHCarouselMapScrollDirection) {
    GHCarouselMapScrollDirectionHorizontal = 0,/** 横向 默认 */
    GHCarouselMapScrollDirectionVertical/** 纵向 */
};

@class GHCarouselMap;
@protocol GHCarouselMapDataSource <NSObject>
@required
/**
 设置轮播图个数

 @param carouselMap carouselMap
 @return 轮播图个数
 */
- (NSInteger)countOfCellForCarouselMap:(GHCarouselMap *)carouselMap;

- (UIView *)carouselMap:(GHCarouselMap *)carouselMap cellAtIndex:(NSInteger)index;

@end
@protocol GHCarouselMapDelegate <NSObject>

- (void)carouselMap: (GHCarouselMap *) carouselMap didSelectRowAtIndex:(NSInteger)index;
@end

@interface GHCarouselMap : UIView

@property (nonatomic , weak) id <GHCarouselMapDataSource> dataSource;
@property (nonatomic , weak) id <GHCarouselMapDelegate> dalegate;
/** 滚动方向 */
@property (nonatomic , assign) GHCarouselMapScrollDirection scrollDirection;
/** 滚动建个 */
@property (nonatomic , assign) NSTimeInterval timeInterval;

- (void)reloadData;
@end

NS_ASSUME_NONNULL_END
