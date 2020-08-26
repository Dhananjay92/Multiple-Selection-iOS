//
//  UIImageAdditions.h
//  Sample
//
//  Created by Kirby Turner on 2/7/10.
//  Copyright 2010 White Peak Software Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIImage (extras)

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

- (UIImage *)imageScaleAspectToMaxSize:(CGFloat)newSize;
- (UIImage *)imageScaleAndCropToMaxSize:(CGSize)newSize;

-(UIImage *)fixOrientation;


+ (UIImage *)verticalImageFromArray:(NSArray *)imagesArray;
@end
