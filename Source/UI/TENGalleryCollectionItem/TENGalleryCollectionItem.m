//
//  TENGalleryCollectionItem.m
//  TENGallery
//
//  Created by 444ten on 9/4/16.
//  Copyright © 2016 444ten. All rights reserved.
//

#import "TENGalleryCollectionItem.h"

@interface TENGalleryCollectionItem ()

@end

@implementation TENGalleryCollectionItem

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.itemImageView unregisterDraggedTypes];
}


@end
