//
//  TENFullView.m
//  TENGallery
//
//  Created by 444ten on 9/4/16.
//  Copyright © 2016 444ten. All rights reserved.
//

#import "TENFullView.h"

#import <Quartz/Quartz.h>

@interface TENFullView ()
@property (strong)  IBOutlet NSImageView    *fullImageView;
@property (strong)  IBOutlet NSButton       *upButton;
@property (strong)  IBOutlet NSButton       *downButton;

@end

@implementation TENFullView

#pragma mark -
#pragma mark Overriden Methods

- (void)fillWithModel:(NSImage *)model {
    if (model) {
        self.fullImageView.image = model;
    }
}

- (void)mouseUp:(NSEvent *)theEvent {

}

- (void)keyDown:(NSEvent *)theEvent {
    NSInteger keyCode = theEvent.keyCode;
    
    switch (keyCode) {
        case TENKeyCodeEsc:
        {
            if ([self.delegate respondsToSelector:@selector(didPressKeyWithCode:)]) {
                [self.delegate didPressKeyWithCode:keyCode];
            }
            
            break;
        }
        case TENKeyCodeArrowUp:
            [self.upButton performClick:nil];
            break;
        case TENKeyCodeArrowDown:
            [self.downButton performClick:nil];
            break;
        default:
            break;
    }
}


@end
