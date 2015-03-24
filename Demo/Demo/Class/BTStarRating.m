//
//  BTStarRating.m
//  star
//
//  Created by Tongtong Xu on 15/3/24.
//  Copyright (c) 2015年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "BTStarRating.h"

#define kHalfStarThreshold (0.6)

@implementation BTStarRating

#pragma mark
#pragma mark - Setter

- (void)setRating:(float)ratingParam {
    _rating = ratingParam;
    [self setNeedsDisplay];
}

- (void)setStarHighlightedImage:(UIImage *)starHighlightedImage {
    _starHighlightedImage = starHighlightedImage;
    [self setNeedsDisplay];
}

- (void)setStarImage:(UIImage *)starImage {
    _starImage = starImage;
    [self setNeedsDisplay];
}

- (void)setMaxRating:(NSInteger)maxRating {
    _maxRating = maxRating;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGSize starSize = _starHighlightedImage.size;
    for (NSInteger i = 0; i < _maxRating; i++) {
        [self drawImage:self.starImage atPosition:i];
        if (i < _rating) {
            CGContextSaveGState(contextRef);
            if (i < _rating && _rating < i + 1) {
                CGPoint starPoint = [self pointOfStarAtPosition:i highlighted:NO];
                float difference = _rating - i;
                CGRect rectClip;
                rectClip.origin = starPoint;
                rectClip.size = starSize;
                if (difference < kHalfStarThreshold) {
                    rectClip.size.width /= 2.0;
                }
                if (rectClip.size.width > 0)
                    CGContextClipToRect(contextRef, rectClip);
            }
            [self drawImage:_starHighlightedImage atPosition:i];
            CGContextRestoreGState(contextRef);
        }
    }
}

- (void)drawImage:(UIImage *)image atPosition:(NSInteger)position {
    [image drawAtPoint:[self pointOfStarAtPosition:position highlighted:YES]];
}

#pragma mark -
#pragma mark Drawing

- (CGPoint)pointOfStarAtPosition:(NSInteger)position highlighted:(BOOL)hightlighted {
    CGSize size = hightlighted ? _starHighlightedImage.size : _starImage.size;

    NSInteger starsSpace = self.bounds.size.width - 2 * _horizontalMargin;

    NSInteger interSpace = 0;
    interSpace = _maxRating - 1 > 0 ? (starsSpace - (_maxRating)*size.width) / (_maxRating - 1) : 0;
    if (interSpace < 0)
        interSpace = 0;
    CGFloat x = _horizontalMargin + size.width * position;
    if (position > 0)
        x += interSpace * position;
    CGFloat y = (self.bounds.size.height - size.height) / 2.0;
    return CGPointMake(x, y);
}

#pragma mark -
#pragma mark Touch Interaction

- (float)starsForPoint:(CGPoint)point {
    float stars = 0;
    for (NSInteger i = 0; i < _maxRating; i++) {
        CGPoint p = [self pointOfStarAtPosition:i highlighted:NO];
        if (point.x > p.x) {
            float increment = 1.0;

            float difference = (point.x - p.x) / self.starImage.size.width;
            if (difference < kHalfStarThreshold) {
                increment = 0.5;
            }

            stars += increment;
        }
    }
    return stars;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!_editable)
        return;

    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self];
    self.rating = [self starsForPoint:touchLocation];
    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!_editable)
        return;

    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self];
    self.rating = [self starsForPoint:touchLocation];
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!_editable)
        return;

    if (self.returnBlock)
        self.returnBlock(self.rating);
}

@end
