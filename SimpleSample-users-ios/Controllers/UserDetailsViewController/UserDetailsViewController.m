//
//  UserDetailsViewController.m
//  SimpleSample-users-ios
//
//  Created by Alexey Voitenko on 13.03.12.
//  Copyright (c) 2012 QuickBlox. All rights reserved.
//

#import "UserDetailsViewController.h"

@interface UserDetailsViewController ()

@end

@implementation UserDetailsViewController

@synthesize createdLabel;
@synthesize loginLabel;
@synthesize fullNameLabel;
@synthesize phoneLabel;
@synthesize emailLabel;
@synthesize websiteLabel;
@synthesize choosedUser;

-(void)dealloc
{
    [choosedUser release];
    [createdLabel release];
    [loginLabel release];
    [fullNameLabel release];
    [phoneLabel release];
    [emailLabel release];
    [websiteLabel release];
    [super dealloc];
}

- (IBAction)back:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
    fullNameLabel.alpha = 1;
    phoneLabel.alpha = 1;
    emailLabel.alpha = 1;
    websiteLabel.alpha = 1;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    // Show User's details
    loginLabel.text = choosedUser.login;
    createdLabel.text = [choosedUser.createdAt description];
    
    fullNameLabel.text = choosedUser.fullName;
    phoneLabel.text = choosedUser.phone;
    emailLabel.text = choosedUser.email;
    websiteLabel.text = choosedUser.website;
    
    if ([choosedUser.fullName length] == 0) 
    {
        fullNameLabel.text = @"empty"; 
        fullNameLabel.alpha = 0.3;
    }
    if ([choosedUser.phone length] == 0) 
    {
        phoneLabel.text = @"empty"; 
        phoneLabel.alpha = 0.3;
    }
    if ([choosedUser.email length] == 0) 
    {
        emailLabel.text = @"empty"; 
        emailLabel.alpha = 0.3;
    }
    if ([choosedUser.website length] == 0) 
    {
        websiteLabel.text = @"empty"; 
        websiteLabel.alpha = 0.3;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
