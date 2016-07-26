//
//  ViewController.m
//  PMNibLinkableViewExample
//
//  Created by Anatoliy Peshkov on 26/07/2016.
//  Copyright © 2016 Perpetuum Mobile lab. All rights reserved.
//

#import "ViewController.h"
#import "PMSecondView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet PMSecondView *secondView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"=ViewController=> Second wiew text %@", self.secondView.label.text);
    NSLog(@"=ViewController=> Second wiew delegate %@", self.secondView.delegate);
}

@end
