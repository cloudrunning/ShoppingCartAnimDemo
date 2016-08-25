//
//  HSShoppingCartAniTool.m
//  PruchaseCarAnimation
//
//  Created by caozhen@neusoft on 16/8/25.
//  Copyright © 2016年 Neusoft. All rights reserved.
//

#import "HSShoppingCartAniTool.h"
#import "AppDelegate.h"

@interface HSShoppingCartAniTool ()

@property (nonatomic,strong) NSMutableArray *tempLayers;

@end

@implementation HSShoppingCartAniTool

+ (instancetype)shareInstance {
    
    static HSShoppingCartAniTool *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[HSShoppingCartAniTool alloc]init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.tempLayers = [NSMutableArray array];
    }
    return self;
}

- (void)startAniView:(UIView *)view
                rect:(CGRect)rect
         finishBlock:(HSShopFinishBlock)completion {
    
    // 拷贝 view的layer
    CALayer *layer = [CALayer layer];
    rect.size.width = 60;
    rect.size.width = 60;
    layer.bounds = rect;
    layer.contents = view.layer.contents;
    layer.contentsGravity = kCAGravityResizeAspectFill;
    layer.cornerRadius = rect.size.width * 0.5;
    layer.masksToBounds = YES;
    layer.position = CGPointMake(rect.origin.x + view.frame.size.width * 0.5, CGRectGetMinY(rect));
    
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate.window.layer addSublayer:layer];
    
    // path
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:layer.position];
    CGPoint controlPoint = CGPointMake(kScreenWidth * 0.5, rect.origin.y -80);
    [path addQuadCurveToPoint:self.finishPoint controlPoint:controlPoint];
    
    //keyframe ani
    CAKeyframeAnimation *keyAni = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    keyAni.path = path.CGPath;
    
    //rotation ani
    CABasicAnimation *rotationAni = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotationAni.removedOnCompletion = YES;
    rotationAni.fromValue = [NSNumber numberWithFloat:.0f];
    rotationAni.toValue = [NSNumber numberWithFloat:12.0f];
    rotationAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    
    // group ani
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[keyAni,rotationAni];
    group.duration = 1.2;
    group.delegate = self;
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    
    [layer addAnimation:group forKey:@"group"];
    if (completion) {
        self.shopFinish = [completion copy];
    }
    [self.tempLayers addObject:layer];
 
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (self.tempLayers.count > 0) {
        CALayer *layer = self.tempLayers.firstObject;
        [layer removeFromSuperlayer];
        if (self.shopFinish) {
            self.shopFinish(YES);
        }
        [self.tempLayers removeObject:layer];
    }
}

+ (void)addShakeAni:(UIView *)view {
    
    CABasicAnimation *shakeAni = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    shakeAni.duration = .25f;
    shakeAni.fromValue = [NSNumber numberWithFloat:-5];
    shakeAni.toValue = [NSNumber numberWithFloat:5];
    shakeAni.autoreverses = YES;
    [view.layer addAnimation:shakeAni forKey:nil];
}
@end
