//
//  EditViewController.h
//  SimpleSample-users-ios
//
//  Created by Alexey Voitenko on 13.03.12.
//  Copyright (c) 2012 QuickBlox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UsersViewController.h"

@class UsersViewController;

@interface EditViewController : UIViewController <ActionStatusDelegate>
{
    UsersViewController* mainController;
    QBUUser* user;
    UITextField* loginField;
    UITextField* fullNameField;
    UITextField* phoneField;
    UITextField* emailField;
    UITextField* websiteField;
}
@property (nonatomic, assign) QBUUser* user;
@property (nonatomic, retain) IBOutlet UITextField* loginField;
@property (nonatomic, retain) IBOutlet UITextField* fullNameField;
@property (nonatomic, retain) IBOutlet UITextField* phoneField;
@property (nonatomic, retain) IBOutlet UITextField* emailField;
@property (nonatomic, retain) IBOutlet UITextField* websiteField;
@property (nonatomic, retain) IBOutlet UsersViewController* mainController;

- (IBAction) update:(id)sender;
- (IBAction) back:(id)sender;
- (IBAction) hideKeyboard:(id)sender;

@end
