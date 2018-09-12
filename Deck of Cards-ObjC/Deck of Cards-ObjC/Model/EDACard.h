//
//  EDACard.h
//  Deck of Cards-ObjC
//
//  Created by Eric Andersen on 9/11/18.
//  Copyright © 2018 Eric Andersen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EDACard : NSObject

@property (nonatomic, copy, readonly) NSString *suit;
@property (nonatomic, copy, readonly) NSString *image;

- (instancetype)initWithSuit:(NSString *)suit image:(NSString *)image;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
