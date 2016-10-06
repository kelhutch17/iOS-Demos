//
//  Words.m
//  Bridging
//
//  Created by Hutchison, Kelly on 10/5/16.
//  Copyright © 2016 Hutchison, Kelly. All rights reserved.
//

#import "Words.h"
#import "Bridging-Swift.h"  // We need this since we want to use Swift classes

@implementation Words
- (NSArray<NSString *> *)favoriteWords {
    return [[NSArray alloc] initWithObjects:@"I", @"love", @"computer", @"science", nil];
}

// Uses functions from this class and from a Swift class
- (NSMutableArray<NSString *> *)favoriteWordsAndNumbersAndLetters {
    Letters *letters = [[Letters alloc] init];
    
    // Letters is a Swift class. We are able to use it in Obj c here becayse of the #import "Bridging-Swift.h" statement at the top
    NSMutableArray<NSString *> *allTheThings = [NSMutableArray arrayWithArray:[letters favoriteNumbersAndLetters]];
    
    [allTheThings addObjectsFromArray: [self favoriteWords]];
    
    return allTheThings;
}
@end
