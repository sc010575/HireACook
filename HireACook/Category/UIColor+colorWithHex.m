//
//  UIColor+colorWithHex.m
//  IEAtom
//
//  Created by Suman Chatterjee on 27/01/2015.
//
//

#import "UIColor+colorWithHex.h"

@implementation UIColor (colorWithHex)

+ colorWithHex:(UInt32)hex alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:((hex & 0xFF0000) >> 16)/255.0
                           green:((hex & 0x00FF00) >> 8)/255.0
                            blue:( hex & 0x0000FF)/255.0
                           alpha:alpha];
}
@end
