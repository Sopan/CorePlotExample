//
//  SBAppDelegate.h
//  scatter
//
//  Copyright (c) 2012 Sopan Shekhar Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SBAppDelegate : UIResponder <UIApplicationDelegate, UINavigationControllerDelegate>

/*! @property UIWindow *window
 @brief An object of UIWindow.
 */
@property (strong, nonatomic) UIWindow *window;

/*! @property CPTGraphHostingView *hostView
 @brief An object of UINavigationController.
 */
@property (strong, nonatomic) UINavigationController *tabBarController;

@end
