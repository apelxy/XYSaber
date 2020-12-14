//
//  MASConstraintMaker.m
//  Masonry
//
//  Created by Jonas Budelmann on 20/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "XYMASConstraintMaker.h"
#import "XYMASViewConstraint.h"
#import "XYMASCompositeConstraint.h"
#import "MASConstraint+XYPrivate.h"
#import "XYMASViewAttribute.h"
#import "View+XYMASAdditions.h"

@interface XYMASConstraintMaker () <MASConstraintDelegate>

@property (nonatomic, weak) MAS_VIEW *view;
@property (nonatomic, strong) NSMutableArray *constraints;

@end

@implementation XYMASConstraintMaker

- (id)initWithView:(MAS_VIEW *)view {
    self = [super init];
    if (!self) return nil;
    
    self.view = view;
    self.constraints = NSMutableArray.new;
    
    return self;
}

- (NSArray *)install {
    if (self.removeExisting) {
        NSArray *installedConstraints = [XYMASViewConstraint installedConstraintsForView:self.view];
        for (XYMASConstraint *constraint in installedConstraints) {
            [constraint uninstall];
        }
    }
    NSArray *constraints = self.constraints.copy;
    for (XYMASConstraint *constraint in constraints) {
        constraint.updateExisting = self.updateExisting;
        [constraint install];
    }
    [self.constraints removeAllObjects];
    return constraints;
}

#pragma mark - MASConstraintDelegate

- (void)constraint:(XYMASConstraint *)constraint shouldBeReplacedWithConstraint:(XYMASConstraint *)replacementConstraint {
    NSUInteger index = [self.constraints indexOfObject:constraint];
    NSAssert(index != NSNotFound, @"Could not find constraint %@", constraint);
    [self.constraints replaceObjectAtIndex:index withObject:replacementConstraint];
}

- (XYMASConstraint *)constraint:(XYMASConstraint *)constraint addConstraintWithLayoutAttribute:(NSLayoutAttribute)layoutAttribute {
    XYMASViewAttribute *viewAttribute = [[XYMASViewAttribute alloc] initWithView:self.view layoutAttribute:layoutAttribute];
    XYMASViewConstraint *newConstraint = [[XYMASViewConstraint alloc] initWithFirstViewAttribute:viewAttribute];
    if ([constraint isKindOfClass:XYMASViewConstraint.class]) {
        //replace with composite constraint
        NSArray *children = @[constraint, newConstraint];
        XYMASCompositeConstraint *compositeConstraint = [[XYMASCompositeConstraint alloc] initWithChildren:children];
        compositeConstraint.delegate = self;
        [self constraint:constraint shouldBeReplacedWithConstraint:compositeConstraint];
        return compositeConstraint;
    }
    if (!constraint) {
        newConstraint.delegate = self;
        [self.constraints addObject:newConstraint];
    }
    return newConstraint;
}

- (XYMASConstraint *)addConstraintWithAttributes:(MASAttribute)attrs {
    __unused MASAttribute anyAttribute = (MASAttributeLeft | MASAttributeRight | MASAttributeTop | MASAttributeBottom | MASAttributeLeading
                                          | MASAttributeTrailing | MASAttributeWidth | MASAttributeHeight | MASAttributeCenterX
                                          | MASAttributeCenterY | MASAttributeBaseline
#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000) || (__MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)
                                          | MASAttributeFirstBaseline | MASAttributeLastBaseline
#endif
#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000)
                                          | MASAttributeLeftMargin | MASAttributeRightMargin | MASAttributeTopMargin | MASAttributeBottomMargin
                                          | MASAttributeLeadingMargin | MASAttributeTrailingMargin | MASAttributeCenterXWithinMargins
                                          | MASAttributeCenterYWithinMargins
#endif
                                          );
    
    NSAssert((attrs & anyAttribute) != 0, @"You didn't pass any attribute to make.attributes(...)");
    
    NSMutableArray *attributes = [NSMutableArray array];
    
    if (attrs & MASAttributeLeft) [attributes addObject:self.view.mas_left];
    if (attrs & MASAttributeRight) [attributes addObject:self.view.mas_right];
    if (attrs & MASAttributeTop) [attributes addObject:self.view.mas_top];
    if (attrs & MASAttributeBottom) [attributes addObject:self.view.mas_bottom];
    if (attrs & MASAttributeLeading) [attributes addObject:self.view.mas_leading];
    if (attrs & MASAttributeTrailing) [attributes addObject:self.view.mas_trailing];
    if (attrs & MASAttributeWidth) [attributes addObject:self.view.mas_width];
    if (attrs & MASAttributeHeight) [attributes addObject:self.view.mas_height];
    if (attrs & MASAttributeCenterX) [attributes addObject:self.view.mas_centerX];
    if (attrs & MASAttributeCenterY) [attributes addObject:self.view.mas_centerY];
    if (attrs & MASAttributeBaseline) [attributes addObject:self.view.mas_baseline];
    
#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000) || (__MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)
    
    if (attrs & MASAttributeFirstBaseline) [attributes addObject:self.view.mas_firstBaseline];
    if (attrs & MASAttributeLastBaseline) [attributes addObject:self.view.mas_lastBaseline];
    
#endif
    
#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000)
    
    if (attrs & MASAttributeLeftMargin) [attributes addObject:self.view.mas_leftMargin];
    if (attrs & MASAttributeRightMargin) [attributes addObject:self.view.mas_rightMargin];
    if (attrs & MASAttributeTopMargin) [attributes addObject:self.view.mas_topMargin];
    if (attrs & MASAttributeBottomMargin) [attributes addObject:self.view.mas_bottomMargin];
    if (attrs & MASAttributeLeadingMargin) [attributes addObject:self.view.mas_leadingMargin];
    if (attrs & MASAttributeTrailingMargin) [attributes addObject:self.view.mas_trailingMargin];
    if (attrs & MASAttributeCenterXWithinMargins) [attributes addObject:self.view.mas_centerXWithinMargins];
    if (attrs & MASAttributeCenterYWithinMargins) [attributes addObject:self.view.mas_centerYWithinMargins];
    
#endif
    
    NSMutableArray *children = [NSMutableArray arrayWithCapacity:attributes.count];
    
    for (XYMASViewAttribute *a in attributes) {
        [children addObject:[[XYMASViewConstraint alloc] initWithFirstViewAttribute:a]];
    }
    
    XYMASCompositeConstraint *constraint = [[XYMASCompositeConstraint alloc] initWithChildren:children];
    constraint.delegate = self;
    [self.constraints addObject:constraint];
    return constraint;
}

