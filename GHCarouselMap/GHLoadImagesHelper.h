//
//  GHLoadImagesHelper.h
//  GHKit
//
//  Created by zhaozhiwei on 2019/2/6.
//  Copyright © 2019年 GHome. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^GHLoadImagesHelperBlock)(NSArray *imagesArray);
@interface GHLoadImagesHelper : NSObject

@property (nonatomic , copy) GHLoadImagesHelperBlock actionBlock;
+ (instancetype)sharedManager;

- (void)loadImagesWithArray: (NSArray *)array actionBlock: (GHLoadImagesHelperBlock)actionBlock;
@end

NS_ASSUME_NONNULL_END
