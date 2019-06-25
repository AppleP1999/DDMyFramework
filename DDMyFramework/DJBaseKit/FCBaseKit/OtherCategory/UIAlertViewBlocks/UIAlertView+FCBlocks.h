//
//  UIAlertView+FCBlocks.h
//  Shibui
//
//  Created by Jiva DeVoe on 12/28/10.
//  Copyright 2010 Random Ideas, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FCButtonItem;
@interface UIAlertView (FCBlocks)

- (id)initWithTitle:(NSString *)inTitle message:(NSString *)inMessage cancelButtonItem:(FCButtonItem *)inCancelButtonItem otherButtonItems:(FCButtonItem *)inOtherButtonItems, ... NS_REQUIRES_NIL_TERMINATION;

- (NSInteger)addButtonItem:(FCButtonItem *)item;

@end
