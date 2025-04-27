//
//  Loader.m
//  Victory
//
//  Created by Reynald Marquez-Gragasin on 4/22/25.
//

#import "Loader.h"

@implementation Loader

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        NSLog(@"%s","coder init call");
    }
    return self;
}


@end
