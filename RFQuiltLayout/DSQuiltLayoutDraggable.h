//
//  DSQuiltLayoutDraggable.h
//  QuiltDemo
//
//  Created by Alexander Belyavskiy on 7/8/14.
//

#import "RFQuiltLayout.h"
#import "UICollectionViewLayout_Warpable.h"

@interface DSQuiltLayoutDraggable : RFQuiltLayout<UICollectionViewLayout_Warpable>
@property (readonly, nonatomic) LSCollectionViewLayoutHelper *layoutHelper;
@end
