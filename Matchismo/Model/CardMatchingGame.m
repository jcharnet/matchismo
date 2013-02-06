//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by João Augusto Charnet on 1/31/13.
//  Copyright (c) 2013 João Augusto Charnet. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (readwrite, nonatomic) int score;
@property (strong, nonatomic) NSMutableArray *cards; // of Card
@property (nonatomic) int currentScore;
@end

@implementation CardMatchingGame

-(id)init {
    return nil;
}

-(NSMutableArray *)cards {
    if(!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    
    return _cards;
}

-(id)initWithCardCount:(NSUInteger)count
             usingDeck:(Deck *)deck {
    
    self = [super init];
    
    if(self) {
        for (int i=0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                self.cards[i] = card;
            } else {
                self = nil;
                break;
            }
        }
    }
    
    return self;
}

-(Card *)cardAtIndex:(NSUInteger)index {
    
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_COST 1

-(void)flipCardAtIndex:(NSUInteger)index
    playingTwoCardGame:(BOOL)twoCardGame {
    
    Card *card = [self cardAtIndex: index];
    NSMutableArray *cardsFacedUp = [[NSMutableArray alloc] init];
    
    if (card && !card.isUnplayable) {
        if (!card.isFaceUp) {
            for (Card *otherCard in self.cards) {
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    [cardsFacedUp addObject: otherCard];
                    
                    int matchScore = [card match:@[otherCard]];
                    if (matchScore) {
                        card.unplayable = YES;
                        otherCard.unplayable = YES;
                        self.currentScore = matchScore * MATCH_BONUS;
                        self.score += self.currentScore;
                        
                        self.statusMessage = [NSString stringWithFormat: @"Matched %@ & %@ for %d points !", card.contents, otherCard.contents, self.currentScore];
                    
                    } else {
                        otherCard.faceUp = NO;
                        self.currentScore = MISMATCH_PENALTY;
                        self.score -= self.currentScore;
                        
                        self.statusMessage = [NSString stringWithFormat:@"%@ and %@ don't match! %d point penalty !", card.contents, otherCard.contents, self.currentScore];
                    }
                
                    break;
                     
                     
                } else {
                    // uma carta virada, mostra mensagem da carta virada.
                    self.statusMessage = [NSString stringWithFormat:@"Flipped up %@", card.contents];
                }
            }
        }
        
        self.score -= FLIP_COST;
        
        card.faceUp = !card.faceUp;
    }
    
    // se tiver alguma carta virada
/*    if (cardsFacedUp.count) {
        int matchScore = [card match:cardsFacedUp];
        
        if (matchScore) {
            self.currentScore = matchScore * MATCH_BONUS;
            self.score += self.currentScore;
        } else {
            self.currentScore = MISMATCH_PENALTY * cardsFacedUp.count;
            self.score -= self.currentScore;
        }
        
        for (Card *otherCard in cardsFacedUp) {
            if (matchScore) {
                card.unplayable = YES;
                otherCard.unplayable = YES;
                
                self.statusMessage = [NSString stringWithFormat: @"Matched %@ & %@ for %d points !", card.contents, otherCard.contents, self.currentScore];

            } else {
                otherCard.faceUp = NO;
                
                self.statusMessage = [NSString stringWithFormat:@"%@ and %@ don't match! %d point penalty !", card.contents, otherCard.contents, self.currentScore];
            }
        }
    }
 */
}

@end
