//
//  EDACardViewController.m
//  Deck of Cards-ObjC
//
//  Created by Eric Andersen on 9/11/18.
//  Copyright © 2018 Eric Andersen. All rights reserved.
//

#import "EDACardViewController.h"
#import "EDACardController.h"
#import "EDACard.h"

@interface EDACardViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *cardImageView;
@property (weak, nonatomic) IBOutlet UILabel *suitLabel;

@end

@implementation EDACardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)updateView
{
    [[EDACardController sharedController] drawNewCard:1 completion:^(NSArray<EDACard *> * _Nonnull cards, NSError * _Nonnull error) {
        
        if (error) {
            NSLog(@"Error getting photo references for %@ on %@:", cards, error);
            return;
        }
        
        EDACard *card = [cards objectAtIndex:0];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.suitLabel.text = card.suit;
        });
        
        [[EDACardController sharedController] fetchCardImage:card completion:^(UIImage * _Nonnull image, NSError * _Nonnull error) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.cardImageView.image = image;
            });
        }];
    }];
}

- (IBAction)drawCardButtonTapped:(UIButton *)sender {
    [self updateView];
}


@end
