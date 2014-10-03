//
//  DZTileTransformationHelper.m
//  DZTiles
//
//  Created by Denis Zamataev on 9/15/14.
//  Copyright (c) 2014 dzamataev. All rights reserved.
//

#import "DZTileTransformationHelper.h"

@implementation DZTileTransformationHelper

+ (void)animateTransformationWithFront:(UIView*)frontView
                                  back:(UIView*)backView
                    transformationType:(DZTileTransformationType)transformationType
                            completion:(void (^)(BOOL finished))completionBlock
{
    switch (transformationType) {
        case DZTileTransformationTypeRotation:
        {
            [DZTileTransformationHelper animateRotationWithFront:frontView back:backView completion:completionBlock];
        }
        break;
        
        
        case DZTileTransformationTypeFall:
        {
            [DZTileTransformationHelper animateFallWithFront:frontView back:backView completion:completionBlock];
        }
        break;
        
        case DZTileTransformationTypeInstant:
        {
            [DZTileTransformationHelper animateInstantWithFront:frontView back:backView completion:completionBlock];
        }
        break;
        
        default:
        break;
    }
}

+ (void)animateRotationWithFront:(UIView*)frontView
                            back:(UIView*)backView
                      completion:(void (^)(BOOL finished))completionBlock
{
    frontView.hidden = NO;
    backView.hidden = YES;
    
    CATransform3D frontABitRotatedTransform = CATransform3DIdentity;
    frontABitRotatedTransform.m34 = 1.0 / -500;
    frontABitRotatedTransform = CATransform3DRotate(frontABitRotatedTransform, 20.0f * M_PI / 180.0f, 1, 0, 0.0f);
    
    CATransform3D frontRotatedTransform = CATransform3DIdentity;
    frontRotatedTransform.m34 = 1.0 / -500;
    frontRotatedTransform = CATransform3DRotate(frontRotatedTransform, -90.0f * M_PI / 180.0f, 1, 0, 0.0f);
    
    CATransform3D backRotatedTransform = CATransform3DIdentity;
    backRotatedTransform.m34 = 1.0 / -500;
    backRotatedTransform = CATransform3DRotate(backRotatedTransform, 90.0f * M_PI / 180.0f, 1, 0, 0.0f);
    
    [UIView animateWithDuration:0.3f animations:^{
        // step one, rotate front a bit backwards
        frontView.hidden = NO;
        backView.hidden = YES;
        frontView.layer.transform = frontABitRotatedTransform;
    } completion:^(BOOL finished) {
        if (!finished) {
            completionBlock(NO);
            return;
        }
        
        [UIView animateWithDuration:0.4f animations:^{
            // step two, rotate front to ninety
            frontView.layer.transform = frontRotatedTransform;
        } completion:^(BOOL finished) {
            
            if (!finished) {
                completionBlock(NO);
                return;
            }
            
            frontView.hidden = YES;
            frontView.layer.transform = CATransform3DIdentity;
            backView.hidden = NO;
            backView.layer.transform = backRotatedTransform;
            
            [UIView animateWithDuration:0.35f animations:^{
                // step three, rotate back to become visible
                backView.layer.transform = CATransform3DIdentity;
            } completion:^(BOOL finished) {
                if (!finished) {
                    completionBlock(NO);
                    return;
                }
                completionBlock(YES);
            }];
        }];
    }];
}

+ (void)animateFallWithFront:(UIView*)frontView
                        back:(UIView*)backView
                  completion:(void (^)(BOOL finished))completionBlock
{
    frontView.hidden = NO;
    backView.hidden = NO;
    
    frontView.layer.anchorPoint = CGPointMake(0.5, -0.5);
    backView.layer.anchorPoint = CGPointMake(0.5, 0.5);
    
    [CATransaction begin];
    
    
    [CATransaction setAnimationDuration:1.0];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    [CATransaction setCompletionBlock:^{
        frontView.hidden = YES;
        backView.hidden = NO;
        frontView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        backView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        completionBlock(YES);
    }];
    
    // Animate the anchor point
    CABasicAnimation *fronAnimation = [CABasicAnimation animationWithKeyPath:@"anchorPoint"];
    fronAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(0.5f, 0.5f)];
    fronAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(0.5, -0.5)];
    [frontView.layer addAnimation:fronAnimation forKey:@"anchorPoint"];
    // end
    
    // Animate the anchor point
    CABasicAnimation *backAnimation = [CABasicAnimation animationWithKeyPath:@"anchorPoint"];
    backAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(0.5f, 1.5f)];
    backAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(0.5, 0.5)];
    [backView.layer addAnimation:backAnimation forKey:@"anchorPoint"];
    // end
    [CATransaction commit];
}

+ (void)animateInstantWithFront:(UIView*)frontView
                           back:(UIView*)backView
                     completion:(void (^)(BOOL finished))completionBlock
{
    frontView.hidden = YES;
    frontView.layer.transform = CATransform3DIdentity;
    backView.hidden = NO;
    backView.layer.transform = CATransform3DIdentity;
    completionBlock(YES);
}
@end
