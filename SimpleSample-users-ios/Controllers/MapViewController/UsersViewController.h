//
//  MapViewController.h
//  SimpleSample-users-ios
//
//  Created by Alexey Voitenko on 24.02.12.
//  Copyright (c) 2012 QuickBlox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapKit/MapKit.h"
#import "DetailsViewController.h"
#import "LoginViewController.h"
#import "EditViewController.h"
#import "CustomTableViewCellCell.h"

@class DetailsViewController;
@class EditViewController;
@class LoginViewController;
@class RegistrationViewController;

@interface UsersViewController : UIViewController <ActionStatusDelegate, UITextFieldDelegate,UITableViewDelegate, UITableViewDataSource> 
{
}

@property (nonatomic, retain) IBOutlet LoginViewController *loginController;
@property (nonatomic, retain) IBOutlet RegistrationViewController *registrationController;
@property (nonatomic, retain) IBOutlet EditViewController *editController;
@property (nonatomic, retain) IBOutlet DetailsViewController *detailsController;

@property (nonatomic, retain) IBOutlet CustomTableViewCellCell* _cell;

@property (nonatomic, retain) QBUUser *currentUser;

@property (nonatomic, assign) NSMutableArray* users;

@property (nonatomic, retain) IBOutlet UITextField* textField;
@property (nonatomic, retain) IBOutlet UITableView* myTableView;
@property (nonatomic, retain) IBOutlet UIButton* signIn;
@property (nonatomic, retain) IBOutlet UIButton* logout;
@property (nonatomic, retain) IBOutlet UIButton* edit;

- (IBAction) search: (id)sender;
- (void) retrieveUsers;
- (IBAction)textFieldDoneEditing:(id)sender;
- (IBAction) signIn:(id)sender;
- (IBAction) signUp:(id)sender;
- (IBAction) edit:(id)sender;
- (IBAction) logout:(id)sender;
- (IBAction) clear:(id)sender;

@end
