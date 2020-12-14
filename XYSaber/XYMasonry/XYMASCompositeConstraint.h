//
//  MASCompositeConstraint.h
//  Masonry
//
//  Created by Jonas Budelmann on 21/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "XYMASConstraint.h"
#import "XYMASUtilities.h"

/**
 *	A group of MASConstraint objects
 */
@interface XYMASCompositeConstraint : XYMASConstraint

/**
 *	Creates a composite with a predefined array of children
 *
 *	@param	children	child MASConstraints
 *
 *	@return	a composite constraint
 */
- (id)initWithChildren:(NSArray *)children;

@end
