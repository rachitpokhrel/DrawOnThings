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
{
    
}


-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]){
        self.multipleTouchEnabled = NO;
        }
    return self;
}

- (void)drawRect:(CGRect)rect {
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

- (UIImage *)dtsnapshot {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
    
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    
    // old style [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
