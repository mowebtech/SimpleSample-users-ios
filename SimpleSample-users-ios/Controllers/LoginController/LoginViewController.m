//
//  LoginViewController.m
//  SimpleSample-users-ios
//
//  Created by Igor Khomenko on 04.10.11.
//  Copyright 2011 QuickBlox. All rights reserved.
//

#import "LoginViewController.h"
#import "UsersViewController.h"


@implementation LoginViewController
@synthesize login;
@synthesize password;
@synthesize activityIndicator;
@synthesize mainController;


- (void)dealloc
{
    [login release];
    [password release];
    [activityIndicator release];
    [super dealloc];
}

- (void)viewDidUnload
{
    [self setLogin:nil];
    [self setPassword:nil];
    [self setActivityIndicator:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

// User Sign In
- (IBAction)next:(id)sender
{
    // Create QuickBlox User entity
    QBUUser *qbUser = [[QBUUser alloc] init];
    qbUser.ownerID = ownerID;        
    qbUser.login = login.text;
	qbUser.password = password.text;
    
    // Authenticate user
    [QBUsersService authenticateUser:qbUser delegate:self];
    
    [qbUser release];
    
    [activityIndicator startAnimating];
}

- (IBAction)back:(id)sender 
{
    [self dismissModalViewControllerAnimated:YES];
}


#pragma mark -
#pragma mark ActionStatusDelegate

// QuickBlox API queries delegate
-(void)completedWithResult:(Result *)result{
    
    // QuickBlox User authenticate result
    if([result isKindOfClass:[QBUUserAuthenticateResult class]]){
		
        // Success result
        if(result.success){
            
            QBUUserAuthenticateResult *res = (QBUUserAuthenticateResult *)result;
            
            // save current user
            mainController.currentUser = res.user;
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Authentification successful" message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [alert show];
            [alert release];
            
            mainController.signIn.hidden = YES;
            mainController.logout.hidden = NO;
            mainController.edit.hidden = NO;
		
        // Errors
        }else if(401 == result.status){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Authentification unsuccessful. Not registered." message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [alert show];
            [alert release];
           
        }else{
            NSLog(@"Errors=%@", result.errors);
        }
    }
    
    [activityIndicator stopAnimating];
}


#pragma mark -
#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)_textField
{
    [_textField resignFirstResponder];
    [self next:nil];
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [password resignFirstResponder];
    [login resignFirstResponder];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self dismissModalViewControllerAnimated:YES];
}

@end