//
//  EDACardController.h
//  Deck of Cards-ObjC
//
//  Created by Eric Andersen on 9/11/18.
//  Copyright © 2018 Eric Andersen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "EDACard.h"

@interface EDACardController : NSObject

NS_ASSUME_NONNULL_BEGIN

+ (instancetype)sharedController;

- (void)drawNewCard:(NSInteger)numberOfCards completion:(void(^) (NSArray<EDACard *> *cards, NSError *error))completion;
- (void)fetchCardImage:(EDACard *)card completion:(void(^) (UIImage *image, NSError *error))completion;

NS_ASSUME_NONNULL_END

@end
