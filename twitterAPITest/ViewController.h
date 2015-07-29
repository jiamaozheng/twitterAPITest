//
//  ViewController.h
//  twitterAPITest
//
//  Created by Jiamao Zheng on 7/29/15.
//  Copyright (c) 2015 Emerge Media. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TwitterKit/TwitterKit.h>
#import <DigitsKit/DigitsKit.h>
#import <LIALinkedInApplication.h>
#import <LIALinkedInAuthorizationViewController.h>
#import <LIALinkedInHttpClient.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *authenticateButton;
@property (weak, nonatomic) IBOutlet UIButton *logInButton;
@property (weak, nonatomic) IBOutlet UIButton *linkedin;

@property NSUInteger tabIndex;
@property (nonatomic, strong) LIALinkedInHttpClient *client;

- (void)requestMeWithToken:(NSString *)accessToken;
- (IBAction)connectWithLinkedIn:(id)sender;

@end

