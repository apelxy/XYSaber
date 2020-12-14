//
//  MASCompositeConstraint.m
//  Masonry
//
//  Created by Jonas Budelmann on 21/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "XYMASCompositeConstraint.h"
#import "MASConstraint+XYPrivate.h"

@interface XYMASCompositeConstraint () <MASConstraintDelegate>

@property (nonatomic, strong) id mas_key;
@property (nonatomic, strong) NSMutableArray *childConstraints;

@end

@implementation XYMASCompositeConstraint

- (id)initWithChildren:(NSArray *)children {
    self = [super init];
    if (!self) return nil;

    _childConstraints = [children mutableCopy];
    for (XYMASConstraint *constraint in _childConstraints) {
        constraint.delegate = self;
    }

    return self;
}

#pragma mark - MASConstraintDelegate

- (void)constraint:(XYMASConstraint *)constraint shouldBeReplacedWithConstraint:(XYMASConstraint *)replacementConstraint {
    NSUInteger index = [self.childConstraints indexOfObject:constraint];
    NSAssert(index != NSNotFound, @"Could not find constraint %@", constraint);
    [self.childConstraints replaceObjectAtIndex:index withObject:replacementConstraint];
}

- (XYMASConstraint *)constraint:(XYMASConstraint __unused *)constraint addConstraintWithLayoutAttribute:(NSLayoutAttribute)layoutAttribute {
    id<MASConstraintDelegate> strongDelegate = self.delegate;
    XYMASConstraint *newConstraint = [strongDelegate constraint:self addConstraintWithLayoutAttribute:layoutAttribute];
    newConstraint.delegate = self;
    [self.childConstraints addObject:newConstraint];
    return newConstraint;
}

#pragma mark - NSLayoutConstraint multiplier proxies 

- (XYMASConstraint * (^)(CGFloat))multipliedBy {
    return ^id(CGFloat multiplier) {
        for (XYMASConstraint *constraint in self.childConstraints) {
            constraint.multipliedBy(multiplier);
        }
        return self;
    };
}

- (XYMASConstraint * (^)(CGFloat))dividedBy {
    return ^id(CGFloat divider) {
        for (XYMASConstraint *constraint in self.childConstraints) {
            constraint.dividedBy(divider);
        }
        return self;
    };
}

#pragma mark - MASLayoutPriority proxy

- (XYMASConstraint * (^)(MASLayoutPriority))priority {
    return ^id(MASLayoutPriority priority) {
        for (XYMASConstraint *constraint in self.childConstraints) {
            constraint.priority(priority);
        }
        return self;
    };
}

#pragma mark - NSLayoutRelation proxy

- (XYMASConstraint * (^)(id, NSLayoutRelation))equalToWithRelation {
    return ^id(id attr, NSLayoutRelation relation) {
        for (XYMASConstraint *constraint in self.childConstraints.copy) {
            constraint.equalToWithRelation(attr, relation);
        }
        return self;
    };
}

#pragma mark - attribute chaining

- (XYMASConstraint *)addConstraintWithLayoutAttribute:(NSLayoutAttribute)layoutAttribute {
    [self constraint:self addConstraintWithLayoutAttribute:layoutAttribute];
    return self;
}

#pragma mark - Animator proxy

#if TARGET_OS_MAC && !(TARGET_OS_IPHONE || TARGET_OS_TV)

- (XYMASConstraint *)animator {
    for (XYMASConstraint *constraint in self.childConstraints) {
        [constraint animator];
    }
    return self;
}

#endif

#pragma mark - debug helpers

- (XYMASConstraint * (^)(id))key {
    return ^id(id key) {
        self.mas_key = key;
        int i = 0;
        for (XYMASConstraint *constraint in self.childConstraints) {
            constraint.key([NSString stringWithFormat:@"%@[%d]", key, i++]);
        }
        return self;
    };
}

#pragma mark - NSLayoutConstraint constant setters

- (void)setInsets:(MASEdgeInsets)insets {
    for (XYMASConstraint *constraint in self.childConstraints) {
        constraint.insets = insets;
    }
}

- (void)setInset:(CGFloat)inset {
    for (XYMASConstraint *constraint in self.childConstraints) {
        constraint.inset = inset;
    }
}

- (void)setOffset:(CGFloat)offset {
    for (XYMASConstraint *constraint in self.childConstraints) {
        constraint.offset = offset;
    }
}

- (void)setSizeOffset:(CGSize)sizeOffset {
    for (XYMASConstraint *constraint in self.childConstraints) {
        constraint.sizeOffset = sizeOffset;
    }
}

- (void)setCenterOffset:(CGPoint)centerOffset {
    for (XYMASConstraint *constraint in self.childConstraints) {
        constraint.centerOffset = centerOffset;
    }
}

#pragma mark - MASConstraint

- (void)activate {
    for (XYMASConstraint *constraint in self.childConstraints) {
        [constraint activate];
    }
}

- (void)deactivate {
    for (XYMASConstraint *constraint in self.childConstraints) {
        [constraint deactivate];
    }
}

- (void)install {
    for (XYMASConstraint *constraint in self.childConstraints) {
        constraint.updateExisting = self.updateExisting;
        [constraint install];
    }
}

- (void)uninstall {
    for (XYMASConstraint *constraint in self.childConstraints) {
        [constraint uninstall];
    }
}

@end
