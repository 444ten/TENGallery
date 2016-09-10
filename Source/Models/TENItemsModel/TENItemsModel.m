//
//  TENItemsModel.m
//  TENGallery
//
//  Created by 444ten on 9/4/16.
//  Copyright © 2016 444ten. All rights reserved.
//

#import "TENItemsModel.h"

@interface TENItemsModel ()
@property (nonatomic, strong)   NSMutableArray  *items;

@end

@implementation TENItemsModel

@dynamic count;

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
    self = [super init];
    if (self) {
        self.items = [NSMutableArray new];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSInteger)count {
    return self.items.count;
}

#pragma mark -
#pragma mark Public Methods

- (void)insertItem:(NSImage *)item atIndex:(NSUInteger)index {
    NSMutableArray *items = self.items;
    if (item && index <= items.count) {
        [items insertObject:item atIndex:index];
        self.state = TENModelLoaded;
    }
}

- (void)addItem:(NSImage *)item {
    [self insertItem:item atIndex:self.items.count];
}

- (NSImage *)itemForIndex:(NSInteger)index {
    if (index >= 0 && index < self.count) {
        self.currentItemIndex = index;
        
        return self.items[index];
    }
    
    return nil;
}

- (NSImage *)currentItem; {
    return [self itemForIndex:self.currentItemIndex];
}

- (NSImage *)nextItem {
    return [self itemForIndex:self.currentItemIndex + 1];
}

- (NSImage *)previousItem {
    return [self itemForIndex:self.currentItemIndex - 1];
}

@end
