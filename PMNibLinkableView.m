//
//  PMNibLinkableView.m
//  MyDreams
//
//  Created by Anatoliy Peshkov on 21/06/2016.
//  Copyright © 2016 Perpetuum Mobile lab. All rights reserved.
//

#import "PMNibLinkableView.h"
#import <objc/runtime.h>

@interface PMNibLinkableView ()
@property (nonatomic, assign) BOOL isAwake;
@end

@implementation PMNibLinkableView

static int kEJNibLinkableViewTag = 999;

- (id)awakeAfterUsingCoder:(NSCoder *)aDecoder
{
    if (self.subviews.count != 0 && self.tag != kEJNibLinkableViewTag) {
        return [super awakeAfterUsingCoder:aDecoder];
    }
    
    [self swizzleAwakeFromNib];
    
    UIView *loadedView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
    loadedView.frame = self.frame;
    loadedView.alpha = self.alpha;
    loadedView.autoresizingMask = self.autoresizingMask;
    loadedView.translatesAutoresizingMaskIntoConstraints = self.translatesAutoresizingMaskIntoConstraints;
    
    NSArray *constraints = self.constraints;
    
    for (UIView *view in self.subviews) {
        [loadedView addSubview:view];
    }
    
    for (NSLayoutConstraint *constraint in constraints) {
        id firstItem = (constraint.firstItem == self)? loadedView : constraint.firstItem;
        id secondItem = (constraint.secondItem == self)? loadedView : constraint.secondItem;
        NSLayoutConstraint *newConstraint = [NSLayoutConstraint constraintWithItem:firstItem
                                                                         attribute:constraint.firstAttribute
                                                                         relatedBy:constraint.relation
                                                                            toItem:secondItem
                                                                         attribute:constraint.secondAttribute
                                                                        multiplier:constraint.multiplier
                                                                          constant:constraint.constant];
        newConstraint.priority = constraint.priority;
        [loadedView addConstraint:newConstraint];
    }
    return loadedView;
}

- (void)swizzleAwakeFromNib
{
    Class class = [self class];
    
    SEL originalSelector = @selector(awakeFromNib);
    SEL swizzledSelector = @selector(awakeFromLinkableNib);
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL didAddMethod = class_addMethod(class,
                                        originalSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    }
    else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

- (void)awakeFromLinkableNib {
    if (self.isAwake) {
        [self swizzleAwakeFromNib];
    }
    else {
        self.isAwake = YES;
        [self awakeFromLinkableNib];
    }
}

@end


