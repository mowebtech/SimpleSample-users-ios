//
//  AppDelegate.h
//  SimpleSample-users-ios
//
//  Created by Alexey Voitenko on 24.02.12.
//  Copyright (c) 2012 Injoit Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SplashController;

@interface AppDelegate : UIResponder <UIApplicationDelegate, ActionStatusDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (retain, nonatomic) SplashController* splashController;

@end
