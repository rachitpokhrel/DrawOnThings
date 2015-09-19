//
//  DTCanvas.m
//  DrawOnThings
//
//  Created by Rachit on 9/15/15.
//  Copyright (c) 2015 Rachit. All rights reserved.
//

#import "DTCanvas.h"
#import <QuartzCore/QuartzCore.h>

@interface DTCanvas()

@property (strong) UIBezierPath *path;

@end

@implementation DTCanvas


-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]){
        self.multipleTouchEnabled = NO;
        self.userInteractionEnabled = YES;
        }
    return self;
}



- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    // Drawing code
    [self.path stroke];
}

- (void) touchesBegan:(NSSet *) touches withEvent:(UIEvent *) event
{
    // Initialize a new path for the user gesture
    self.path = [UIBezierPath bezierPath];
    self.path.lineWidth = 4.0f;
    UITouch *touch = [touches anyObject];
    [self.path moveToPoint:[touch locationInView:self]];
}

- (void) touchesMoved:(NSSet *) touches withEvent:(UIEvent *) event
{
    // Add new points to the path
    UITouch *touch = [touches anyObject];
    [self.path addLineToPoint:[touch locationInView:self]];
    [self setNeedsDisplay];
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    [self.path addLineToPoint:[touch locationInView:self]];
    [self setNeedsDisplay];
    

}

- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesEnded:touches withEvent:event];
}

