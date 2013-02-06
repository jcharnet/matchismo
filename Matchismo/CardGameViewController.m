//
//  CardGameViewController.m
//  Matchismo
//
//  Created by João Augusto Charnet on 1/27/13.
//  Copyright (c) 2013 João Augusto Charnet. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "Card.h"
#import "CardMatchingGame.h"
#import <QuartzCore/QuartzCore.h>

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusMsgLabel;
@property (weak, nonatomic) IBOutlet UISwitch *toggleTwoThreeGame;

@end

@implementation CardGameViewController

-(CardMatchingGame *)game {
    if(!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck: [[PlayingCardDeck alloc] init]];
    }
    
    return _game;
}

- (void)setFlipCount:(int)flipCount {
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (IBAction)flipCard:(UIButton *)sender {
    [self.game flipCardAtIndex: [self.cardButtons indexOfObject:sender]
            playingTwoCardGame:self.toggleTwoThreeGame.isOn];
    self.flipCount++;
    [self updateUI];
    if (self.toggleTwoThreeGame.isEnabled) {
        self.toggleTwoThreeGame.enabled = NO;
    }

}

-(void)setCardButtons:(NSArray *)cardButtons {
    _cardButtons = cardButtons;
    for (UIButton *cardButton in _cardButtons) {
        [cardButton setBackgroundImage:[UIImage imageNamed:@"BackCard.png"] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[UIImage imageNamed:@"transparent.png"]forState:UIControlStateSelected];
        [cardButton setBackgroundImage:[UIImage imageNamed:@"transparent.png"] forState:UIControlStateSelected | UIControlStateDisabled];
        [[cardButton layer] setBorderWidth: 2.0f];
        [[cardButton layer] setCornerRadius:10.0f];
    }
    [self updateUI];
}

-(void)updateUI {
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle: card.contents forState:UIControlStateSelected];
        [cardButton setTitle: card.contents forState:UIControlStateSelected | UIControlStateDisabled];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = (card.isUnplayable ? 0.3 : 1.0);
    }
    self.statusMsgLabel.text = self.game.statusMessage;
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];

}
-(void)initTwoGame {
    self.game = nil;
    [self updateUI];
    self.flipCount = 0;
}
-(void)initThreeGame {
    
}

- (IBAction)deal:(UIButton *)sender {
    self.toggleTwoThreeGame.enabled = YES;
    if (self.toggleTwoThreeGame.isOn) {
        [self initTwoGame];
    } else {
        [self initThreeGame];
    }
    
}
- (IBAction)toggleTwoThreeCardGame:(UISwitch *)sender {
    if (sender.isOn) {
        [self initTwoGame];
    }
}

@end
