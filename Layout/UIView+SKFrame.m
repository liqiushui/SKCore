/**
 * Copyright (c) 2013 MeetMe, Inc.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 * 1. Redistributions of source code must retain the above copyright
 * notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 * notice, this list of conditions and the following disclaimer in the
 * documentation and/or other materials provided with the distribution.
 * 3. Neither the name of the MeetMe inc. nor the
 * names of its contributors may be used to endorse or promote products
 * derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL MeetMe inc. BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "UIView+SKFrame.h"

CGPoint SKAppCenterPoint(void)
{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGFloat maxDimension = MAX(screenSize.width, screenSize.height);
    CGFloat minDimension = MIN(screenSize.width, screenSize.height);

    UIDeviceOrientation orient = (UIDeviceOrientation)[[UIApplication sharedApplication] statusBarOrientation];
    CGRect appFrame = CGRectMake(0.0, 0.0, minDimension, maxDimension);
    if (UIDeviceOrientationIsLandscape(orient))
    {
        appFrame = CGRectMake(0.0, 0.0, maxDimension, minDimension);
    }

    return CGPointMake(floor(appFrame.size.width/2.0), floor(appFrame.size.height/2.0));
}

CGFloat SKDegreesToRadians(CGFloat degrees)
{
    return degrees * M_PI / 180.0;
}

CGAffineTransform SKRotateTransformForOrientation(UIInterfaceOrientation orientation)
{
    if (orientation == UIInterfaceOrientationLandscapeLeft)
    {
        return CGAffineTransformMakeRotation(M_PI*1.5);
    }
    else if (orientation == UIInterfaceOrientationLandscapeRight)
    {
        return CGAffineTransformMakeRotation(M_PI/2);
    }
    else if (orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        return CGAffineTransformMakeRotation(-M_PI);
    }
    else
    {
        return CGAffineTransformIdentity;
    }
}

CGRect SKAppFrameForOrientation(UIDeviceOrientation orientation)
{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGFloat maxDimension = MAX(screenSize.width, screenSize.height);
    CGFloat minDimension = MIN(screenSize.width, screenSize.height);
    if (UIDeviceOrientationIsLandscape(orientation))
    {
        return CGRectMake(0.0, 0.0, maxDimension, minDimension);
    }
    else
    {
        return CGRectMake(0.0, 0.0, minDimension, maxDimension);
    }
}

@implementation UIView (SKFrame)

- (CGFloat)left
{
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top
{
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)aspectWidth
{
    return self.width;
}

- (void)setAspectWidth:(CGFloat)aspectWidth
{
    float factor = aspectWidth / self.width;

    self.width = aspectWidth;
    self.height = self.height / factor;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)aspectHeight
{
    return self.height;
}

- (void)setAspectHeight:(CGFloat)aspectHeight
{
    float factor = aspectHeight / self.height;

    self.width = self.width / factor;
    self.height = aspectHeight;
}

- (CGFloat)boundsWidth
{
    return self.bounds.size.width;
}

- (void)setBoundsWidth:(CGFloat)width
{
    CGRect bounds = self.bounds;
    bounds.size.width = width;
    self.bounds = bounds;
}

- (CGFloat)boundsHeight
{
    return self.bounds.size.height;
}

- (void)setBoundsHeight:(CGFloat)height
{
    CGRect bounds = self.bounds;
    bounds.size.height = height;
    self.bounds = bounds;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX
{
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY
{
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

+ (CGSize)scaleSize:(CGSize)scaleSize toFillSize:(CGSize)size
{
    CGSize returnSize = CGSizeZero;
    if (scaleSize.width > scaleSize.height)
    {
        float factor = scaleSize.height / size.height;
        returnSize = CGSizeMake(size.width / factor, size.height);
    }
    else
    {
        float factor = scaleSize.width / size.width;
        returnSize = CGSizeMake(size.width, scaleSize.height / factor);
    }

    return returnSize;
}

+ (CGSize)scaleSize:(CGSize)size toFitWidth:(float)width
{
    float factor = size.width / width;
    return CGSizeMake(width, size.height / factor);
}

@end
