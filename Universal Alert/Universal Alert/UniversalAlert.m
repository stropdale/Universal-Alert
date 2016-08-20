//
//  UniversalAlert.m
//  Universal Alert
//
//  Created by Richard Stockdale on 20/08/2016.
//  Copyright © 2016 Junction Seven. All rights reserved.
//

#import "UniversalAlert.h"


@interface UniversalAlert () {
    
}

@property (nonatomic, strong) SelectionBlock selectionBlock;
@property (nonatomic, strong) UIAlertView *currentAlertView;
@property (strong, nonatomic) UIViewController *hostViewController;
@property (strong, nonatomic) UIAlertController *alertController;

@end

@implementation UniversalAlert

static float ALERT_CONTROLLER_MIN_OS_VERSION = 8.0;

- (void) simpleAlertViewControllerWithTitle: (NSString *) title
                                    message: (NSString *) message
                               buttonTitles: (NSArray <NSString *> *) buttonTitles
                         hostViewController: (UIViewController *) viewController
                           selectionHandler: (SelectionBlock) selection {
    
    self.selectionBlock = [selection copy];
    self.hostViewController = viewController;
    
    if ([[UIDevice currentDevice] systemVersion].floatValue >= ALERT_CONTROLLER_MIN_OS_VERSION) { // Then use UIAlertController
        self.alertController = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
        if (buttonTitles && buttonTitles.count) {
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:buttonTitles.firstObject
                                                                   style:UIAlertActionStyleCancel
                                                                 handler:^(UIAlertAction * _Nonnull action) {
                                                                     self.selectionBlock(0);
                                                                 }];
            [self.alertController addAction:cancelAction];
            
            NSMutableArray *otherButtons = [[NSMutableArray alloc] initWithArray:buttonTitles];
            [otherButtons removeObjectAtIndex:0];
            
            [otherButtons enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                UIAlertAction *otherAction = [UIAlertAction
                                              actionWithTitle:(NSString *) obj
                                              style:UIAlertActionStyleDefault
                                              handler:^(UIAlertAction *action) {
                                                  self.selectionBlock(idx + 1);
                                              }];
                [self.alertController addAction:otherAction];
            }];
        }
        
        [viewController presentViewController:self.alertController animated:YES completion:nil];
    }
    else { // Use UIAlertView
        NSString *cancelButton;
        if (buttonTitles && buttonTitles.count) {
            cancelButton = buttonTitles.firstObject;
        }
        
        self.currentAlertView = [[UIAlertView alloc] initWithTitle:title
                                                           message: message
                                                          delegate:self
                                                 cancelButtonTitle: cancelButton
                                                 otherButtonTitles: nil];
        if (buttonTitles.count > 1) {
            NSMutableArray *otherButtons = [[NSMutableArray alloc] initWithArray:buttonTitles];
            [otherButtons removeObjectAtIndex:0];
            
            for (NSString *buttonTitle in otherButtons) {
                [self.currentAlertView addButtonWithTitle:buttonTitle];
            }
        }
        
        [self.currentAlertView show];
    }
}

- (void) dismiss {
    if (self.currentAlertView) {
        [self.currentAlertView dismissWithClickedButtonIndex:0 animated:YES];
    }
    if (self.alertController) {
        [self.alertController dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - <UIAlertViewDelegate> methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (self.selectionBlock) {
        self.selectionBlock(buttonIndex);
    }
}

@end

