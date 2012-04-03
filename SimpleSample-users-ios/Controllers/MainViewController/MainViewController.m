//
//  MainViewController.m
//  SimpleSample-users-ios
//
//  Created by Alexey Voitenko on 24.02.12.
//  Copyright (c) 2012 QuickBlox. All rights reserved.
//

#import "MainViewController.h"

@implementation MainViewController

@synthesize loginController;
@synthesize registrationController;
@synthesize currentUser = _currentUser;
@synthesize textField;
@synthesize users, myTableView, _cell, logout, signIn, editController, detailsController, edit;

- (void)dealloc
{
    [edit release];
    [detailsController release];
    [editController release];
    [logout release];
    [signIn release];
    [_cell release];
    [myTableView release];
    [textField release];
    [loginController release];
    [registrationController release];
    [_currentUser release];
    [users release];
    [super dealloc];
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self){
        // users container
        users = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // retrieve users
    [self retrieveUsers];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [textField resignFirstResponder];
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

// Retrieve QuickBlox Users
- (void) retrieveUsers{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    // retrieve 50 users
    PagedRequest* request = [[PagedRequest alloc] init];
    request.perPage = 50;
	[QBUsersService getUsersWithPagedRequest:request delegate:self];
	[request release];
}

// QuickBlox API queries delegate
- (void)completedWithResult:(Result *)result
{
    // Retrieve Users result
    if([result isKindOfClass:[QBUUserPagedResult class]])
    {
        // Success result
        if (result.success)
        {
            // update table
            QBUUserPagedResult *usersSearchRes = (QBUUserPagedResult *)result;
            [users removeAllObjects];
            [users addObjectsFromArray:usersSearchRes.users];
            [myTableView reloadData];
        
        // Errors
        }else{
            NSLog(@"Errors=%@", result.errors); 
        }
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
    // Search User result
    } else if([result isKindOfClass:[QBUUserResult class]])
    {
        // Success result
        if (result.success)
        {
            // update table
            QBUUserResult *userSearchRes = (QBUUserResult *)result;
            [users removeAllObjects];
            [users addObject:userSearchRes.user];
            [myTableView reloadData];
        
        // Errors
        }else{
            NSLog(@"Errors=%@", result.errors); 
        }
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    // User logout result
    }else if([result isKindOfClass:[QBUUserLogoutResult class]])
    {
        // Success result
        if (result.success)
        {
            logout.hidden = YES;
            signIn.hidden = NO;
            edit.hidden = YES;
        // Errors
        }else{
            NSLog(@"Errors=%@", result.errors); 
        }
    }
}


#pragma mark -
#pragma mark TableViewDataSource & TableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [textField resignFirstResponder];
    
    // show user details
    detailsController.choosedUser = [users objectAtIndex:[indexPath row]];
    [self presentModalViewController:detailsController animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.users count];
}

// Making table view using custom cells 
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* SimpleTableIdentifier = @"SimpleTableIdentifier";
    
    CustomTableViewCellCell* cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
    if (cell == nil)
    {
        [[NSBundle mainBundle] loadNibNamed:@"CustomTableViewCell" owner:self options:nil];
        cell = _cell;
    }
    QBUUser* obtainedUser = [users objectAtIndex:[indexPath row]];
    
    cell.userLogin.text = obtainedUser.login;
    cell.userName.text = obtainedUser.fullName;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 66;
}

// Search for user by login
- (IBAction) search:(id)sender
{
    [textField resignFirstResponder];

    if ([textField.text length] != 0)
    {
        // search user by login
        [QBUsersService getUserWithLogin:textField.text delegate:self]; 
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    }
}

// User Sign In
- (IBAction)signIn:(id)sender
{
    // show User Sign In controller
    loginController.mainController = self;
    [self presentModalViewController:loginController animated:YES];
}

// User Sign Up
- (IBAction) signUp:(id)sender
{
    // show User Sign Up controller
    [self presentModalViewController:(UIViewController *)registrationController animated:YES];
}

// Logout User
- (IBAction)logout:(id)sender
{
    self.currentUser = nil;
    
    // logout user
    [QBUsersService logoutUser:self];
}

- (IBAction)edit:(id)sender
{
    editController.mainController = self;
    [self presentModalViewController:editController animated:YES];
}

- (IBAction)clear:(id)sender
{
    textField.text = nil; 
    
    // retrieve users
    [self retrieveUsers];
}


#pragma mark -
#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)_textField
{
    [_textField resignFirstResponder];
    return YES;
}

- (void)textFieldDoneEditing:(id)sender
{
    [sender resignFirstResponder];
}


#pragma mark -

-(void)dismissKeyboard
{
    [textField resignFirstResponder];
}

@end
