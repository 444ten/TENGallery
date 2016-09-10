//
//  TENItemsModel.h
//  TENGallery
//
//  Created by 444ten on 9/4/16.
//  Copyright © 2016 444ten. All rights reserved.
//

#import "TENModel.h"

@interface TENItemsModel : TENModel
@property (nonatomic, readonly) NSInteger   count;
@property (nonatomic, assign)   NSInteger   currentItemIndex;

- (void)addItem:(NSImage *)item;
- (void)insertItem:(NSImage *)item atIndex:(NSUInteger)index;

- (NSImage *)itemForIndex:(NSInteger)index;
- (NSImage *)currentItem;
- (NSImage *)nextItem;
- (NSImage *)previousItem;

@end
