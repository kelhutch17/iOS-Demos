//
//  ViewController.m
//  Bridging
//
//  Created by Hutchison, Kelly on 10/4/16.
//  Copyright © 2016 Hutchison, Kelly. All rights reserved.
//

#import "ViewController.h"
#import "Words.h"   // We need this because we want to use this specific objc class
#import "Bridging-Swift.h"  // we need this because we want to use a Swift class (you get ALL Swift classes with this import)

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    Words *words = [[Words alloc] init];
    NSLog(@"%@", [words favoriteWordsAndNumbersAndLetters]);
    
    Letters *letters = [[Letters alloc] init];
    NSLog(@"%@", [letters allTheThings]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
