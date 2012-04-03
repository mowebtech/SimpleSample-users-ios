//
//  DetailsViewController.h
//  SimpleSample-users-ios
//
//  Created by Alexey Voitenko on 13.03.12.
//  Copyright (c) 2012 QuickBlox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UsersViewController.h"

@interface DetailsViewController : UIViewController
{
    UILabel* createdLabel;
    UILabel* loginLabel;
    UILabel* fullNameLabel;
    UILabel* phoneLabel;
    UILabel* emailLabel;
    UILabel* websiteLabel;
    QBUUser* choosedUser;
}
@property (nonatomic, retain) IBOutlet UILabel* createdLabel;
@property (nonatomic, retain) IBOutlet UILabel* loginLabel;
@property (nonatomic, retain) IBOutlet UILabel* fullNameLabel;
@property (nonatomic, retain) IBOutlet UILabel* phoneLabel;
@property (nonatomic, retain) IBOutlet UILabel* emailLabel;
@property (nonatomic, retain) IBOutlet UILabel* websiteLabel;

@property (nonatomic, retain) QBUUser* choosedUser;


- (IBAction)back:(id)sender;

@end
