//
//  PMViewController.m
//  PMNibLinkableView
//
//  Created by Antol on 07/27/2016.
//  Copyright (c) 2016 Antol. All rights reserved.
//

#import "PMViewController.h"
#import "PMSecondView.h"

@interface PMViewController ()
@property (weak, nonatomic) IBOutlet PMSecondView *secondView;
@end

@implementation PMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"=ViewController=> Second wiew text %@", self.secondView.label.text);
    NSLog(@"=ViewController=> Second wiew delegate %@", self.secondView.delegate);
}

@end
