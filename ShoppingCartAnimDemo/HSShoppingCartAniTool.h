//
//  HSShoppingCartAniTool.h
//  PruchaseCarAnimation
//
//  Created by caozhen@neusoft on 16/8/25.
//  Copyright © 2016年 Neusoft. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HSShopFinishBlock)(BOOL finish);

@interface HSShoppingCartAniTool : NSObject



@property (nonatomic,copy) HSShopFinishBlock shopFinish;

@property (nonatomic,assign) CGPoint finishPoint;


+ (instancetype)shareInstance;

- (void)startAniView:(UIView *)view
                rect:(CGRect)rect
         finishBlock:(HSShopFinishBlock)completion;

+ (void)addShakeAni:(UIView *)view;

@end


#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height