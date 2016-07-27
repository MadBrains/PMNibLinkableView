//
//  PMSecondView.h
//  PMNibLinkableViewExample
//
//  Created by Anatoliy Peshkov on 26/07/2016.
//  Copyright © 2016 Perpetuum Mobile lab. All rights reserved.
//

#import "PMNibLinkableView.h"

@interface PMSecondView : PMNibLinkableView
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet id delegate;
@end
