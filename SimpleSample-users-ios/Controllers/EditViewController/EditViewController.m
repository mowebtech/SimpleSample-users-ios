//
//  EditViewController.m
//  SimpleSample-users-ios
//
//  Created by Alexey Voitenko on 13.03.12.
//  Copyright (c) 2012 QuickBlox. All rights reserved.
//

#import "EditViewController.h"

@interface EditViewController ()

@end

@implementation EditViewController

@synthesize user, loginField, fullNameField, phoneField, emailField, websiteField, mainController;


-(void)dealloc
{
    [mainController release];
    [loginField release];
    [fullNameField release];
    [phoneField release];
    [emailField release];
    [websiteField release];
    [super dealloc];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [loginField resignFirstResponder];
    [fullNameField resignFirstResponder];
    [phoneField resignFirstResponder];
    [emailField resignFirstResponder];
    [websiteField resignFirstResponder];
}

- (IBAction) hideKeyboard:(id)sender
{
    [sender resignFirstResponder];
}

// QuickBlox API queries delegate
-(void)completedWithResult:(Result *)result
{
    // Edit user result
    if([result isKindOfClass:[QBUUserResult class]])
    {
        // Success result
        if (result.success)
        {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil 
                                                            message:@"User was edit successfully" 
                                                           delegate:nil 
                                                  cancelButtonTitle:@"Ok" 
                                                  otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
            
            mainController.currentUser = user;
        
        // Errors
        }else{
            NSLog(@"Errors=%@", result.errors);
        }
    }
}

// Update user
- (void)update:(id)sender
{
    user = mainController.currentUser;
    
    if ([loginField.text length] != 0) 
    {
        user.login = loginField.text;
    }
    if ([fullNameField.text length] != 0) 
    {
        user.fullName = fullNameField.text;
    }
    if ([phoneField.text length] != 0) 
    {
        user.phone = phoneField.text;
    }
    if ([emailField.text length] != 0) {
        user.email = emailField.text;
    }
    if ([websiteField.text length] != 0) 
    {
        user.website = websiteField.text;
    }
    
    // update user
    [QBUsersService editUser:user delegate:self];
}

- (IBAction)back:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    loginField.text = mainController.currentUser.login;
    fullNameField.text = mainController.currentUser.fullName;
    phoneField.text = mainController.currentUser.phone;
    emailField.text = mainController.currentUser.email;
    websiteField.text = mainController.currentUser.website;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
