//
//  SplashController.h
//  SimpleSample-users-ios
//
//  Created by Danil on 04.10.11.
//  Copyright 2011 QuickBlox. All rights reserved.
//

#import "UsersViewController.h"

@class UsersViewController;

@interface SplashController : UIViewController <ActionStatusDelegate>{

    UIActivityIndicatorView *wheel;
    
}
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *wheel;

- (void)hideSplash;

@end