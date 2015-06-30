//
//  Card.m
//  Matchismo1
//
//  Created by Richard on 11/4/13.
//  Copyright (c) 2013 rcLzen. All rights reserved.
//

#import "Card.h"

// Private declaration of a class
@interface Card()

@end
// Part 2 of declaring a class
@implementation Card
// this allows to match with multiple cards
- (int)match:(NSArray *)otherCards
{
    int score = 0;  // 0 means no match, higher numbers better match

    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }

    return score;
}

	
@end
