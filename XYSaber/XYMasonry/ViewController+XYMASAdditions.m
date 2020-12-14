//
//  UIViewController+MASAdditions.m
//  Masonry
//
//  Created by Craig Siemens on 2015-06-23.
//
//

#import "ViewController+XYMASAdditions.h"

#ifdef MAS_VIEW_CONTROLLER

@implementation MAS_VIEW_CONTROLLER (XYMASAdditions)

- (XYMASViewAttribute *)mas_topLayoutGuide {
    return [[XYMASViewAttribute alloc] initWithView:self.view item:self.topLayoutGuide layoutAttribute:NSLayoutAttributeBottom];
}
- (XYMASViewAttribute *)mas_topLayoutGuideTop {
    return [[XYMASViewAttribute alloc] initWithView:self.view item:self.topLayoutGuide layoutAttribute:NSLayoutAttributeTop];
}
- (XYMASViewAttribute *)mas_topLayoutGuideBottom {
    return [[XYMASViewAttribute alloc] initWithView:self.view item:self.topLayoutGuide layoutAttribute:NSLayoutAttributeBottom];
}

- (XYMASViewAttribute *)mas_bottomLayoutGuide {
    return [[XYMASViewAttribute alloc] initWithView:self.view item:self.bottomLayoutGuide layoutAttribute:NSLayoutAttributeTop];
}
- (XYMASViewAttribute *)mas_bottomLayoutGuideTop {
    return [[XYMASViewAttribute alloc] initWithView:self.view item:self.bottomLayoutGuide layoutAttribute:NSLayoutAttributeTop];
}
- (XYMASViewAttribute *)mas_bottomLayoutGuideBottom {
    return [[XYMASViewAttribute alloc] initWithView:self.view item:self.bottomLayoutGuide layoutAttribute:NSLayoutAttributeBottom];
}



@end

#endif
