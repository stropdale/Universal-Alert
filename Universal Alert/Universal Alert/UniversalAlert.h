//
//  UniversalAlert.h
//  Universal Alert
//
//  Created by Richard Stockdale on 20/08/2016.
//  Copyright © 2016 Junction Seven. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UniversalAlert : NSObject <UIAlertViewDelegate>

typedef void (^SelectionBlock)(NSInteger selectedItemIndex);

/**
 *  Creates and displays a simple alert. For iOS7, this will be a UIAlertView. For iOS 8 and above a UIAlertController will be used.
 *
 *  @param title          NSString The title of the alert
 *  @param message        NSString The message contained in the body of the alert
 *  @param buttonTitles   NSArray of NSStrings The titles of the buttons. The first item in the array will be the cancel button
 *  @param viewController UIViewController The view controller the alert will be shown within
 *  @param selection      Block A block called when a user makes a selection. Contains the selection index. NOTE: Always call the dismiss method in this block.
 */
- (void) simpleAlertViewControllerWithTitle: (NSString *) title
                                    message: (NSString *) message
                               buttonTitles: (NSArray <NSString *> *) buttonTitles
                         hostViewController: (UIViewController *) viewController
                           selectionHandler: (SelectionBlock) selection;

/**
 *  Dismissed the Alert if there are no buttons, but should always be called in the selection completion block.
 */
- (void) dismiss;


@end
