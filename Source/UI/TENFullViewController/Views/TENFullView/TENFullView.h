//
//  TENFullView.h
//  TENGallery
//
//  Created by 444ten on 9/4/16.
//  Copyright © 2016 444ten. All rights reserved.
//

#import "TENView.h"

@protocol TENFullViewProtocol <NSObject>

- (void)didPressKeyWithCode:(NSInteger)keyCode;

@end

@interface TENFullView : TENView
@property (nonatomic, weak) id<TENFullViewProtocol> delegate;

@property (strong) IBOutlet NSButton *blurButton;

@end
