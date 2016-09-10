//
//  TENGalleryView.h
//  TENGallery
//
//  Created by 444ten on 9/4/16.
//  Copyright © 2016 444ten. All rights reserved.
//

#import "TENView.h"

@class TENItemsModel;

@protocol TENGalleryViewProtocol <NSObject>

- (void)doubleClickActionForIndexPath:(NSIndexPath *)indexPath;

@end

@interface TENGalleryView : TENView
@property (strong) IBOutlet NSCollectionView *galleryCollectionView;

@property (nonatomic, strong)   TENItemsModel               *itemsModel;
@property (nonatomic, weak)     id<TENGalleryViewProtocol>  delegate;

@end
