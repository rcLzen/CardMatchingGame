//
//  Card.h
//  Matchismo1
//
//  Created by Richard on 11/4/13.
//  Copyright (c) 2013 rcLzen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter=isChosen) BOOL chosen;
@property (nonatomic, getter=isMatched) BOOL matched;

// Public method called match
- (int)match:(NSArray *)otherCards;

@end
