//
//  TENGalleryViewController.m
//  TENGallery
//
//  Created by 444ten on 9/4/16.
//  Copyright © 2016 444ten. All rights reserved.
//

#import "TENGalleryViewController.h"

#import "TENGalleryView.h"
#import "TENGalleryCollectionItem.h"
#import "TENItemsModel.h"
#import "TENFullViewController.h"

@interface TENGalleryViewController () <NSViewControllerPresentationAnimator,
                                        NSCollectionViewDelegate,
                                        NSCollectionViewDataSource,
                                        TENGalleryViewProtocol>

@property (nonatomic, strong)   TENItemsModel   *itemsModel;

@end

TENViewControllerBaseViewProperty(TENGalleryViewController, rootView, TENGalleryView)

@implementation TENGalleryViewController

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
        
    TENItemsModel *itemsModel = [TENItemsModel new];
    
    self.itemsModel = itemsModel;
    self.rootView.itemsModel = itemsModel;
    self.rootView.delegate = self;
}

#pragma mark -
#pragma mark Accessors

- (void)setItemsModel:(TENItemsModel *)itemsModel {
    TENObserverSetter(itemsModel)
}

#pragma mark -
#pragma mark NSCollectionViewDataSource

- (NSInteger)collectionView:(NSCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.itemsModel.count;
}

- (NSCollectionViewItem *)collectionView:(NSCollectionView *)collectionView
     itemForRepresentedObjectAtIndexPath:(NSIndexPath *)indexPath
{
    TENGalleryCollectionItem *item = [collectionView makeItemWithIdentifier:@"TENGalleryCollectionItem"
                                                               forIndexPath:indexPath];
    item.itemImageView.image = [self.itemsModel itemForIndex:indexPath.item];
    
    return item;
}

#pragma mark -
#pragma mark TENGalleryViewProtocol

- (void)doubleClickActionForIndexPath:(NSIndexPath *)indexPath {
    TENItemsModel *itemsModel = self.itemsModel;
    itemsModel.currentItemIndex = indexPath.item;
    
    NSStoryboard* storyboard = [NSStoryboard storyboardWithName:@"Main" bundle:nil];
    TENFullViewController *fullController = [storyboard instantiateControllerWithIdentifier:@"TENFullViewController"];
    fullController.itemsModel = itemsModel;
    
    [self presentViewController:fullController animator:self];
}


#pragma mark -
#pragma mark Accessors TENModelObserver

- (void)modelDidLoad:(id)model {
    if (model == self.itemsModel) {
        [self.rootView.galleryCollectionView reloadData];
    }
}

#pragma mark -
#pragma mark NSViewControllerPresentationAnimator

- (void)animatePresentationOfViewController:(NSViewController *)viewController
                         fromViewController:(NSViewController *)fromViewController
{
    NSView *topView = viewController.view;
    topView.wantsLayer = YES;
    topView.layerContentsRedrawPolicy = NSViewLayerContentsRedrawOnSetNeedsDisplay;
    topView.alphaValue = 0;
    topView.frame = fromViewController.view.frame;
    
    [fromViewController.view addSubview:topView];
    
    [fromViewController.view.window makeFirstResponder:topView];
    
    [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
        context.duration = 0.5;
        topView.animator.alphaValue = 1;
    }
                        completionHandler:nil];
}

- (void)animateDismissalOfViewController:(NSViewController *)viewController
                      fromViewController:(NSViewController *)fromViewController
{
    [viewController.view removeFromSuperview];
}

@end
