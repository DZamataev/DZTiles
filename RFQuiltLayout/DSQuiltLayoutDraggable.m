//
//  DSQuiltLayoutDraggable.m
//  QuiltDemo
//
//  Created by Alexander Belyavskiy on 7/8/14.
//

#import "DSQuiltLayoutDraggable.h"
#import "LSCollectionViewLayoutHelper.h"

@implementation DSQuiltLayoutDraggable {
  LSCollectionViewLayoutHelper *_layoutHelper;
}

- (LSCollectionViewLayoutHelper *)layoutHelper
{
  if(_layoutHelper == nil) {
    _layoutHelper = [[LSCollectionViewLayoutHelper alloc] initWithCollectionViewLayout:self];
  }
  return _layoutHelper;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
  return [self.layoutHelper modifiedLayoutAttributesForElements:[super layoutAttributesForElementsInRect:rect]];
}

@end
