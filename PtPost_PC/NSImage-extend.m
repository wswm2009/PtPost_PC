//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSImage-extend.h"

@implementation   NSImage (Extend)


#pragma reSize image
- (Boolean )imageResize: (NSSize)newSize
{
    NSImage *sourceImage = self;
    [sourceImage setScalesWhenResized:YES];
    
    // Report an error if the source isn't a valid image
    if (![sourceImage isValid]){
        NSLog(@"Invalid Image");
    } else {
        NSImage *smallImage = [[[NSImage alloc] initWithSize:newSize ]autorelease];
        [smallImage lockFocus];
        [sourceImage setSize: newSize];
        [[NSGraphicsContext currentContext] setImageInterpolation:NSImageInterpolationHigh];
        //  [sourceImage drawAtPoint:NSZeroPoint fromRect:CGRectMake(0, 0, newSize.width, newSize.height) operation:NSCompositeCopy fraction:1.0];
        
        [sourceImage drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
        [smallImage unlockFocus];
        return true;
    }
    return false ;
}




@end