- (UIImage *)pb_takeSnapshot {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    
    // old style [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

CGContextRef newBitmapContextSuitableForSize(CGSize size)
{
    int pixelsWide = size.width;
    int pixelsHigh = size.height;
    CGContextRef    context = NULL;
    CGColorSpaceRef colorSpace;
    // void *          bitmapData;
    int             bitmapByteCount;
    int             bitmapBytesPerRow;
    
    bitmapBytesPerRow   = (pixelsWide * 4); //4
    bitmapByteCount     = (bitmapBytesPerRow * pixelsHigh);
    
    /* bitmapData = malloc( bitmapByteCount );
     
     memset(bitmapData, 0, bitmapByteCount);  // set memory to black, alpha 0
     
     if (bitmapData == NULL)
     {
     return NULL;
     }
     */
    colorSpace = CGColorSpaceCreateDeviceRGB();
    
    context = CGBitmapContextCreate ( NULL, // instead of bitmapData
                                     pixelsWide,
                                     pixelsHigh,
                                     8,      // bits per component
                                     bitmapBytesPerRow,
                                     colorSpace,
                                     kCGImageAlphaPremultipliedFirst);
    CGColorSpaceRelease( colorSpace );
    
    if (context== NULL)
    {
        // free (bitmapData);
        return NULL;
    }
    
    return context;
}

#define Mask8(x) ( (x) & 0xFF )
#define R(x) ( Mask8(x) )
#define G(x) ( Mask8(x >> 8 ) )
#define B(x) ( Mask8(x >> 16) )
#define A(x) ( Mask8(x >> 24) )
#define RGBAMake(r, g, b, a) ( Mask8(r) | Mask8(g) << 8 | Mask8(b) << 16 | Mask8(a) << 24 )

- (UIImage *)imageByDrawingOnImageCG:(UIImage *)image
{
    // begin a graphics context of sufficient size
    CGContextRef ctx = newBitmapContextSuitableForSize(image.size);
    
    // draw original image into the context
    CGRect imageRect = CGRectMake(0, 0, image.size.width, image.size.height);
    CGContextDrawImage(ctx, imageRect, image.CGImage);
    
    UIImage *drawnImage = [self pb_takeSnapshot];
    
    // make image out of bitmap context
    CGImageRef cgImage = CGBitmapContextCreateImage(ctx);
    UIImage *retImage = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    CGContextRelease(ctx);
    
    return [self processUsingPixels:retImage blendImage:drawnImage];
}

#define Mask8(x) ( (x) & 0xFF )
#define R(x) ( Mask8(x) )
#define G(x) ( Mask8(x >> 8 ) )
#define B(x) ( Mask8(x >> 16) )
#define A(x) ( Mask8(x >> 24) )
#define RGBAMake(r, g, b, a) ( Mask8(r) | Mask8(g) << 8 | Mask8(b) << 16 | Mask8(a) << 24 )
- (UIImage *)processUsingPixels:(UIImage*)inputImage blendImage:(UIImage*)drawnImage{
    
    // 1. Get the raw pixels of the image
    UInt32 * inputPixels;
    
    CGImageRef inputCGImage = [inputImage CGImage];
    NSUInteger inputWidth = CGImageGetWidth(inputCGImage);
    NSUInteger inputHeight = CGImageGetHeight(inputCGImage);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    NSUInteger bytesPerPixel = 4;
    NSUInteger bitsPerComponent = 8;
    
    NSUInteger inputBytesPerRow = bytesPerPixel * inputWidth;
    
    inputPixels = (UInt32 *)calloc(inputHeight * inputWidth, sizeof(UInt32));
    
    CGContextRef context = CGBitmapContextCreate(inputPixels, inputWidth, inputHeight,
                                                 bitsPerComponent, inputBytesPerRow, colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    
    CGContextDrawImage(context, CGRectMake(0, 0, inputWidth, inputHeight), inputCGImage);
    
    // 2. Blend the ghost onto the image
    //UIImage * ghostImage = [UIImage imageNamed:@"ghost"];
    UIImage * ghostImage = drawnImage;
    CGImageRef ghostCGImage = [ghostImage CGImage];
    
    // 2.1 Calculate the size & position of the ghost
    
    CGImageRef drawnCGImage = [drawnImage CGImage];
    NSUInteger drawnWidth = CGImageGetWidth(drawnCGImage);
    NSUInteger drawnHeight = CGImageGetHeight(drawnCGImage);
    CGFloat ghostImageAspectRatio = ghostImage.size.width / ghostImage.size.height;
    NSInteger targetGhostWidth = inputWidth * 0.25;
    CGSize ghostSize = CGSizeMake(targetGhostWidth, targetGhostWidth / ghostImageAspectRatio);
    //CGSize ghostSize = CGSizeMake(inputWidth, inputHeight);
    CGPoint ghostOrigin = CGPointMake(inputWidth * 0.5, inputHeight*0.2);
    //CGPoint ghostOrigin = CGPointMake(self.frame.origin.x, self.frame.origin.y);
    
    // 2.2 Scale & Get pixels of the ghost
    NSUInteger ghostBytesPerRow = bytesPerPixel * ghostSize.width;
    
    UInt32 * ghostPixels = (UInt32 *)calloc(ghostSize.width * ghostSize.height, sizeof(UInt32));
    
    CGContextRef ghostContext = CGBitmapContextCreate(ghostPixels, ghostSize.width, ghostSize.height,
                                                      bitsPerComponent, ghostBytesPerRow, colorSpace,
                                                      kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    
    CGContextDrawImage(ghostContext, CGRectMake(0, 0, ghostSize.width, ghostSize.height),ghostCGImage);
    
    // 2.3 Blend each pixel
    NSUInteger offsetPixelCountForInput = ghostOrigin.y * inputWidth + ghostOrigin.x;
    for (NSUInteger j = 0; j < ghostSize.height; j++) {
        for (NSUInteger i = 0; i < ghostSize.width; i++) {
            UInt32 * inputPixel = inputPixels + j * inputWidth + i + offsetPixelCountForInput;
            UInt32 inputColor = *inputPixel;
            
            UInt32 * ghostPixel = ghostPixels + j * (int)ghostSize.width + i;
            UInt32 ghostColor = *ghostPixel;
            
            // Blend the ghost with 50% alpha
            CGFloat ghostAlpha = 1.0f * (A(ghostColor) / 255.0);
            UInt32 newR = R(inputColor) * (1 - ghostAlpha) + R(ghostColor) * ghostAlpha;
            UInt32 newG = G(inputColor) * (1 - ghostAlpha) + G(ghostColor) * ghostAlpha;
            UInt32 newB = B(inputColor) * (1 - ghostAlpha) + B(ghostColor) * ghostAlpha;
            
            //Clamp, not really useful here :p
            newR = MAX(0,MIN(255, newR));
            newG = MAX(0,MIN(255, newG));
            newB = MAX(0,MIN(255, newB));
            
            *inputPixel = RGBAMake(newR, newG, newB, A(inputColor));
        }
    }
    /*
     // 3. Convert the image to Black & White
     for (NSUInteger j = 0; j < inputHeight; j++) {
     for (NSUInteger i = 0; i < inputWidth; i++) {
     UInt32 * currentPixel = inputPixels + (j * inputWidth) + i;
     UInt32 color = *currentPixel;
     
     // Average of RGB = greyscale
     UInt32 averageColor = (R(color) + G(color) + B(color)) / 3.0;
     
     *currentPixel = RGBAMake(averageColor, averageColor, averageColor, A(color));
     }
     }
     */
    // 4. Create a new UIImage
    CGImageRef newCGImage = CGBitmapContextCreateImage(context);
    UIImage * processedImage = [UIImage imageWithCGImage:newCGImage];
    
    // 5. Cleanup!
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    CGContextRelease(ghostContext);
    free(inputPixels);
    free(ghostPixels);
    return processedImage;
}
#undef RGBAMake
#undef R
#undef G
#undef B
#undef A
#undef Mask8

#pragma mark Helpers

@end
