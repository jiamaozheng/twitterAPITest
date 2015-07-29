//
//  ViewController.m
//  twitterAPITest
//
//  Created by Jiamao Zheng on 7/29/15.
//  Copyright (c) 2015 Emerge Media. All rights reserved.
//

#import "ViewController.h"
#import <linkedin-sdk/LISDK.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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

    
    
    
    BOOL validSession = [LISDKSessionManager hasValidSession];
    if (validSession) {
     NSLog(@"%s","success");
    } else {
    NSLog(@"%s","failed");
//        self.linkedin.alpha = 0.0;
    }

    
    
    LIALinkedInApplication *application = [LIALinkedInApplication applicationWithRedirectURL:@"http://www.google.com"
                                                                                    clientId:@"w57zqiw6cv73"
                                                                                clientSecret:@"Pj5MVxtkpbefau1v"
                                                                                       state:@"something"
                                                                               grantedAccess:@[@"r_fullprofile", @"r_network"]];
    self.client = [LIALinkedInHttpClient clientForApplication:application presentingViewController:nil];

    

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)connectWithLinkedIn:(id)sender {
//    NSLog(@"%s","sync pressed2");
//    NSArray *permissions = [NSArray arrayWithObjects:LISDK_BASIC_PROFILE_PERMISSION, LISDK_EMAILADDRESS_PERMISSION, nil];
//    [LISDKSessionManager createSessionWithAuth:permissions
//                                         state:@"some state"
//                        showGoToAppStoreDialog:YES
//                                  successBlock:^(NSString *returnState) {
//                                      NSLog(@"returned state %@",returnState);
//                                      self.linkedin.alpha = 0.0;
//                                  }
//                                    errorBlock:^(NSError *error) {
//                                        NSLog(@"%s %@","error called! ", [error description]);
//                                           self.linkedin.alpha = 0.0;
//                                    }
//     ];
    
    [self.client getAuthorizationCode:^(NSString *code) {
        [self.client getAccessToken:code success:^(NSDictionary *accessTokenData) {
            NSString *accessToken = [accessTokenData objectForKey:@"access_token"];
            [self requestMeWithToken:accessToken];
        }                   failure:^(NSError *error) {
            NSLog(@"Quering accessToken failed %@", error);
        }];
    }                      cancel:^{
        NSLog(@"Authorization was cancelled by user");
    }                     failure:^(NSError *error) {
        NSLog(@"Authorization failed %@", error);
    }];
    
}

- (void)requestMeWithToken:(NSString *)accessToken {
    [self.client GET:[NSString stringWithFormat:@"https://api.linkedin.com/v1/people/~?oauth2_access_token=%@&format=json", accessToken] parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *result) {
        NSLog(@"current user %@", result);
    }        failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failed to fetch current user %@", error);
    }];
}

@end
