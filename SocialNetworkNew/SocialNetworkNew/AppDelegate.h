//
//  AppDelegate.h
//  SocialNetworkNew
//
//  Created by Ihor Zabrotsky on 10/30/15.
//  Copyright (c) 2015 Ihor Zabrotsky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VKSdk.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;


@end

