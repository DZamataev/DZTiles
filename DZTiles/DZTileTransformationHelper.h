//
//  DZTileTransformationHelper.h
//  DZTiles
//
//  Created by Denis Zamataev on 9/15/14.
//  Copyright (c) 2014 dzamataev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DZTileTransformationHelper : NSObject

+ (void)animateRotationWithFront:(UIView*)frontView back:(UIView*)backView completion:(void (^)(BOOL finished))completionBlock;

@end
