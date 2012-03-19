//
//  MapViewController.m
//  SimpleSample-users-ios
//
//  Created by Alexey Voitenko on 24.02.12.
//  Copyright (c) 2012 Injoit Ltd. All rights reserved.
//

#import "UsersViewController.h"
#import "CustomTableViewCellCell.h"
#import "EditViewController.h"


@implementation UsersViewController


@synthesize loginController;
@synthesize registrationController;
@synthesize currentUser = _currentUser;
@synthesize textField;
@synthesize messages, myTableView, _cell, logout, signIn, editController, detailsController, edit;


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
    [currentUser release];
    [messages release];
    [super dealloc];
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        messages = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self searchUsersData:nil];
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


#pragma mark -
#pragma mark GeoData

- (void) searchUsersData:(NSTimer *) timer{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    // retrieve 50 users
    PagedRequest* request = [[PagedRequest alloc] init];
    request.perPage = 50;
	[QBUsersService getUsersWithPagedRequest:request delegate:self];
	[request release];
}

- (void)completedWithResult:(Result *)result
{
    if([result isKindOfClass:[QBUUserPagedResult class]])
    {
        if (result.success)
        {
            QBUUserPagedResult *usersSearchRes = (QBUUserPagedResult *)result;
            [messages removeAllObjects];
            [messages addObjectsFromArray:usersSearchRes.users];
            [myTableView reloadData];
        }
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
    } else if([result isKindOfClass:[QBUUserResult class]])
    {
        if (result.success)
        {
            QBUUserResult *userSearchRes = (QBUUserResult *)result;
            [messages removeAllObjects];
            
            [messages addObject:userSearchRes.user];
            [myTableView reloadData];
        }
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    }else if([result isKindOfClass:[QBUUserLogoutResult class]])
    {
        if (result.success)
        {
            logout.hidden = YES;
            signIn.hidden = NO;
            edit.hidden = YES;
        }
    }
}


#pragma mark -
#pragma mark Table View Data Source Methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [textField resignFirstResponder];
    detailsController.choosedUser = [messages objectAtIndex:[indexPath row]];
    [self presentModalViewController:detailsController animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.messages count];
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
    QBUUser* obtainedUser = [messages objectAtIndex:[indexPath row]];
    
    cell.userLogin.text = obtainedUser.login;
    cell.userName.text = obtainedUser.fullName;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 66;
}

// Search for user with login = textField.text if text not nil and for all users if nil
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

- (IBAction)signIn:(id)sender
{
    loginController.mainController = self;
    [self presentModalViewController:loginController animated:YES];
}

- (IBAction) signUp:(id)sender
{
    [self presentModalViewController:registrationController animated:YES];
}

- (IBAction)logout:(id)sender
{
    currentUser = nil;
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
    
    // retrieve 50 users
    PagedRequest* request = [[PagedRequest alloc] init];
    request.perPage = 50;
    [QBUsersService getUsersWithPagedRequest:request delegate:self];
    [request release];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
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
