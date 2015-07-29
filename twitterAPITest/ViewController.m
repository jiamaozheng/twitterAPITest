//
//  ViewController.m
//  twitterAPITest
//
//  Created by Jiamao Zheng on 7/29/15.
//  Copyright (c) 2015 Emerge Media. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    self.logInButton = [TWTRLogInButton buttonWithLogInCompletion:^(TWTRSession *session, NSError *error) {
//        if (session) {
//            NSLog(@"signed in as %@", [session userName]);
//        } else {
//            NSLog(@"error: %@", [error localizedDescription]);
//        }
//
//    }];
//
//    
//    self.authenticateButton = [DGTAuthenticateButton buttonWithAuthenticationCompletion:^(DGTSession *session, NSError *error) {
//        // play with Digits session
//    }];


    
    TWTRLogInButton* logInButton = [TWTRLogInButton buttonWithLogInCompletion:^(TWTRSession* session, NSError* error) {
        if (session) {
            NSLog(@"signed in as %@", [session userName]);
        } else {
            NSLog(@"error: %@", [error localizedDescription]);
        }
    }];
    logInButton.alpha = 0.02;
    logInButton.frame = self.logInButton.frame;
    [self.view addSubview:logInButton];
    
    
    DGTAuthenticateButton *authenticateButton = [DGTAuthenticateButton buttonWithAuthenticationCompletion:^(DGTSession *session, NSError *error) {
        if (session) {
            NSLog(@"signed in as %@", [session phoneNumber]);
        } else {
            NSLog(@"error: %@", [error localizedDescription]);
        }
    }];
    authenticateButton.alpha = 0.02;
    authenticateButton.frame = self.authenticateButton.frame;
    [self.view addSubview:authenticateButton];


    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
