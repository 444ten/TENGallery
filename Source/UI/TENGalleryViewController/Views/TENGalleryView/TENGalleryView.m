//
//  TENGalleryView.m
//  TENGallery
//
//  Created by 444ten on 9/4/16.
//  Copyright © 2016 444ten. All rights reserved.
//

#import "TENGalleryView.h"

#import "TENItemsModel.h"

@interface TENGalleryView ()
@property (nonatomic, strong)   NSImage     *draggedItem;

@end

@implementation TENGalleryView

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self registerForDraggedTypes:@[NSFilenamesPboardType]];
    }
    
    return self;
}

- (instancetype)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self registerForDraggedTypes:@[NSFilenamesPboardType]];        
    }
    
    return self;
}

#pragma mark -
#pragma mark Overriden Methods

- (void)mouseUp:(NSEvent *)theEvent {
    if ([theEvent clickCount] >= 2) {
        NSCollectionView *galleryCollectionView = self.galleryCollectionView;
        NSPoint clickPoint = [galleryCollectionView convertPoint:[theEvent locationInWindow] fromView:nil];
        NSIndexPath *indexPath = [galleryCollectionView indexPathForItemAtPoint:clickPoint];
        
        id delegate = self.delegate;
        if (indexPath && [delegate respondsToSelector:@selector(doubleClickActionForIndexPath:)]) {
            [delegate doubleClickActionForIndexPath:indexPath];
        }
    }
}

#pragma mark -
#pragma mark NSDraggingDestination

- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender {
    NSPasteboard *pasteboard = [sender draggingPasteboard];
    NSString *path = [pasteboard propertyListForType:NSFilenamesPboardType][0];
    NSImage *image = [[NSImage alloc] initWithContentsOfFile:path];
    
    if (image) {
        self.draggedItem = image;
        
        return NSDragOperationCopy;
    }
    
    return NSDragOperationNone;
}


- (void)draggingExited:(nullable id <NSDraggingInfo>)sender {
    self.draggedItem = nil;
}

- (BOOL)performDragOperation:(id<NSDraggingInfo>)sender {
    [self.itemsModel addItem:self.draggedItem];
    
    return YES;
}

@end
