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
@property (nonatomic, strong) NSMutableArray *isAwake;
@end

@implementation PMNibLinkableView

static int kPMNibLinkableViewTag = 999;

+ (void)initialize {
    [super initialize];
    if (self != [PMNibLinkableView class]) {
        [self swizzleAwakeFromNib];
    }
}

+ (void)swizzleAwakeFromNib
{
    Class class = [self class];
    SEL originalSelector = @selector(awakeFromNib);
    NSString *className = NSStringFromClass(class);

    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    void (*originalImp)(id, SEL) = (void (*)(id, SEL))method_getImplementation(originalMethod);
    
    IMP blockImpl = imp_implementationWithBlock(^(PMNibLinkableView *self) {
        
        if (!self.isAwake) {
            self.isAwake = [NSMutableArray array];
        }
        
        if (![self.isAwake containsObject:className]) {
            
            [self.isAwake addObject:className];
            originalImp(self, @selector(awakeFromNib));
        }
        
    });
    
    BOOL didAddMethod = class_addMethod(class, originalSelector, blockImpl, "v@:");
    
    if (!didAddMethod) {
        method_setImplementation(originalMethod, blockImpl);
    }
}

- (id)awakeAfterUsingCoder:(NSCoder *)aDecoder
{
    if (self.subviews.count != 0 && self.tag != kPMNibLinkableViewTag) {
        return [super awakeAfterUsingCoder:aDecoder];
    }
    
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

@end

