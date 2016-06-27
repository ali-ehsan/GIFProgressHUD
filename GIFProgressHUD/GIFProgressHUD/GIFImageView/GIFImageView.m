//
//  GIFImageView.m
//  GIFProgressHUD
//
//  Created by Ali Ehsan on 6/18/16.
//  Copyright © 2016 TkXel. All rights reserved.
//

#import "GIFImageView.h"
#import "UIImage+GIFImage.h"

static NSString * const kGIF = @"gif";

@implementation GIFImageView

+ (GIFImageView *)gifImageViewWithGIFName:(NSString *)gifName {
    
    // Load URL for GIF image.
    NSURL *gifURL = [[NSBundle mainBundle] URLForResource:gifName withExtension:kGIF];
    
    // If no image found.
    if (!gifName || !gifURL) {
        return nil;
    }
    
    // Get the GIF image.
    UIImage *gifImage = [UIImage animatedImageWithAnimatedGIFURL:gifURL];
    
    // Return GIF image view.
    return [[GIFImageView alloc] initWithImage:gifImage];
}

@end
