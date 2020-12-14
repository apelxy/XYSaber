//
//  UIView+MASAdditions.m
//  Masonry
//
//  Created by Jonas Budelmann on 20/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "View+XYMASAdditions.h"
#import <objc/runtime.h>

@implementation MAS_VIEW (XYMASAdditions)

- (NSArray *)mas_makeConstraints:(void(^)(XYMASConstraintMaker *))block {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    XYMASConstraintMaker *constraintMaker = [[XYMASConstraintMaker alloc] initWithView:self];
    block(constraintMaker);
    return [constraintMaker install];
}

- (NSArray *)mas_updateConstraints:(void(^)(XYMASConstraintMaker *))block {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    XYMASConstraintMaker *constraintMaker = [[XYMASConstraintMaker alloc] initWithView:self];
    constraintMaker.updateExisting = YES;
    block(constraintMaker);
    return [constraintMaker install];
}

- (NSArray *)mas_remakeConstraints:(void(^)(XYMASConstraintMaker *make))block {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    XYMASConstraintMaker *constraintMaker = [[XYMASConstraintMaker alloc] initWithView:self];
    constraintMaker.removeExisting = YES;
    block(constraintMaker);
    return [constraintMaker install];
}

#pragma mark - NSLayoutAttribute properties

- (XYMASViewAttribute *)mas_left {
    return [[XYMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeLeft];
}

- (XYMASViewAttribute *)mas_top {
    return [[XYMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeTop];
}

- (XYMASViewAttribute *)mas_right {
    return [[XYMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeRight];
}

- (XYMASViewAttribute *)mas_bottom {
    return [[XYMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeBottom];
}

- (XYMASViewAttribute *)mas_leading {
    return [[XYMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeLeading];
}

- (XYMASViewAttribute *)mas_trailing {
    return [[XYMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeTrailing];
}

- (XYMASViewAttribute *)mas_width {
    return [[XYMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeWidth];
}

- (XYMASViewAttribute *)mas_height {
    return [[XYMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeHeight];
}

- (XYMASViewAttribute *)mas_centerX {
    return [[XYMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeCenterX];
}

- (XYMASViewAttribute *)mas_centerY {
    return [[XYMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeCenterY];
}

- (XYMASViewAttribute *)mas_baseline {
    return [[XYMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeBaseline];
}

- (XYMASViewAttribute *(^)(NSLayoutAttribute))mas_attribute
{
    return ^(NSLayoutAttribute attr) {
        return [[XYMASViewAttribute alloc] initWithView:self layoutAttribute:attr];
    };
}

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000) || (__MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)

- (XYMASViewAttribute *)mas_firstBaseline {
    return [[XYMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeFirstBaseline];
}
- (XYMASViewAttribute *)mas_lastBaseline {
    return [[XYMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeLastBaseline];
}

#endif

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000)

- (XYMASViewAttribute *)mas_leftMargin {
    return [[XYMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeLeftMargin];
}

- (XYMASViewAttribute *)mas_rightMargin {
    return [[XYMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeRightMargin];
}

- (XYMASViewAttribute *)mas_topMargin {
    return [[XYMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeTopMargin];
}

- (XYMASViewAttribute *)mas_bottomMargin {
    return [[XYMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeBottomMargin];
}

- (XYMASViewAttribute *)mas_leadingMargin {
    return [[XYMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeLeadingMargin];
}

- (XYMASViewAttribute *)mas_trailingMargin {
    return [[XYMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeTrailingMargin];
}

- (XYMASViewAttribute *)mas_centerXWithinMargins {
    return [[XYMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeCenterXWithinMargins];
}

- (XYMASViewAttribute *)mas_centerYWithinMargins {
    return [[XYMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeCenterYWithinMargins];
}

#endif

#if (__IPHONE_OS_VERSION_MAX_ALLOWED >= 110000) || (__TV_OS_VERSION_MAX_ALLOWED >= 110000)

- (XYMASViewAttribute *)mas_safeAreaLayoutGuide {
    return [[XYMASViewAttribute alloc] initWithView:self item:self.safeAreaLayoutGuide layoutAttribute:NSLayoutAttributeBottom];
}
- (XYMASViewAttribute *)mas_safeAreaLayoutGuideTop {
    return [[XYMASViewAttribute alloc] initWithView:self item:self.safeAreaLayoutGuide layoutAttribute:NSLayoutAttributeTop];
}
- (XYMASViewAttribute *)mas_safeAreaLayoutGuideBottom {
    return [[XYMASViewAttribute alloc] initWithView:self item:self.safeAreaLayoutGuide layoutAttribute:NSLayoutAttributeBottom];
}
- (XYMASViewAttribute *)mas_safeAreaLayoutGuideLeft {
    return [[XYMASViewAttribute alloc] initWithView:self item:self.safeAreaLayoutGuide layoutAttribute:NSLayoutAttributeLeft];
}
- (XYMASViewAttribute *)mas_safeAreaLayoutGuideRight {
    return [[XYMASViewAttribute alloc] initWithView:self item:self.safeAreaLayoutGuide layoutAttribute:NSLayoutAttributeRight];
}

#endif

#pragma mark - associated properties

- (id)mas_key {
    return objc_getAssociatedObject(self, @selector(mas_key));
}

- (void)setMas_key:(id)key {
    objc_setAssociatedObject(self, @selector(mas_key), key, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - heirachy

- (instancetype)mas_closestCommonSuperview:(MAS_VIEW *)view {
    MAS_VIEW *closestCommonSuperview = nil;

    MAS_VIEW *secondViewSuperview = view;
    while (!closestCommonSuperview && secondViewSuperview) {
        MAS_VIEW *firstViewSuperview = self;
        while (!closestCommonSuperview && firstViewSuperview) {
            if (secondViewSuperview == firstViewSuperview) {
                closestCommonSuperview = secondViewSuperview;
            }
            firstViewSuperview = firstViewSuperview.superview;
        }
        secondViewSuperview = secondViewSuperview.superview;
    }
    return closestCommonSuperview;
}

@end
