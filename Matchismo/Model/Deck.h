//
//  Deck.h
//  Matchismo
//
//  Created by João Augusto Charnet on 1/27/13.
//  Copyright (c) 2013 João Augusto Charnet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *) card atTop:(BOOL)atTop;
- (Card *)drawRandomCard;

@end
