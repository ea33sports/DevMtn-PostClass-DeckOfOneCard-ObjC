//
//  EDACard.m
//  Deck of Cards-ObjC
//
//  Created by Eric Andersen on 9/11/18.
//  Copyright © 2018 Eric Andersen. All rights reserved.
//

#import "EDACard.h"

@implementation EDACard

- (instancetype)initWithSuit:(NSString *)suit image:(NSString *)image
{
    if (self = [super init]) {
        _suit = [suit copy];
        _image = [image copy];
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSString *suit = dictionary[[EDACard suitKey]];
    NSString *image = dictionary[[EDACard imageKey]];
    
    return [self initWithSuit:suit image:image];
}

+ (NSString *)suitKey
{
    return @"suit";
}

+ (NSString *)imageKey
{
    return @"image";
}

@end
