//
//  DZTileTransformationHelper.m
//  DZTiles
//
//  Created by Denis Zamataev on 9/15/14.
//  Copyright (c) 2014 dzamataev. All rights reserved.
//

#import "DZTileTransformationHelper.h"

@implementation DZTileTransformationHelper
+ (void)animateRotationWithFront:(UIView*)frontView back:(UIView*)backView completion:(void (^)(BOOL finished))completionBlock {
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
@end
