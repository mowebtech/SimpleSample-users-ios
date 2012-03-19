//
//  MapViewController.h
//  SimpleSample-users-ios
//
//  Created by Alexey Voitenko on 24.02.12.
//  Copyright (c) 2012 Injoit Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapKit/MapKit.h"
#import "CustomTableViewCellCell.h"
#import "DetailsViewController.h"
#import "EditViewController.h"
#import "LoginViewController.h"
#import "SplashController.h"

@class DetailsViewController;
@class EditViewController;
@class LoginViewController;
@class SplashController;

@interface UsersViewController : UIViewController <ActionStatusDelegate, UITextFieldDelegate,UITableViewDelegate, UITableViewDataSource> 
{
    UIViewController *registrationController;
    DetailsViewController *detailsController;
    IBOutlet CustomTableViewCellCell* _cell;
    LoginViewController *loginController;
    EditViewController *editController;
    UITableView* myTableView;
    UITextField* textField;
    QBUUser *currentUser;
    UIButton* signIn;
    UIButton* logout;
    UIButton* edit;
}

@property (nonatomic, retain) IBOutlet LoginViewController *loginController;
@property (nonatomic, retain) IBOutlet UIViewController *registrationController;
@property (nonatomic, retain) QBUUser *currentUser;
@property (nonatomic, retain) IBOutlet UITextField* textField;
@property (nonatomic, retain) IBOutlet UITableView* myTableView;
@property (nonatomic, retain) IBOutlet CustomTableViewCellCell* _cell;
@property (nonatomic, assign) NSMutableArray* messages;
@property (nonatomic, retain) IBOutlet UIButton* signIn;
@property (nonatomic, retain) IBOutlet UIButton* logout;
@property (nonatomic, retain) IBOutlet EditViewController *editController;
@property (nonatomic, retain) IBOutlet DetailsViewController *detailsController;
@property (nonatomic, retain) IBOutlet UIButton* edit;

- (IBAction) search: (id)sender;
- (void) searchUsersData:(NSTimer *) timer;
- (IBAction)textFieldDoneEditing:(id)sender;
- (IBAction) signIn:(id)sender;
- (IBAction) signUp:(id)sender;
- (IBAction) edit:(id)sender;
- (IBAction) logout:(id)sender;
- (IBAction) clear:(id)sender;

@end
