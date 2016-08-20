//
//  ViewController.m
//  Universal Alert
//
//  Created by Richard Stockdale on 20/08/2016.
//  Copyright © 2016 Junction Seven. All rights reserved.
//

#import "ViewController.h"
#import "UniversalAlert.h"

@interface ViewController ()

@property (nonatomic, strong) UniversalAlert *alert;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.alert = [[UniversalAlert alloc] init];
    [self.alert simpleAlertViewControllerWithTitle:@"Example"
                                           message:@"Some alert view or controller"
                                      buttonTitles:@[@"Cancel", @"Ok"]
                                hostViewController:self
                                  selectionHandler:^(NSInteger selectedItemIndex) {
                                      [self.alert dismiss];
                                  }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
