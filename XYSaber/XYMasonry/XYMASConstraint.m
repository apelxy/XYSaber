//
//  MASConstraint.m
//  Masonry
//
//  Created by Nick Tymchenko on 1/20/14.
//

#import "XYMASConstraint.h"
#import "MASConstraint+XYPrivate.h"

#define MASMethodNotImplemented() \
    @throw [NSException exceptionWithName:NSInternalInconsistencyException \
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass.", NSStringFromSelector(_cmd)] \
                                 userInfo:nil]

@implementation XYMASConstraint

#pragma mark - Init

- (id)init {
	NSAssert(![self isMemberOfClass:[XYMASConstraint class]], @"MASConstraint is an abstract class, you should not instantiate it directly.");
	return [super init];
}

#pragma mark - NSLayoutRelation proxies

- (XYMASConstraint * (^)(id))equalTo {
    return ^id(id attribute) {
        return self.equalToWithRelation(attribute, NSLayoutRelationEqual);
    };
}

- (XYMASConstraint * (^)(id))mas_equalTo {
    return ^id(id attribute) {
        return self.equalToWithRelation(attribute, NSLayoutRelationEqual);
    };
}

- (XYMASConstraint * (^)(id))greaterThanOrEqualTo {
    return ^id(id attribute) {
        return self.equalToWithRelation(attribute, NSLayoutRelationGreaterThanOrEqual);
    };
}

- (XYMASConstraint * (^)(id))mas_greaterThanOrEqualTo {
    return ^id(id attribute) {
        return self.equalToWithRelation(attribute, NSLayoutRelationGreaterThanOrEqual);
    };
}

- (XYMASConstraint * (^)(id))lessThanOrEqualTo {
    return ^id(id attribute) {
        return self.equalToWithRelation(attribute, NSLayoutRelationLessThanOrEqual);
    };
}

- (XYMASConstraint * (^)(id))mas_lessThanOrEqualTo {
    return ^id(id attribute) {
        return self.equalToWithRelation(attribute, NSLayoutRelationLessThanOrEqual);
    };
}

#pragma mark - MASLayoutPriority proxies

- (XYMASConstraint * (^)(void))priorityLow {
    return ^id{
        self.priority(MASLayoutPriorityDefaultLow);
        return self;
    };
}

- (XYMASConstraint * (^)(void))priorityMedium {
    return ^id{
        self.priority(MASLayoutPriorityDefaultMedium);
        return self;
    };
}

- (XYMASConstraint * (^)(void))priorityHigh {
    return ^id{
        self.priority(MASLayoutPriorityDefaultHigh);
        return self;
    };
}

#pragma mark - NSLayoutConstraint constant proxies

- (XYMASConstraint * (^)(MASEdgeInsets))insets {
    return ^id(MASEdgeInsets insets){
        self.insets = insets;
        return self;
    };
}

- (XYMASConstraint * (^)(CGFloat))inset {
    return ^id(CGFloat inset){
        self.inset = inset;
        return self;
    };
}

- (XYMASConstraint * (^)(CGSize))sizeOffset {
    return ^id(CGSize offset) {
        self.sizeOffset = offset;
        return self;
    };
}

- (XYMASConstraint * (^)(CGPoint))centerOffset {
    return ^id(CGPoint offset) {
        self.centerOffset = offset;
        return self;
    };
}

- (XYMASConstraint * (^)(CGFloat))offset {
    return ^id(CGFloat offset){
        self.offset = offset;
        return self;
    };
}

- (XYMASConstraint * (^)(NSValue *value))valueOffset {
    return ^id(NSValue *offset) {
        NSAssert([offset isKindOfClass:NSValue.class], @"expected an NSValue offset, got: %@", offset);
        [self setLayoutConstantWithValue:offset];
        return self;
    };
}

- (XYMASConstraint * (^)(id offset))mas_offset {
    // Will never be called due to macro
    return nil;
}

#pragma mark - NSLayoutConstraint constant setter

- (void)setLayoutConstantWithValue:(NSValue *)value {
    if ([value isKindOfClass:NSNumber.class]) {
        self.offset = [(NSNumber *)value doubleValue];
    } else if (strcmp(value.objCType, @encode(CGPoint)) == 0) {
        CGPoint point;
        [value getValue:&point];
        self.centerOffset = point;
    } else if (strcmp(value.objCType, @encode(CGSize)) == 0) {
        CGSize size;
        [value getValue:&size];
        self.sizeOffset = size;
    } else if (strcmp(value.objCType, @encode(MASEdgeInsets)) == 0) {
        MASEdgeInsets insets;
        [value getValue:&insets];
        self.insets = insets;
    } else {
        NSAssert(NO, @"attempting to set layout constant with unsupported value: %@", value);
    }
}

#pragma mark - Semantic properties

- (XYMASConstraint *)with {
    return self;
}

- (XYMASConstraint *)and {
    return self;
}

#pragma mark - Chaining

- (XYMASConstraint *)addConstraintWithLayoutAttribute:(NSLayoutAttribute __unused)layoutAttribute {
    MASMethodNotImplemented();
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

#pragma mark - Abstract

- (XYMASConstraint * (^)(CGFloat multiplier))multipliedBy { MASMethodNotImplemented(); }

- (XYMASConstraint * (^)(CGFloat divider))dividedBy { MASMethodNotImplemented(); }

- (XYMASConstraint * (^)(MASLayoutPriority priority))priority { MASMethodNotImplemented(); }

- (XYMASConstraint * (^)(id, NSLayoutRelation))equalToWithRelation { MASMethodNotImplemented(); }

- (XYMASConstraint * (^)(id key))key { MASMethodNotImplemented(); }

- (void)setInsets:(MASEdgeInsets __unused)insets { MASMethodNotImplemented(); }

- (void)setInset:(CGFloat __unused)inset { MASMethodNotImplemented(); }

- (void)setSizeOffset:(CGSize __unused)sizeOffset { MASMethodNotImplemented(); }

- (void)setCenterOffset:(CGPoint __unused)centerOffset { MASMethodNotImplemented(); }

- (void)setOffset:(CGFloat __unused)offset { MASMethodNotImplemented(); }

#if TARGET_OS_MAC && !(TARGET_OS_IPHONE || TARGET_OS_TV)

- (XYMASConstraint *)animator { MASMethodNotImplemented(); }

#endif

- (void)activate { MASMethodNotImplemented(); }

- (void)deactivate { MASMethodNotImplemented(); }

- (void)install { MASMethodNotImplemented(); }

- (void)uninstall { MASMethodNotImplemented(); }

@end
