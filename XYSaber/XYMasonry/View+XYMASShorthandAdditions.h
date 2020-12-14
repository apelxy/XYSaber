//
//  UIView+MASShorthandAdditions.h
//  Masonry
//
//  Created by Jonas Budelmann on 22/07/13.
//  Copyright (c) 2013 Jonas Budelmann. All rights reserved.
//

#import "View+XYMASAdditions.h"

#ifdef MAS_SHORTHAND

/**
 *	Shorthand view additions without the 'mas_' prefixes,
 *  only enabled if MAS_SHORTHAND is defined
 */
@interface MAS_VIEW (XYMASShorthandAdditions)

@property (nonatomic, strong, readonly) XYMASViewAttribute *left;
@property (nonatomic, strong, readonly) XYMASViewAttribute *top;
@property (nonatomic, strong, readonly) XYMASViewAttribute *right;
@property (nonatomic, strong, readonly) XYMASViewAttribute *bottom;
@property (nonatomic, strong, readonly) XYMASViewAttribute *leading;
@property (nonatomic, strong, readonly) XYMASViewAttribute *trailing;
@property (nonatomic, strong, readonly) XYMASViewAttribute *width;
@property (nonatomic, strong, readonly) XYMASViewAttribute *height;
@property (nonatomic, strong, readonly) XYMASViewAttribute *centerX;
@property (nonatomic, strong, readonly) XYMASViewAttribute *centerY;
@property (nonatomic, strong, readonly) XYMASViewAttribute *baseline;
@property (nonatomic, strong, readonly) XYMASViewAttribute *(^attribute)(NSLayoutAttribute attr);

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000) || (__MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)

@property (nonatomic, strong, readonly) XYMASViewAttribute *firstBaseline;
@property (nonatomic, strong, readonly) XYMASViewAttribute *lastBaseline;

#endif

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000)

@property (nonatomic, strong, readonly) XYMASViewAttribute *leftMargin;
@property (nonatomic, strong, readonly) XYMASViewAttribute *rightMargin;
@property (nonatomic, strong, readonly) XYMASViewAttribute *topMargin;
@property (nonatomic, strong, readonly) XYMASViewAttribute *bottomMargin;
@property (nonatomic, strong, readonly) XYMASViewAttribute *leadingMargin;
@property (nonatomic, strong, readonly) XYMASViewAttribute *trailingMargin;
@property (nonatomic, strong, readonly) XYMASViewAttribute *centerXWithinMargins;
@property (nonatomic, strong, readonly) XYMASViewAttribute *centerYWithinMargins;

#endif

#if (__IPHONE_OS_VERSION_MAX_ALLOWED >= 110000) || (__TV_OS_VERSION_MAX_ALLOWED >= 110000)

@property (nonatomic, strong, readonly) XYMASViewAttribute *safeAreaLayoutGuideTop API_AVAILABLE(ios(11.0),tvos(11.0));
@property (nonatomic, strong, readonly) XYMASViewAttribute *safeAreaLayoutGuideBottom API_AVAILABLE(ios(11.0),tvos(11.0));
@property (nonatomic, strong, readonly) XYMASViewAttribute *safeAreaLayoutGuideLeft API_AVAILABLE(ios(11.0),tvos(11.0));
@property (nonatomic, strong, readonly) XYMASViewAttribute *safeAreaLayoutGuideRight API_AVAILABLE(ios(11.0),tvos(11.0));

#endif

- (NSArray *)makeConstraints:(void(^)(XYMASConstraintMaker *make))block;
- (NSArray *)updateConstraints:(void(^)(XYMASConstraintMaker *make))block;
- (NSArray *)remakeConstraints:(void(^)(XYMASConstraintMaker *make))block;

@end

#define MAS_ATTR_FORWARD(attr)  \
- (XYMASViewAttribute *)attr {    \
    return [self mas_##attr];   \
}

@implementation MAS_VIEW (XYMASShorthandAdditions)

MAS_ATTR_FORWARD(top);
MAS_ATTR_FORWARD(left);
MAS_ATTR_FORWARD(bottom);
MAS_ATTR_FORWARD(right);
MAS_ATTR_FORWARD(leading);
MAS_ATTR_FORWARD(trailing);
MAS_ATTR_FORWARD(width);
MAS_ATTR_FORWARD(height);
MAS_ATTR_FORWARD(centerX);
MAS_ATTR_FORWARD(centerY);
MAS_ATTR_FORWARD(baseline);

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000) || (__MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)

MAS_ATTR_FORWARD(firstBaseline);
MAS_ATTR_FORWARD(lastBaseline);

#endif

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000)

MAS_ATTR_FORWARD(leftMargin);
MAS_ATTR_FORWARD(rightMargin);
MAS_ATTR_FORWARD(topMargin);
MAS_ATTR_FORWARD(bottomMargin);
MAS_ATTR_FORWARD(leadingMargin);
MAS_ATTR_FORWARD(trailingMargin);
MAS_ATTR_FORWARD(centerXWithinMargins);
MAS_ATTR_FORWARD(centerYWithinMargins);

#endif

#if (__IPHONE_OS_VERSION_MAX_ALLOWED >= 110000) || (__TV_OS_VERSION_MAX_ALLOWED >= 110000)

MAS_ATTR_FORWARD(safeAreaLayoutGuideTop);
MAS_ATTR_FORWARD(safeAreaLayoutGuideBottom);
MAS_ATTR_FORWARD(safeAreaLayoutGuideLeft);
MAS_ATTR_FORWARD(safeAreaLayoutGuideRight);

#endif

- (XYMASViewAttribute *(^)(NSLayoutAttribute))attribute {
    return [self mas_attribute];
}

- (NSArray *)makeConstraints:(void(NS_NOESCAPE ^)(XYMASConstraintMaker *))block {
    return [self mas_makeConstraints:block];
}

- (NSArray *)updateConstraints:(void(NS_NOESCAPE ^)(XYMASConstraintMaker *))block {
    return [self mas_updateConstraints:block];
}

- (NSArray *)remakeConstraints:(void(NS_NOESCAPE ^)(XYMASConstraintMaker *))block {
    return [self mas_remakeConstraints:block];
}

@end

#endif
