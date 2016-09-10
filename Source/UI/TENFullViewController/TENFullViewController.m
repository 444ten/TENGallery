//
//  TENFullViewController.m
//  TENGallery
//
//  Created by 444ten on 9/4/16.
//  Copyright © 2016 444ten. All rights reserved.
//

#import "TENFullViewController.h"

#import "TENFullView.h"
#import "TENItemsModel.h"
#import "NSImage+GaussBlur.h"

@interface TENFullViewController ()<TENFullViewProtocol>
@property (nonatomic, assign)   BOOL    isBlur;

@end

TENViewControllerBaseViewProperty(TENFullViewController, rootView, TENFullView)

@implementation TENFullViewController

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupRootView];
    [self.rootView fillWithModel:[self.itemsModel currentItem]];
}

#pragma mark -
#pragma mark Accessors

- (void)setIsBlur:(BOOL)isBlur {
    if (_isBlur != isBlur) {
        _isBlur = isBlur;
        
        NSImage *model = [self.itemsModel currentItem];
        if (isBlur) {
            model = [model gaussBlurOfRadius:5.];
        }
        
        TENFullView *rootView = self.rootView;
        [rootView fillWithModel:model];
        rootView.blurButton.title = isBlur ? @"Origin" : @"Blur";
    }
}

#pragma mark -
#pragma mark Interface Handling

- (IBAction)onUp:(NSButton *)sender {
    [self.rootView fillWithModel:[self.itemsModel previousItem]];
    self.isBlur = NO;
  }

- (IBAction)onDown:(NSButton *)sender {
    [self.rootView fillWithModel:[self.itemsModel nextItem]];
    self.isBlur = NO;
}

- (IBAction)onBlur:(NSButton *)sender {
    self.isBlur = !self.isBlur;
}

#pragma mark -
#pragma mark Private Methods

- (void)setupRootView {
    TENFullView *rootView = self.rootView;
    
    [[NSNotificationCenter defaultCenter] addObserverForName:NSWindowDidResizeNotification
                                                      object:rootView.window
                                                       queue:nil
                                                  usingBlock:^(NSNotification *notification){
                                                      CGSize size = rootView.window.frame.size;
                                                      NSRect rect = NSRectFromCGRect(CGRectMake(0, 0, size.width, size.height));
                                                      rootView.frame = rect;
                                                  }];
    
    rootView.wantsLayer = YES;
    rootView.layer.backgroundColor = [NSColor lightGrayColor].CGColor;
    
    rootView.delegate = self;
}

#pragma mark -
#pragma mark TENFullViewProtocol

- (void)didPressKeyWithCode:(NSInteger)keyCode {
    switch (keyCode) {
        case TENKeyCodeEsc:
            [self dismissController:self];
            break;
        default:
            break;
    }
}

@end
