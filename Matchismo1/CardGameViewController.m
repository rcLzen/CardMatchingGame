//
//  CardGameViewController.m
//  Matchismo1
//
//  Created by Richard on 11/4/13.
//  Copyright (c) 2013 rcLzen. All rights reserved.
//

#import "CardGameViewController.h"
#import "Deck.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()

@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *modeSelector;
@property (weak, nonatomic) IBOutlet UILabel *flipDescription;
@property (strong, nonatomic) NSMutableArray *flipHistory;
@property (weak, nonatomic) IBOutlet UISlider *historySlider;
@end

@implementation CardGameViewController

- (NSMutableArray *)flipHistory
{
    if (!_flipHistory) {
        _flipHistory = [NSMutableArray array];
    }
    return _flipHistory;
}

- (CardMatchingGame *)game
{
    if (!_game){ _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                          usingDeck:[self createDeck]];
        [self changeModeSelector:self.modeSelector];
    }
    return _game;
}


- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (IBAction)changeSlider:(UISlider *)sender {
    int sliderValue;
    sliderValue = lroundf(self.historySlider.value);
    [self.historySlider setValue:sliderValue animated:NO];
    if ([self.flipHistory count]) {
        self.flipDescription.alpha = 
        (sliderValue + 1 < [self.flipHistory count]) ? 0.6 : 1.0;
        self.flipDescription.text = [self.flipHistory objectAtIndex:sliderValue];
    }
}


- (IBAction)touchDealButton:(UIButton *)sender 
{
    self.modeSelector.enabled = YES;
    self.game = nil;
    self.flipHistory = nil;
    [self updateUI];
}
- (IBAction)changeModeSelector:(UISegmentedControl *)sender 
{
    self.game.maxMatchingCards = [[sender titleForSegmentAtIndex:sender.selectedSegmentIndex] integerValue];
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    self.modeSelector.enabled = NO;
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
   
}

- (void)setSliderRange
{
    int maxValue = [self.flipHistory count] - 1;
    self.historySlider.maximumValue = maxValue;
    [self.historySlider setValue:maxValue animated:YES];
}

-(void)updateUI 
{
    for (UIButton *cardButton in self.cardButtons) {
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    }
    if (self.game) {
        NSString *description = @"";
        if ([self.game.lastChosenCards count]) {
            NSMutableArray *cardContents = [NSMutableArray array];
            for (Card *card in self.game.lastChosenCards) {
                [cardContents addObject:card.contents];
            }
            description = [cardContents componentsJoinedByString:@""];
            
        }  if (self.game.lastScore > 0 ) {
            description = [NSString stringWithFormat:@" Matched %@ for %d points.", description, self.game.lastScore];
        } else if (self.game.lastScore < 0) {
            
            description = [NSString stringWithFormat:@" %@ No Match! %d POINT PENALTY!", description, -self.game.lastScore];
        }
        self.flipDescription.text = description;
        self.flipDescription.alpha = 1;
        
        if (![description isEqualToString:@""]
            && ![[self.flipHistory lastObject]isEqualToString:description]) {
            [self.flipHistory addObject:description];
            [self setSliderRange];
        }
    }
}

- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

@end
