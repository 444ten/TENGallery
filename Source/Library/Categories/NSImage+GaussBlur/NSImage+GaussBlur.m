//
//  NSImage+GaussBlur.m
//  TENGallery
//
//  Created by 444ten on 9/5/16.
//  Copyright © 2016 444ten. All rights reserved.
//

#import "NSImage+GaussBlur.h"

#import <QuartzCore/QuartzCore.h>

@implementation NSImage (GaussBlur)

- (NSImage *)gaussBlurOfRadius:(CGFloat)radius {
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    
    CIImage *inputImage = [CIImage imageWithData:[self TIFFRepresentation]];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    [filter setValue:@(radius) forKey:kCIInputRadiusKey];
    CIImage *outputImage = [filter valueForKey:kCIOutputImageKey];

    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef cgImage = [context createCGImage:outputImage fromRect:[inputImage extent]];

    return [[NSImage alloc] initWithCGImage:cgImage size:self.size];
}

@end
