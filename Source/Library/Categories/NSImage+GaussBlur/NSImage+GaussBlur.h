//
//  NSImage+GaussBlur.h
//  TENGallery
//
//  Created by 444ten on 9/5/16.
//  Copyright © 2016 444ten. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSImage (GaussBlur)

- (NSImage *)gaussBlurOfRadius:(CGFloat)radius;

@end
