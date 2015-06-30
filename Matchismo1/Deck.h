//
//  Deck.h
//  Matchismo1
//
//  Created by Richard on 11/5/13.
//  Copyright (c) 2013 rcLzen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;

- (void)addCard:(Card *)card;

- (Card *)drawRandomCard;

@end
