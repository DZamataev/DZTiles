//
//  DZTileTransformationHelper.h
//  DZTiles
//
//  Created by Denis Zamataev on 9/15/14.
//  Copyright (c) 2014 dzamataev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DZTiles_Constants.h"

@interface DZTileTransformationHelper : NSObject

+ (void)animateTransformationWithFront:(UIView*)frontView
                                  back:(UIView*)backView
                    transformationType:(DZTileTransformationType)transformationType
                            completion:(void (^)(BOOL finished))completionBlock;

@end
