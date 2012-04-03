//
//  CustomTableViewCellCell.h
//  SimpleSample-users-ios
//
//  Created by Alexey Voitenko on 07.03.12.
//  Copyright (c) 2012 QuickBlox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCellCell : UITableViewCell
{
    UILabel* userLogin;
    UILabel* userName;
}

@property (nonatomic, retain) IBOutlet UILabel* userLogin;
@property (nonatomic, retain) IBOutlet UILabel* userName;

@end