#pragma mark - standard Attributes

- (XYMASConstraint *)addConstraintWithLayoutAttribute:(NSLayoutAttribute)layoutAttribute {
    return [self constraint:nil addConstraintWithLayoutAttribute:layoutAttribute];
}

- (XYMASConstraint *)left {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeLeft];
}

- (XYMASConstraint *)top {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeTop];
}

- (XYMASConstraint *)right {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeRight];
}

- (XYMASConstraint *)bottom {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeBottom];
}

- (XYMASConstraint *)leading {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeLeading];
}

- (XYMASConstraint *)trailing {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeTrailing];
}

- (XYMASConstraint *)width {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeWidth];
}

- (XYMASConstraint *)height {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeHeight];
}

- (XYMASConstraint *)centerX {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeCenterX];
}

- (XYMASConstraint *)centerY {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeCenterY];
}

- (XYMASConstraint *)baseline {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeBaseline];
}

- (XYMASConstraint *(^)(MASAttribute))attributes {
    return ^(MASAttribute attrs){
        return [self addConstraintWithAttributes:attrs];
    };
}

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000) || (__MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)

- (XYMASConstraint *)firstBaseline {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeFirstBaseline];
}

- (XYMASConstraint *)lastBaseline {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeLastBaseline];
}

#endif


#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000)

- (XYMASConstraint *)leftMargin {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeLeftMargin];
}

- (XYMASConstraint *)rightMargin {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeRightMargin];
}

- (XYMASConstraint *)topMargin {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeTopMargin];
}

- (XYMASConstraint *)bottomMargin {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeBottomMargin];
}

- (XYMASConstraint *)leadingMargin {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeLeadingMargin];
}

- (XYMASConstraint *)trailingMargin {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeTrailingMargin];
}

- (XYMASConstraint *)centerXWithinMargins {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeCenterXWithinMargins];
}

- (XYMASConstraint *)centerYWithinMargins {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeCenterYWithinMargins];
}

#endif


#pragma mark - composite Attributes

- (XYMASConstraint *)edges {
    return [self addConstraintWithAttributes:MASAttributeTop | MASAttributeLeft | MASAttributeRight | MASAttributeBottom];
}

- (XYMASConstraint *)size {
    return [self addConstraintWithAttributes:MASAttributeWidth | MASAttributeHeight];
}

- (XYMASConstraint *)center {
    return [self addConstraintWithAttributes:MASAttributeCenterX | MASAttributeCenterY];
}

#pragma mark - grouping

- (XYMASConstraint *(^)(dispatch_block_t group))group {
    return ^id(dispatch_block_t group) {
        NSInteger previousCount = self.constraints.count;
        group();

        NSArray *children = [self.constraints subarrayWithRange:NSMakeRange(previousCount, self.constraints.count - previousCount)];
        XYMASCompositeConstraint *constraint = [[XYMASCompositeConstraint alloc] initWithChildren:children];
        constraint.delegate = self;
        return constraint;
    };
}

@end
