//
//  CardMatchingGame.h
//  Matchismo1
//
//  Created by Richard on 12/18/13.
//  Copyright (c) 2013 rcLzen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck;
- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;
@property (nonatomic) NSUInteger maxMatchingCards;
@property (nonatomic, readonly) NSInteger score;
@property (nonatomic, readonly) NSArray *lastChosenCards;
@property (nonatomic, readonly) NSInteger lastScore;


@end
