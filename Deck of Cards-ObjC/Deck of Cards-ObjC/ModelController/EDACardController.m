//
//  EDACardController.m
//  Deck of Cards-ObjC
//
//  Created by Eric Andersen on 9/11/18.
//  Copyright © 2018 Eric Andersen. All rights reserved.
//

#import "EDACardController.h"
#import "EDACard.h"

@implementation EDACardController

+ (instancetype)sharedController
{
    static EDACardController *sharedController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedController = [[EDACardController alloc] init];
    });
    return sharedController;
}

+ (NSURL *)baseURL
{
    return [NSURL URLWithString:@"https://deckofcardsapi.com/api/deck/new/draw/"];
}

- (void)drawNewCard:(NSInteger)numberOfCards completion:(void (^)(NSArray<EDACard *> *, NSError *))completion
{
    
    NSString *cardCount = [@(numberOfCards) stringValue];
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:[EDACardController baseURL] resolvingAgainstBaseURL:true];
    
    NSURLQueryItem *queryItem = [NSURLQueryItem queryItemWithName:@"count" value:cardCount];
    urlComponents.queryItems = @[queryItem];
    NSURL *searchURL = urlComponents.URL;
    
    
    [[[NSURLSession sharedSession] dataTaskWithURL:searchURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error) {
            NSLog(@"%@", error.localizedDescription);
            return completion(nil, [NSError errorWithDomain:@"error Fetching json" code:(NSInteger)-1 userInfo:nil]);
        }
        
        if (!data) {
            NSLog(@"Error: no data returned from task");
            return completion(nil, [NSError errorWithDomain:@"error Fetching Data" code:(NSInteger)-1 userInfo:nil]);
        }
        
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        if (!jsonDictionary || ![jsonDictionary isKindOfClass:[NSDictionary class]]) {
            NSDictionary *userInfo = nil;
            if (error) { userInfo = @{NSUnderlyingErrorKey : error}; }
            NSLog(@"%@", error.localizedDescription);
            return completion(nil, error);
        }
        
        NSArray *cardsArray = jsonDictionary[@"cards"];
        NSMutableArray *cardsPlaceholder = [NSMutableArray array];
        
        for (NSDictionary *cardDictionary in cardsArray) {
            
            EDACard *card = [[EDACard alloc] initWithDictionary: cardDictionary];
            [cardsPlaceholder addObject: card];
        }
        completion(cardsPlaceholder, nil);
        
        
    }]resume];
}


- (void)fetchCardImage:(EDACard *)card completion:(void (^)(UIImage * _Nonnull, NSError * _Nonnull))completion
{
    NSURL *imageURL = [NSURL URLWithString:card.image];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:imageURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error) {
            NSLog(@"%@", error.localizedDescription);
            return completion(nil, [NSError errorWithDomain:@"error Fetching json" code:(NSInteger)-1 userInfo:nil]);
        }
        
        if (!data) {
            NSLog(@"Error: no image dagta returned from task");
            return completion(nil, [NSError errorWithDomain:@"error Fetching Image Data" code:(NSInteger)-1 userInfo:nil]);
        }
        
        UIImage *cardImage = [UIImage imageWithData:data];
        completion(cardImage, nil);
        
    }]resume];
}


@end
