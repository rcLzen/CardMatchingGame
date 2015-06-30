//
//  PlayingCard.h
//  Matchismo1
//
//  Created by Richard on 11/14/13.
//  Copyright (c) 2013 rcLzen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
// suit to represent card suit characters
@property (nonatomic) NSUInteger rank;
// rank to represent 0 to 13

+ (NSArray *)validSuits;

+ (NSUInteger)maxRank;


@end
