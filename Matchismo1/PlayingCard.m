//
//  PlayingCard.m
//  Matchismo1
//
//  Created by Richard on 11/14/13.
//  Copyright (c) 2013 rcLzen. All rights reserved.
//

#import "PlayingCard.h"


@implementation PlayingCard

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    int numberOfOtherCards = [otherCards count];
    
    if (numberOfOtherCards) {
        for (Card *card in otherCards) {
            if ([card isKindOfClass:[PlayingCard class]]) {
                PlayingCard *otherCard = (PlayingCard *)card;
                if ([self.suit isEqualToString:otherCard.suit]){
                    score += 1;
                } else if (self.rank == otherCard.rank) {
                    score += 4;
                }
            }
        }
    }
    if (numberOfOtherCards > 1) {
        score += [[otherCards firstObject] match:[otherCards subarrayWithRange:NSMakeRange(1, numberOfOtherCards - 1)]];
    }
    return score;
}

- (NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit; // because we provide setter AND getter

+ (NSArray *)validSuits
{
    return @[@"♥",@"♦",@"♠",@"♣"];
}

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

+ (NSArray *)rankStrings
{
    return @[@"?",@"A", @"2", @"3", @"4", @"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSUInteger)maxRank {
    return [[self rankStrings] count]-1;
}

- (void)setRank: (NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

@end
