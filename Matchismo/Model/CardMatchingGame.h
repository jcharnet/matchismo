//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by João Augusto Charnet on 1/31/13.
//  Copyright (c) 2013 João Augusto Charnet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Deck.h"

@interface CardMatchingGame : NSObject

enum {
    TwoCardGame = 2,
    ThreeCardGame = 3
};

typedef NSInteger GameMode;

// designated initializer
-(id)initWithCardCount:(NSUInteger)count
             usingDeck:(Deck *)deck
          withGameMode: (GameMode) gameMode;

-(void)flipCardAtIndex:(NSUInteger)index
    playingTwoCardGame:(BOOL)twoCardGame;

-(Card *)cardAtIndex:(NSUInteger)index;

@property (readonly, nonatomic) int score;
@property (strong, nonatomic) NSString *statusMessage;

@end
